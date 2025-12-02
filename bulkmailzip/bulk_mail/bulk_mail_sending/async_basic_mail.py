#! /usr/bin/python
from dotenv import load_dotenv
import sys, traceback
import email
from email.header import decode_header
from email.parser import Parser
from email.message import EmailMessage
from email.mime.multipart import MIMEMultipart, MIMEBase
from email.mime.text import MIMEText
from email.encoders import encode_base64
import os
from datetime import datetime
import time
from bs4 import BeautifulSoup
import json

# variables and objects
# account credentials
load_dotenv(".env.m")
s_mail_server = os.getenv("MAILCOW_SERVER", "dev.blindza.com")
s_username = os.getenv("USER_ID", "rogerwilco@blindza.xyz")
s_password = os.getenv("PASSWD", "Roger-123")
s_ip_address = "207.180.205.86"
i_port = 25
i_secure_port = 465
i_starttls_port = 587


def except_output(s_where=""):
    exc_type, exc_obj, exc_tb = sys.exc_info()
    s_tb = traceback.format_exc()
    s_why = s_tb.replace("\n  File", "\n----\n  File").replace("'", "|")
    s_what = str(exc_type).replace("'", "|")
    print(s_what, s_why, s_where)
# end of except_output function


def strip_tags(s_html):
    soup = BeautifulSoup(s_html, "html.parser")
    for link in soup.find_all("a"):
        s_url = link.get("href")
        link.append(f" [{s_url}]")
    # end of bs loop through all <a href...
    return soup.get_text().replace("\n\n", "\n")
# end of strip_tags function


def clean(text):
    # clean text for creating a folder
    return "".join(c if c.isalnum() else "_" for c in text)
# end of clean function


def connect_smtp_server(bl_secure:bool = True, bl_starttls:bool = True):
    """instantiate and return different forms of smtp server"""
    global s_username, s_password, s_mail_server, s_ip_address, i_port, i_secure_port, i_starttls_port
    o_server = None
    try:
        if bl_secure:
            context = ssl.create_default_context()
            if bl_starttls:
                o_server = SMTP(s_mail_server, i_starttls_port)
                o_server.starttls() # context=context)
            else:
                o_server = SMTP_SSL(s_mail_server, port=i_secure_port) # , context=context)
            # end of checking if should use starttls or just ssl
        else:
            o_server = SMTP(s_mail_server, i_port)
        # end of basic secure check
        o_server.set_debuglevel(1) # Show SMTP server interactions
        o_server.login(s_username, s_password)
    except Exception as exc:
        except_output(s_where="connect_smtp_server...")
    finally:
        return o_server
    # end of try except
# end of connect_smtp_server function


def smtp_send_plain(l_to, s_subject, s_body, s_from, s_from_name="", bl_secure=True, d_headers:dict = {}):
    global s_username, s_username2, s_password, s_mail_server, i_secure_port
    s_authname = s_from
    s_from = f"{s_from_name} <{s_from}>" if s_from_name!="" else s_from
    email_message = EmailMessage()
    email_message.add_header("From", s_from)
    email_message.add_header("To", ", ".join(l_to))
    email_message.add_header("Subject", s_subject)
    email_message.add_header('X-Priority', '3')  # Urgency, 1 highest, 5 lowest
    for s_key, s_val in d_headers.items():
        email_message.add_header(s_key, s_val)
    # end of possibly adding additional header values
    email_message.set_content(s_body)
    smtp_server = connect_smtp_server()
    smtp_server.sendmail(s_from, l_to, email_message.as_bytes())
    smtp_server.quit()
    return True
# end of smtp_send_plain function


