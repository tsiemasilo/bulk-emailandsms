#! /usr/bin/python3
import os, threading, re, gc
from dotenv import load_dotenv
import asyncio
import time
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
from email.mime.multipart import MIMEMultipart
import aiosmtplib
from datetime import datetime, timedelta, timezone
from db_con import *
from models.combined import *
from sqlalchemy import update, insert
from bunch_py3 import *
import sys, traceback
from loguru import logger
from bs4 import BeautifulSoup

load_dotenv()
logger.remove() # clear|remove all logger bindings
s_logger_output = "logging/bulk_mail.log" #if os.getenv("LOG", "stderr")=="file" else "stderr"
s_logger_output=="stderr" ### temporarily
s_debug_level = os.getenv("DEBUG", "TRACE")
s_rotation = os.getenv("LOG_ROTATION", "5 minutes")# "00:00" # daily
s_retention = os.getenv("LOG_RETENTION", "10 minutes")# "1 day" "1 week"
if s_logger_output=="stderr":
    logger.add(sys.stderr, format="{time:YYYY-MM-DD HH:mm:ss} | {level} | {name}:{line}\n  {message}\n{extra}\n----\n", level=s_debug_level)
else:
    logger.add(s_logger_output, format="{time:YYYY-MM-DD HH:mm:ss} | {level} | {name}:{line}\n  {message}\n{extra}\n----\n", level=s_debug_level,
        rotation=s_rotation, retention=s_retention
    )
# end of checking which logging type
process_logger = None

db, session = (None, None)
s_db_server = os.getenv("DB_SERVER", "localhost")
s_db_name = os.getenv("DB_NAME", "bulk_mail")
s_db_uid = os.getenv("DB_UID", "bulkmail_user")
s_db_pwd = os.getenv("DB_PWD", "bUlK-123")
s_db_uri = f"postgresql://{s_db_uid}:{s_db_pwd}@{s_db_server}:5432/{s_db_name}"
# Batching & Throttling Configuration
i_batch_size = int(os.getenv("BATCH_SIZE", 5)) # Number of emails per batch
i_delay = int(os.getenv("DELAY", 10)) # Delay between batches (in seconds)


# default smtp Configuration
s_smtp_server = os.getenv("MAILCOW_SERVER", "dev.blindza.com")
i_smtp_port = int(os.getenv("SMTP_PORT", 587))
s_username = "rogerwilco@blindza.xyz"
s_password = "wilco"

def except_output(s_where=""):
    global logger, s_debug_level
    exc_type, exc_obj, exc_tb = sys.exc_info()
    s_tb = traceback.format_exc()
    s_why = s_tb.replace("\n  File", "\n----\n  File").replace("'", "|")
    s_what = str(exc_type).replace("'", "|")
    if (s_debug_level=="DEBUG" or s_debug_level=="TRACE"): pass # print(s_what, s_why, s_where)
    return (s_what, s_why, s_where)
# end of except_output function


def strip_tags(s_html):
    soup = BeautifulSoup(s_html, "html.parser")
    for link in soup.find_all("a"):
        s_url = link.get("href")
        link.append(f" [{s_url}]")
    # end of bs loop through all <a href...
    return soup.get_text().replace("\n\n", "\n")
# end of strip_tags function


### sample code
SENDER_EMAIL = "your_email@example.com"
RECIPIENT_LIST = ["user1@example.com", "user2@example.com", "user3@example.com", "user4@example.com", "user5@example.com"]

d_results = {}
global_lock = threading.Lock()
# thread-Safe Update
def update_results(i_queued_id:int, s_good_bad:str = "good", i_qc_id:int = 0, s_email:str = "", s_additional:str = ""):
    global d_results
    with global_lock:
        dt_processed = datetime.now().astimezone(timezone(timedelta(hours=2)))
        d_results[i_queued_id]["customer_results"][s_good_bad].append((i_qc_id, s_email, s_additional, dt_processed))
    # end of with global_lock
# end of update_results function