def smtp_send_html(l_to, s_subject, s_body, s_from, s_from_name="", bl_secure=True, d_headers:dict = {}):
    global s_username, s_username2, s_password, s_mail_server, i_secure_port
    s_authname = s_from
    s_from = f"{s_from_name} <{s_from}>" if s_from_name!="" else s_from
    # create multipart MIME email
    email_message = MIMEMultipart("alternative")
    email_message.add_header("From", s_from)
    email_message.add_header("To", ", ".join(l_to))
    # email_message.add_header("Bcc", "nobody@nowhere.com") # Recommended for mass emails
    for s_key, s_val in d_headers.items():
        # email_message.add_header(f"X-{s_key}", s_val)
        email_message[f"X-{s_key}"] = s_val
    # end of possibly adding additional header values
    email_message.add_header("Subject", s_subject)
    email_message.add_header('X-Priority', '3')  # Urgency, 1 highest, 5 lowest
    s_text_part = MIMEText(strip_tags(s_body), "plain")
    s_html_part = MIMEText(f"<html><head></head><body>{s_body}</body></html>", "html")
    # attachments?
    # attachment = open(s_filename, "rb")
    # attachment_part = MIMEBase("application", "octet-stream")
    # attachment_part.set_payload(attachment.read()) # Raw attachment data
    # encode_base64(attachment_part)
    # attachment_part.add_header(f"Content-Disposition", "attachment; filename=\"{s_filename}\"")
    # attach all the parts to the Multipart MIME email
    # apparently last one takes priority?
    email_message.attach(s_text_part)
    email_message.attach(s_html_part)
    # email_message.attach(attachment_part)
    smtp_server = connect_smtp_server()
    smtp_server.set_debuglevel(1) # Show SMTP server interactions
    smtp_server.sendmail(s_from, l_to, email_message.as_bytes()) # .as_string()
    smtp_server.quit()
    return True
# end of smtp_send_html function


def imap_connect(bl_ssl=True):
    """create an IMAP4 class with SSL"""
    global s_mail_server, s_username, s_password
    # create an IMAP4 class
    imap = imaplib.IMAP4_SSL(s_mail_server) if bl_ssl else imaplib.IMAP4(s_mail_server)
    # authenticate
    try:
        imap.login(s_username, s_password)
    except:
        except_output("imap authentication")
        return None
    # end of try-except
    return imap
# end of imap_connect function


def imap_fetch():
    """retrieve message items from server using imap4 SSL protocol"""
    imap = imap_connect()
    imap.select("INBOX")
    status, email_ids = imap.search(None, "ALL")
    if status != "OK": raise Exception(status)
    # result, data = imap.search(None, "UNSEEN")
    l_email_ids = email_ids[0].split()
    # number of top emails to fetch
    i_fetch = 50
    # total number of emails
    i_messages = len(l_email_ids)
    print(f"total number of messages = {i_messages}")#; sys.exit()
    d_messages = {}
    i_max = i_fetch if i_messages>i_fetch else i_messages
    for I in range(0, i_max):
        s_id = l_email_ids[I].decode() if isinstance(l_email_ids[I], bytes) else str(l_email_ids[I])
        d_messages[s_id] = {}
        # fetch the email message by ID
        status, msg_data = imap.fetch(l_email_ids[I], "(RFC822)")
        if status!="OK": raise Exception(f"mail retrieval - {status}")
        raw_email = msg_data[0][1] # The raw email content
        msg = email.message_from_bytes(raw_email)
        d_messages[s_id]["msg"] = msg
        d_messages[s_id]["body"] = msg.get_payload()
        for s_key in ["Return-Path", "Delivered-To", "Received", "Received", "DKIM-Signature", "From", "To", "Content-Type", "Date", "Subject"]:
            d_messages[s_id][s_key] = msg[s_key]
        # end of looping through content keys
    # end of looping through messages
    # generate matching plain-text content for html bodies
    for sk in d_messages:
        if d_messages[sk]["msg"]["Content-type"]=="text/html":
            d_messages[sk]["body_plain"] = strip_tags(d_messages[sk]["body"])
        else:
            d_messages[sk]["body_plain"] = d_messages[sk]["msg"]["body"]
        # end of content_type check
    # end of looping through sk in d_messages
    return (True, d_messages, i_messages, "")
# end of imap_fetch function


def imap_fetch_prior():
    """retrieve message items from server using imap4 SSL protocol"""
    imap = imap_connect()
    imap.select("INBOX")
    status, email_ids = imap.search(None, "ALL")
    if status != "OK": raise Exception(status)
    # result, data = imap.search(None, "UNSEEN")
    l_email_ids = email_ids[0].split()
    # number of top emails to fetch
    i_fetch = 50
    # total number of emails
    i_messages = len(l_email_ids)
    print(f"total number of messages = {i_messages}")#; sys.exit()
    d_messages = {}
    i_max = i_fetch if i_messages>i_fetch else i_messages
    for I in range(0, i_max):
        s_id = str(l_email_ids[I])
        d_messages[s_id] = {}
        # fetch the email message by ID
        status, msg = imap.fetch(l_email_ids[I], "(RFC822)")
        if status!="OK": raise Exception(f"mail retrieval - {status}")
        breakpoint()
        for response in msg:
            if isinstance(response, tuple):
                # parse a bytes email into a message object
                msg = email.message_from_bytes(response[1])
                d_messages[s_id]["msg"] = msg
                # decode the email subject
                s_subject, encoding = decode_header(msg["Subject"])[0]
                if isinstance(s_subject, bytes):
                    # if it's a bytes, decode to str
                    s_subject = s_subject.decode(encoding)
                # end of type check against s_subject - bytes
                s_subject = s_subject.strip()
                d_messages[s_id]["subject"] = s_subject
                # decode email sender
                s_from, encoding = decode_header(msg.get("From"))[0]
                if isinstance(s_from, bytes):
                    s_from = s_from.decode(encoding)
                # end of type check against s_from - bytes
                s_from = s_from.strip()
                d_messages[s_id]["from"] = s_from
                # decode email recipient(s)
                s_to, encoding = decode_header(msg.get("To"))[0]
                if isinstance(s_to, bytes):
                    s_to = s_to.decode(encoding)
                # end of type check against s_to - bytes
                s_to = s_to.strip()
                d_messages[s_id]["to"] = s_to
                if msg.get("CC") is not None:
                    s_cc, encoding = decode_header(msg.get("CC"))[0]
                    if isinstance(s_cc, bytes):
                        s_cc = s_cc.decode(encoding)
                    # end of type check against s_cc - bytes
                    s_cc = s_cc.strip()
                else:
                    s_cc = ""
                # end of checking if CC exists
                d_messages[s_id]["cc"] = s_cc
                if msg.get("BCC") is not None:
                    s_bcc, encoding = decode_header(msg.get("BCC"))[0]
                    if isinstance(s_bcc, bytes):
                        s_bcc = s_bcc.decode(encoding)
                    # end of type check against s_bcc - bytes
                    s_bcc = s_bcc.strip()
                else:
                    s_bcc = ""
                # end of checking if BCC exists
                d_messages[s_id]["bcc"] = s_bcc
                # decode email message ID
                s_message_id = msg.get("Message-ID", None)
                if s_message_id is not None:
                    s_message_id, encoding = decode_header(msg.get("Message-ID"))[0]
                    if isinstance(s_message_id, bytes):
                        s_message_id = s_message_id.decode(encoding)
                    # end of type check against s_message_id - bytes
                else:
                    s_message_id = ""
                # end of making sure message-id was available
                s_message_id = s_message_id.strip()
                d_messages[s_id]["message_id"] = s_message_id
                # pull date-time
                if msg.get("Date", None) is not None:
                    s_date_time, encoding = decode_header(msg.get("Date"))[0]
                    if isinstance(s_date_time, bytes):
                        s_date_time = s_date_time.decode(encoding)
                    # end of type check against s_date_time - bytes
                    try:
                        d_msg = datetime.strptime(s_date_time, "%a, %d %b %Y %H:%M:%S %z")
                    except:
                        # handle additional timezone information at end?
                        s_date_time = " ".join(s_date_time.split(" ")[:-1])
                        d_msg = datetime.strptime(s_date_time, "%a, %d %b %Y %H:%M:%S %z")
                    # end of try-except around datetime formatting
                    s_date_time = d_msg.strftime("%Y-%m-%d %H:%M:%S")
                    d_messages[s_id]["date_time"] = s_date_time
                else:
                    d_messages[s_id]["date_time"] = ""
                # end of checking if date header exists
                # decode Thread-Topic
                s_thread_topic, encoding = decode_header(msg.get("Thread-Topic"))[0] if msg.get("Thread-Topic", None) is not None else ("", "UTF-8")
                if isinstance(s_thread_topic, bytes):
                    s_thread_topic = s_thread_topic.decode(encoding)
                # end of type check against s_thread_topic - bytes
                s_thread_topic = s_thread_topic.strip()
                d_messages[s_id]["thread_topic"] = s_thread_topic
                # decode Thread-Index
                s_thread_index, encoding = decode_header(msg.get("Thread-Index"))[0] if msg.get("Thread-Index", None) is not None else ("", "UTF-8")
                if isinstance(s_message_id, bytes):
                    s_thread_index = s_thread_index.decode(encoding)
                # end of type check against s_thread_index - bytes
                s_thread_index = s_thread_index.strip()
                d_messages[s_id]["thread_index"] = s_thread_index
                s_body = ""
                # if the email message is multipart - has attachments
                if msg.is_multipart():
                    #s_nada = input(f"{s_id} - multipart")
                    # iterate over email parts
                    s_content_type = "text/plain" # default value
                    for part in msg.walk():
                        # extract content type of email
                        s_part_type = part.get_content_type()
                        if s_part_type in ("text/html", "text/plain"):
                            s_content_type = s_part_type if s_content_type!="text/html" else s_content_type
                        # end of checking if part_type text/html or text/plain
                        #s_nada = input(f"{s_id} - content_type - {s_content_type}")
                        s_content_disposition = str(part.get("Content-Disposition"))
                        try:
                            # get the email body
                            s_body = part.get_payload(decode=True).decode()
                        except:
                            pass
                        # end of try-catch for s_body
                        s_body = "except occurred" if s_body=="" else s_body
                        d_messages[s_id]["body"] = s_body.strip()
                        if s_content_type == "text/plain" and "attachment" not in s_content_disposition:
                            # use text/plain emails and skip attachments
                            s_nada = "" # print(s_body)
                        elif "attachment" in s_content_disposition:
                            # extract attachment name
                            s_filename = part.get_filename()
                            if s_filename:
                                s_folder_name = clean(s_subject)
                                s_folder_name = f"{s_id}-{s_folder_name}"
                                if not os.path.isdir(s_folder_name):
                                    # make a folder for this email (named after the subject)
                                    pass # os.mkdir(s_folder_name)
                                # end of checking if subject folder already exists
                                s_filepath = os.path.join(s_folder_name, s_filename)
                                # download attachment and save it
                                # o_file = part.get_payload(decode=True)
                                if not d_messages[s_id].get("attachments", False): d_messages[s_id]["attachments"] = []
                                d_messages[s_id]["attachments"].append(s_filename) # [s_filename, o_file]
                                # open(s_filepath, "wb").write(o_file)
                        # end of checking against text/plain and attachments
                    # end of looping through multipart parts
                    d_messages[s_id]["content_type"] = s_content_type
                else:
                    # extract content type of email
                    s_content_type = msg.get_content_type()
                    d_messages[s_id]["content_type"] = s_content_type
                    #s_nada = input(f"{s_id} - content_type - {s_content_type}")
                    # get the email body
                    s_body = msg.get_payload(decode=True).decode()
                    s_body = s_body.strip()
                    d_messages[s_id]["body"] = s_body.strip()
                    if s_content_type == "text/plain":
                        # print only text email parts
                        s_nada = "" # print(s_body)
                    # end of s_content_type check - text/plain
                # end of initial check if msg.is_multipart
                if s_content_type == "text/html":
                    d_messages[s_id]["body"] = s_body
                # end of s_content_type check - html
            # end of type check of response - tuple
        # end of looping through response in msg
    # end of looping through messages
    # generate matching plain-text content for html bodies
    for sk in d_messages:
        if d_messages[sk]["content_type"]=="text/html":
            d_messages[sk]["body_plain"] = strip_tags(d_messages[sk]["body"])
        else:
            d_messages[sk]["body_plain"] = d_messages[sk]["body"]
        # end of content_type check
    # end of looping through sk in d_messages
    return (True, d_messages, i_messages, "")