# Async function to send an email using an existing SMTP connection
async def send_email_async(s_email, s_name, s_from, s_reply_to, s_subject, s_body, l_attachments, i_queued_id, i_qc_id, smtp):
    global process_logger
    with process_logger.contextualize(sub_process="send_email_async function"):
        try:
            message = MIMEMultipart()
            message["From"] = s_from
            if s_reply_to!="": message["Reply-To"] = s_reply_to
            message["To"] = s_email
            message["Subject"] = s_subject
            message.attach(MIMEText(s_body, "html"))
            s_plain = strip_tags(s_body)
            message.attach(MIMEText(s_plain, "text"))
            if len(l_attachments)>0:
                for attachment in l_attachments:
                    part = MIMEBase("application", "octet-stream")
                    part.set_payload(attachment.b_file)
                    encoders.encode_base64(part)
                    part.add_header("Content-Disposition", f"attachment; filename={attachment.v_file_name}")
                    message.attach(part)
                # end of looping through attachments
            # end of checking length of attachments
            try:
                await smtp.send_message(message)
                # print(f"email sent to {s_email}")
                update_results(i_queued_id, "good", i_qc_id, s_email)
            except (aiosmtplib.SMTPRecipientsRefused, aiosmtplib.SMTPSenderRefused) as e:
                # print(f"bad recipient {s_email}: {e}")
                update_results(i_queued_id, "bad", i_qc_id, s_email, str(e))
            except Exception as exc:
                # print(f" Failed to send email to {s_email}: {exc}")
                update_results(i_queued_id, "bad", i_qc_id, s_email)
            # end of try-except for email specific errors
        except Exception as exc:
            process_logger.error(except_output(s_where="send_email_async function"))
        # end of outer try-except
    # end of with process_logger context
# end of send_email_async function


# Function to process a batch asynchronously (with one SMTP connection per batch)
async def process_batch(batch:list, s_subject:str, s_body:str, l_attachments:list, bl_placeholders:bool = False, d_server_details: dict = {}, i_queued_id:int = 0, l_click_throughs:list = []):
    global d_results, process_logger
    with process_logger.contextualize(sub_process="process_batch function"):
        try:
            s_server, i_port, bl_secure, bl_starttls, s_user_id, s_password, s_from, s_reply_to = (d_server_details["server_name"], d_server_details["port"], d_server_details["secure"], d_server_details["starttls"], d_server_details["user_id"], d_server_details["password"], d_server_details["from"], d_server_details["reply_to"])
            # preferably run under starttls or else tls
            bl_secure = False if bl_starttls else bl_secure######
            # bl_starttls = False if bl_secure else bl_starttls######
            smtp = aiosmtplib.SMTP(hostname=s_server, port=i_port, use_tls=bl_secure, start_tls=bl_starttls, validate_certs=False, timeout=180)
            await smtp.connect()
            await smtp.login(s_user_id, s_password)
            process_logger.info(smtp.is_connected)
            # prep contents per recipient
            l_tasks = []
            for recipient in batch:
                s_recipient_body = s_body
                if bl_placeholders:
                    for sk in ["title", "full_names", "mobile"]: s_recipient_body = s_recipient_body.replace(f"||{sk}||", recipient[sk])
                # end of checking if need to personalise content
                # add customer ID to click-through URL:
                for s_uuid in l_click_throughs:
                    s_recipient_body = s_recipient_body.replace(s_uuid, f"{s_uuid}/{recipient['id']}/")
                # end of adding onto click-through urls
                s_email = recipient["v_email"]
                s_name = " ".join([recipient["v_first_names"], recipient["v_last_name"]])
                i_qc_id = recipient["id"]
                l_tasks.append(send_email_async(s_email, s_name, s_from, s_reply_to, s_subject, s_recipient_body, l_attachments, i_queued_id, i_qc_id, smtp))
            # end of looping through batch of recipients
            await asyncio.gather(*l_tasks)
            try:
                await smtp.quit()
                await smtp.close()
            except Exception as exc:
                pass
            finally:
                gc.collect()
            # end of try-except around smtp quitting
        except Exception as exc:
            process_logger.error(except_output(s_where="process_batch"))
        # end of try-except
    # end of with process_logger context