# end of imap_fetch_prior function


def imap_fetch_old():
    """retrieve message items from server using imap4 SSL protocol"""
    imap = imap_connect()
    imap.select("INBOX")
    result, data = imap.search(None, "UNSEEN")
    # number of top emails to fetch
    i_fetch = 50
    # total number of emails
    i_messages = int(messages[0])
    print(f"total number of messages = {i_messages}")#; sys.exit()
    d_messages = {}
    for i in range(i_messages, i_messages-i_fetch, -1):
        s_id = str(i)
        d_messages[s_id] = {}
        # fetch the email message by ID
        res, msg = imap.fetch(str(i), "(RFC822)")
        for response in msg:
            if isinstance(response, tuple):
                # parse a bytes email into a message object
                msg = email.message_from_bytes(response[1])
                d_messages[s_id]["msg"] = msg
                # decode the email subject
                s_subject, encoding = decode_header(msg["Subject"])[0]
                if isinstance(s_subject, bytes):
                    # if it's a bytes, decode to str
                    s_subject = s_subject.decode(encoding)
                # end of type check against s_subject - bytes
                s_subject = s_subject.strip()
                d_messages[s_id]["subject"] = s_subject
                # decode email sender
                s_from, encoding = decode_header(msg.get("From"))[0]
                if isinstance(s_from, bytes):
                    s_from = s_from.decode(encoding)
                # end of type check against s_from - bytes
                s_from = s_from.strip()
                d_messages[s_id]["from"] = s_from
                # decode email recipient(s)
                s_to, encoding = decode_header(msg.get("To"))[0]
                if isinstance(s_to, bytes):
                    s_to = s_to.decode(encoding)
                # end of type check against s_to - bytes
                s_to = s_to.strip()
                d_messages[s_id]["to"] = s_to
                if msg.get("CC") is not None:
                    s_cc, encoding = decode_header(msg.get("CC"))[0]
                    if isinstance(s_cc, bytes):
                        s_cc = s_cc.decode(encoding)
                    # end of type check against s_cc - bytes
                    s_cc = s_cc.strip()
                else:
                    s_cc = ""
                # end of checking if CC exists
                d_messages[s_id]["cc"] = s_cc
                if msg.get("BCC") is not None:
                    s_bcc, encoding = decode_header(msg.get("BCC"))[0]
                    if isinstance(s_bcc, bytes):
                        s_bcc = s_bcc.decode(encoding)
                    # end of type check against s_bcc - bytes
                    s_bcc = s_bcc.strip()
                else:
                    s_bcc = ""
                # end of checking if BCC exists
                d_messages[s_id]["bcc"] = s_bcc
                # decode email message ID
                s_message_id, encoding = decode_header(msg.get("Message-ID"))[0]
                if isinstance(s_message_id, bytes):
                    s_message_id = s_message_id.decode(encoding)
                # end of type check against s_message_id - bytes
                s_message_id = s_message_id.strip()
                d_messages[s_id]["message_id"] = s_message_id
                # pull date-time
                if msg.get("Date", None) is not None:
                    s_date_time, encoding = decode_header(msg.get("Date"))[0]
                    if isinstance(s_date_time, bytes):
                        s_date_time = s_date_time.decode(encoding)
                    # end of type check against s_date_time - bytes
                    try:
                        d_msg = datetime.strptime(s_date_time, "%a, %d %b %Y %H:%M:%S %z")
                    except:
                        # handle additional timezone information at end?
                        s_date_time = " ".join(s_date_time.split(" ")[:-1])
                        d_msg = datetime.strptime(s_date_time, "%a, %d %b %Y %H:%M:%S %z")
                    # end of try-except around datetime formatting
                    s_date_time = d_msg.strftime("%Y-%m-%d %H:%M:%S")
                    d_messages[s_id]["date_time"] = s_date_time
                else:
                    d_messages[s_id]["date_time"] = ""
                # end of checking if date header exists
                # decode Thread-Topic
                s_thread_topic, encoding = decode_header(msg.get("Thread-Topic"))[0] if msg.get("Thread-Topic", None) is not None else ("", "UTF-8")
                if isinstance(s_thread_topic, bytes):
                    s_thread_topic = s_thread_topic.decode(encoding)
                # end of type check against s_thread_topic - bytes
                s_thread_topic = s_thread_topic.strip()
                d_messages[s_id]["thread_topic"] = s_thread_topic
                # decode Thread-Index
                s_thread_index, encoding = decode_header(msg.get("Thread-Index"))[0] if msg.get("Thread-Index", None) is not None else ("", "UTF-8")
                if isinstance(s_message_id, bytes):
                    s_thread_index = s_thread_index.decode(encoding)
                # end of type check against s_thread_index - bytes
                s_thread_index = s_thread_index.strip()
                d_messages[s_id]["thread_index"] = s_thread_index
                s_body = ""
                # if the email message is multipart - has attachments
                if msg.is_multipart():
                    #s_nada = input(f"{s_id} - multipart")
                    # iterate over email parts
                    s_content_type = "text/plain" # default value
                    for part in msg.walk():
                        # extract content type of email
                        s_part_type = part.get_content_type()
                        if s_part_type in ("text/html", "text/plain"):
                            s_content_type = s_part_type if s_content_type!="text/html" else s_content_type
                        # end of checking if part_type text/html or text/plain
                        #s_nada = input(f"{s_id} - content_type - {s_content_type}")
                        s_content_disposition = str(part.get("Content-Disposition"))
                        try:
                            # get the email body
                            s_body = part.get_payload(decode=True).decode()
                        except:
                            pass
                        # end of try-catch for s_body
                        s_body = "except occurred" if s_body=="" else s_body
                        d_messages[s_id]["body"] = s_body.strip()
                        if s_content_type == "text/plain" and "attachment" not in s_content_disposition:
                            # use text/plain emails and skip attachments
                            s_nada = "" # print(s_body)
                        elif "attachment" in s_content_disposition:
                            # extract attachment name
                            s_filename = part.get_filename()
                            if s_filename:
                                s_folder_name = clean(s_subject)
                                s_folder_name = f"{s_id}-{s_folder_name}"
                                if not os.path.isdir(s_folder_name):
                                    # make a folder for this email (named after the subject)
                                    pass # os.mkdir(s_folder_name)
                                # end of checking if subject folder already exists
                                s_filepath = os.path.join(s_folder_name, s_filename)
                                # download attachment and save it
                                # o_file = part.get_payload(decode=True)
                                if not d_messages[s_id].get("attachments", False): d_messages[s_id]["attachments"] = []
                                d_messages[s_id]["attachments"].append(s_filename) # [s_filename, o_file]
                                # open(s_filepath, "wb").write(o_file)
                        # end of checking against text/plain and attachments
                    # end of looping through multipart parts
                    d_messages[s_id]["content_type"] = s_content_type
                else:
                    # extract content type of email
                    s_content_type = msg.get_content_type()
                    d_messages[s_id]["content_type"] = s_content_type
                    #s_nada = input(f"{s_id} - content_type - {s_content_type}")
                    # get the email body
                    s_body = msg.get_payload(decode=True).decode()
                    s_body = s_body.strip()
                    d_messages[s_id]["body"] = s_body.strip()
                    if s_content_type == "text/plain":
                        # print only text email parts
                        s_nada = "" # print(s_body)
                    # end of s_content_type check - text/plain
                # end of initial check if msg.is_multipart
                if s_content_type == "text/html":
                    d_messages[s_id]["body"] = s_body
                # end of s_content_type check - html
            # end of type check of response - tuple
        # end of looping through response in msg
    # end of looping through messages
    # generate matching plain-text content for html bodies
    for sk in d_messages:
        if d_messages[sk]["content_type"]=="text/html":
            d_messages[sk]["body_plain"] = strip_tags(d_messages[sk]["body"])
        else:
            d_messages[sk]["body_plain"] = d_messages[sk]["body"]
        # end of content_type check
    # end of looping through sk in d_messages
    return (True, d_messages, i_messages, "")