# end of process_batch function


# Thread-safe wrapper to run async function inside a thread
def run_async_task(batch:list, s_subject:str, s_body:str, l_attachments:list, bl_placeholders:bool = False, d_server_details:dict = {}, i_queued_id:int = 0, l_click_throughs:list = []):
    global d_results, process_logger
    with process_logger.contextualize(sub_process="run_async_task"):
        try:
            loop = asyncio.new_event_loop()
            asyncio.set_event_loop(loop)
            loop.run_until_complete(process_batch(batch, s_subject, s_body, l_attachments, bl_placeholders, d_server_details, i_queued_id, l_click_throughs))
        except Exception as exc:
            process_logger.error(except_output("run_async_task function"))
        # end of try-except around all functionality
    # end of with process_logger context
# end of run_async_task function


# Function to handle batching & threading
def send_emails_in_batches(o_queued:object) -> tuple:
    global i_batch_size, i_delay, d_results, process_logger
    with process_logger.contextualize(sub_process="send_emails_in_batches function"):
        try:
            d_server_details = {"server_name": o_queued.v_server_name, "user_id": o_queued.v_user_id, "password": o_queued.v_password, "port": o_queued.i_port, "secure": o_queued.bl_secure, "starttls": o_queued.bl_starttls, "from": o_queued.v_email_from, "reply_to": o_queued.v_email_reply_to}
            d_results[o_queued.id]["customer_results"] = {"good": [], "bad": []}
            l_threads = []
            for i in range(0, len(o_queued.l_customers), i_batch_size):
                batch = o_queued.l_customers[i : i + i_batch_size]
                # Create a new thread for each batch
                thread = threading.Thread(target=run_async_task, args=(batch, o_queued.v_subject, o_queued.t_body, o_queued.l_attachments, o_queued.bl_placeholders, d_server_details, o_queued.id, o_queued.l_click_throughs))
                thread.start()
                l_threads.append(thread)
                # print(f" Batch {i // i_batch_size + 1} started.")
                time.sleep(i_delay)  # Prevent hitting SMTP rate limits
            # end of looping through batch chunks
            for thr in l_threads:
                thr.join()
            # end of waiting for all to complete
            return (True, "All batches processed")
        except Exception as exc:
            process_logger.error(except_output("send_emails_in_batches function"))
        # end of try-except around all functionality
    # end of with process_logger context
# end of send_emails_in_batches function


def main(l_queued):
    global db, session, process_logger, d_results
    bl_out, s_out, l_results = (False, "", [])
    with process_logger.contextualize(sub_process="main function"):
        try:
            s_out = f"total of {len(l_queued)} queued items"
            process_logger.info(s_out)
            for ix, o_queued in enumerate(l_queued):
                d_results[o_queued.id] = {}
                o_queued.bl_placeholders = True if (o_queued.t_body.count("||title||")>0 or o_queued.t_body.count("||full_names||")>0 or o_queued.t_body.count("||mobile||")>0) else False
                l_attachments = list(map(bunchify, map(dict_instance, session.query(tbl_queued_attachments).filter(tbl_queued_attachments.i_queued_email_id==o_queued.id).all())))
                o_queued.l_attachments = l_attachments if len(l_attachments)>0 else []
                l_customers = list(map(dict_instance, session.query(tbl_queued_customers).filter(tbl_queued_customers.i_queued_email_id==o_queued.id).all()))
                if o_queued.bl_placeholders:
                    for ix, d_cust in enumerate(l_customers):
                        d_cust["title"] = str(d_cust["v_title"]).strip()
                        d_cust["full_names"] = " ".join([d_cust["v_first_names"], d_cust["v_last_name"]]).strip()
                        d_cust["mobile"] = str(d_cust["v_mobile_number"]).strip()
                        l_customers[ix] = d_cust
                    # end of enumerating through l_customers
                # end of checking if need to populate placeholder key-value pairs
                o_queued.l_customers = l_customers if len(l_customers)>0 else []
                # click through values
                l_click_throughs = list(map((lambda x : str(x[0])), map(tuple, session.query(tbl_queued_click_throughs.u_identify).filter(tbl_queued_click_throughs.i_queued_email_id==o_queued.id).all())))
                o_queued.l_click_throughs = l_click_throughs
                d_results[o_queued.id]["total_customers"] = len(o_queued.l_customers)
                dt_started = datetime.now().astimezone(timezone(timedelta(hours=2)))
                d_results[o_queued.id]["dt_started"] = dt_started
                s_result = ""
                if len(o_queued.l_customers)>0:
                    t_queue_result = send_emails_in_batches(o_queued)
                    s_result = t_queue_result[1]
                else:
                    s_result = "there were 0 recipients assigned"
                # end of making sure there are assigned customer recipients
                dt_processed = datetime.now().astimezone(timezone(timedelta(hours=2)))
                d_results[o_queued.id]["dt_processed"] = dt_processed
                l_results.append(f"ID {o_queued.id} - {s_result}")
            # end of looping through queued campaigns
            bl_out = True
            s_out = "all queued campaigns worked through"
        except Exception as exc:
            process_logger.error(except_output("main function"))
        # end of try-except around all functionality
    # end of with process_logger context
    return (bl_out, s_out)