# end of imap_fetch_old function


def pop_connect(bl_ssl=False):
    """create a pop3 class with possible SSL"""
    global s_mail_server, s_username, s_password
    # create a pop3 instance with or without SSL
    pop = None
    if bl_ssl:
        pop = poplib.POP3_SSL(s_mail_server)
    else:
           pop = poplib.POP3(s_mail_server)
    # end of ssl check
    pop.set_debuglevel(1) # just for testing at moment - step output to console
    # pop3 authenticate
    try:
        pop.user(s_username)
        pop.pass_(s_password)
    except:
        except_output("pop3 authentication")
        return None
    # end of try-except
    return pop
# end of pop_connect function


def pop_fetch(bl_ssl=True):
    """fetch messages from server using POP3, by default including SSL security"""
    pop = pop_connect(bl_ssl)
    status, messages, octs = pop.list()
    # number of top emails to fetch
    i_fetch = 50
    # total number of emails
    i_messages = len(messages)
    print(f"total number of messages = {i_messages}")#; sys.exit()
    d_messages = {}
    i_time_start = time.time()
    i_count = 0
    for i in range(i_messages, i_messages-i_fetch, -1):
        i_count = i_count + 1
        print(i_count)
        s_id = str(i)
        d_messages[s_id] = {}
        # fetch the email message by ID
        resp, lines, octets = pop.retr(i)
        msg_content = b'\r\n'.join(lines).decode('utf-8')
        msg = Parser().parsestr(msg_content)
        try:
            # decode the email subject
            s_subject, encoding = decode_header(msg["Subject"])[0]
            if isinstance(s_subject, bytes):
                # if it's a bytes, decode to str
                s_subject = s_subject.decode(encoding)
            # end of type check against s_subject - bytes
            s_subject = s_subject.strip()
            d_messages[s_id]["subject"] = s_subject
            # decode email sender
            s_from, encoding = decode_header(msg.get("From"))[0]
            if isinstance(s_from, bytes):
                s_from = s_from.decode(encoding)
            # end of type check against s_from - bytes
            s_from = s_from.strip()
            d_messages[s_id]["from"] = s_from
            # decode email recipient(s)
            s_to, encoding = decode_header(msg.get("To"))[0]
            if isinstance(s_to, bytes):
                s_to = s_to.decode(encoding)
            # end of type check against s_to - bytes
            s_to = s_to.strip()
            d_messages[s_id]["to"] = s_to
            if msg.get("CC") is not None:
                s_cc, encoding = decode_header(msg.get("CC"))[0]
                if isinstance(s_cc, bytes):
                    s_cc = s_cc.decode(encoding)
                # end of type check against s_cc - bytes
                s_cc = s_cc.strip()
            else:
                s_cc = ""
            # end of checking if CC exists
            d_messages[s_id]["cc"] = s_cc
            if msg.get("BCC") is not None:
                s_bcc, encoding = decode_header(msg.get("BCC"))[0]
                if isinstance(s_bcc, bytes):
                    s_bcc = s_bcc.decode(encoding)
                # end of type check against s_bcc - bytes
                s_bcc = s_bcc.strip()
            else:
                s_bcc = ""
            # end of checking if BCC exists
            d_messages[s_id]["bcc"] = s_bcc
            # decode email message ID
            s_message_id, encoding = decode_header(msg.get("Message-ID"))[0]
            if isinstance(s_message_id, bytes):
                s_message_id = s_message_id.decode(encoding)
            # end of type check against s_message_id - bytes
            s_message_id = s_message_id.strip()
            d_messages[s_id]["message_id"] = s_message_id
            # pull date-time
            if msg.get("Date", None) is not None:
                s_date_time, encoding = decode_header(msg.get("Date"))[0]
                if isinstance(s_date_time, bytes):
                    s_date_time = s_date_time.decode(encoding)
                # end of type check against s_date_time - bytes
                try:
                    d_msg = datetime.strptime(s_date_time, "%a, %d %b %Y %H:%M:%S %z")
                except:
                    # handle additional timezone information at end?
                    s_date_time = " ".join(s_date_time.split(" ")[:-1])
                    d_msg = datetime.strptime(s_date_time, "%a, %d %b %Y %H:%M:%S %z")
                # end of try-except around datetime formatting
                s_date_time = d_msg.strftime("%Y-%m-%d %H:%M:%S")
                d_messages[s_id]["date_time"] = s_date_time
            else:
                d_messages[s_id]["date_time"] = ""
            # end of checking if date header exists
            # decode Thread-Topic
            s_thread_topic, encoding = decode_header(msg.get("Thread-Topic"))[0] if msg.get("Thread-Topic", None) is not None else ("", "UTF-8")
            if isinstance(s_thread_topic, bytes):
                s_thread_topic = s_thread_topic.decode(encoding)
            # end of type check against s_thread_topic - bytes
            s_thread_topic = s_thread_topic.strip()
            d_messages[s_id]["thread_topic"] = s_thread_topic
            # decode Thread-Index
            s_thread_index, encoding = decode_header(msg.get("Thread-Index"))[0] if msg.get("Thread-Index", None) is not None else ("", "UTF-8")
            if isinstance(s_message_id, bytes):
                s_thread_index = s_thread_index.decode(encoding)
            # end of type check against s_thread_index - bytes
            s_thread_index = s_thread_index.strip()
            d_messages[s_id]["thread_index"] = s_thread_index
        except:
            except_output()
            breakpoint()
        # end of try-except around header extraction
        s_body = ""
        # if the email message is multipart - has attachments
        if msg.is_multipart():
            #s_nada = input(f"{s_id} - multipart")
            # iterate over email parts
            s_content_type = "text/plain" # default value
            for part in msg.walk():
                # extract content type of email
                s_part_type = part.get_content_type()
                if s_part_type in ("text/html", "text/plain"):
                    s_content_type = s_part_type if s_content_type!="text/html" else s_content_type
                # end of checking if part_type text/html or text/plain
                #s_nada = input(f"{s_id} - content_type - {s_content_type}")
                s_content_disposition = str(part.get("Content-Disposition"))
                try:
                    # get the email body
                    s_body = part.get_payload(decode=True).decode()
                except:
                    pass
                # end of try-catch for s_body
                s_body = "except occurred" if s_body=="" else s_body
                d_messages[s_id]["body"] = s_body.strip()
                if s_content_type == "text/plain" and "attachment" not in s_content_disposition:
                    # use text/plain emails and skip attachments
                    s_nada = "" # print(s_body)
                elif "attachment" in s_content_disposition:
                    # download attachment
                    s_filename = part.get_filename()
                    if s_filename:
                        s_folder_name = clean(s_subject)
                        s_folder_name = f"{s_id}-{s_folder_name}"
                        if not os.path.isdir(s_folder_name):
                            # make a folder for this email (named after the subject)
                            pass # os.mkdir(s_folder_name)
                        # end of checking if subject folder already exists
                        s_filepath = os.path.join(s_folder_name, s_filename)
                        # download attachment and save it
                        # o_file = part.get_payload(decode=True)
                        if not d_messages[s_id].get("attachments", False): d_messages[s_id]["attachments"] = []
                        d_messages[s_id]["attachments"].append(s_filename) # [s_filename, o_file]
                        #open(s_filepath, "wb").write(o_file)
                # end of checking against text/plain and attachments
            # end of looping through multipart parts
            d_messages[s_id]["content_type"] = s_content_type
        else:
            # extract content type of email
            s_content_type = msg.get_content_type()
            d_messages[s_id]["content_type"] = s_content_type
            #s_nada = input(f"{s_id} - content_type - {s_content_type}")
            # get the email body
            s_body = msg.get_payload(decode=True).decode()
            s_body = s_body.strip()
            d_messages[s_id]["body"] = s_body.strip()
            if s_content_type == "text/plain":
                # print only text email parts
                s_nada = "" # print(s_body)
            # end of s_content_type check - text/plain
        # end of initial check if msg.is_multipart
        if s_content_type == "text/html":
            d_messages[s_id]["body"] = s_body
        # end of s_content_type check - html
    # end of looping through messages
    i_time_end = time.time()
    print("total of " + str(int(i_time_end-i_time_start)) + f" seconds for {i_fetch} messages")
    s_nada = input("?")
    # close the connection and logout
    pop.close()
    #pop.logout()
    # generate matching plain-text content for html bodies
    for sk in d_messages:
        if d_messages[sk]["content_type"]=="text/html":
            d_messages[sk]["body_plain"] = strip_tags(d_messages[sk]["body"])
        else:
            d_messages[sk]["body_plain"] = d_messages[sk]["body"]
        # end of content_type check
    # end of looping through sk in d_messages
    return (True, d_messages, i_messages, "")