# end of main function


def process_results() -> bool:
    """process results at end of campaign and batch processing to make sure database records are up-to-date"""
    global d_results, db, session
    for i_queued_id, d_result in d_results.items():
        i_total_customers = d_result["total_customers"]
        d_customer_results_good_bad = d_result.get("customer_results", {"good": [], "bad": []})
        i_good_count = len(d_customer_results_good_bad.get("good", []))
        i_bad_count = len(d_customer_results_good_bad.get("bad", []))
        dt_started = d_result["dt_started"]
        dt_processed = d_result["dt_processed"]
        # update tbl_queued_emails record
        session.execute(update(tbl_queued_emails).where(tbl_queued_emails.id==i_queued_id).values({"bl_done": True, "dt_processed": dt_processed, "v_result": f"total of {i_total_customers} - {i_good_count} 'good' and {i_bad_count} 'bad'", "dt_started": dt_started}))
        # update tbl_queued_customers records
        q_update_customer = update(tbl_queued_customers)
        for t_customer in d_customer_results_good_bad["good"]:
            session.execute(q_update_customer.where(tbl_queued_customers.id==t_customer[0]).values({"bl_success": True, "dt_processed": t_customer[3]}))
        # end of looping through good customers
        for t_customer in d_customer_results_good_bad["bad"]:
            session.execute(q_update_customer.where(tbl_queued_customers.id==t_customer[0]).values({"bl_success": False, "v_reason": t_customer[2][:128], "dt_processed": t_customer[3]}))
        # end of looping through bad customers
        session.commit()
    # end of looping through d_results items
    return True
# end of process_results function

if __name__=="__main__":
    process_logger = logger.bind(name_="__main__")
    db, session = connect_db(s_db_uri)
    # just for testing
    # session.execute(update(tbl_queued_emails).where(tbl_queued_emails.id>18).values({"bl_done": False, "dt_processed": None}))
    # session.commit()
    dt_now = datetime.now()
    dt_now = dt_now + timedelta(weeks=4) ### just for testing
    l_queued = session.query(tbl_queued_emails).filter(tbl_queued_emails.dt_target<=dt_now, tbl_queued_emails.bl_done==False, tbl_queued_emails.bl_active==True).order_by(tbl_queued_emails.dt_target, tbl_queued_emails.id).all()
    l_queued = list(map(bunchify, map(dict_instance, l_queued)))
    d_results = {}
    t_result = main(l_queued)
    # work through all results
    while len(d_results)<len(l_queued):
        # print("waiting...")
        time.sleep(5)
    # end of while loop to make sure all processed/done
    process_results()
    logger.info("done!", extra=t_result[1])
# end of __name__ check