# end of pop_fetch function


# smtp_send_html(["rogerwilco@blindza.com"], "Sending to self", "<div>Hello ...</div>", "rogerwilco@blindza.com", "Roger Wilco", d_headers={"closet": "janitor"})


def imap_tools_mailbox():
    global s_username, s_password, s_mail_server
    # https://pypi.org/project/imap-tools/
    # https://github.com/ikvk/imap_tools/
    # https://notes.nicolasdeville.com/python/library-imap-tools/
    from imap_tools import MailBox, AND, H
    d_messages = {}
    with MailBox(s_mail_server).login(s_username, s_password) as mailbox:
        # mailbox.fetch(H("header-key", "header-value"))...?
        for s_id in list(mailbox.uids()):
            d_messages[s_id] = list(mailbox.fetch(s_id))[0]
        # end of looping through ids
    # end of with for mailbox
    return d_messages
# end of imap_tools_mailbox function



def check_mails():
    global s_username, s_password, s_mail_server
    s_mailboxes = open("z_mailboxes.json", "r").read()
    l_mailboxes = json.loads(s_mailboxes)
    for ix, t in enumerate(l_mailboxes):
        print(f"{ix} - {t[0]}")
    # end of looping through mailboxes
    i_choice = int(input("choose mailbox to review?"))
    s_username, s_password = (f"{l_mailboxes[i_choice][0]}@blindza.xyz", l_mailboxes[i_choice][1])
    d_mails = imap_tools_mailbox()
    print(f"total of {len(d_mails)} mails")
    for sk, o_mail in d_mails.items():
        print(o_mail.subject)
    # end of looping through mail items
    return d_mails
# end of check_mails function


# smtplib examples, etc. https://mailtrap.io/blog/smtplib/
