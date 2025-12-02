import app, sys
from app.extensions import db
from sqlalchemy import text
from sqlalchemy.ext.declarative import declarative_base
from .customers import tbl_customers

Base = declarative_base()
metadata = Base.metadata


class tbl_queued_emails(db.Model):
    __tablename__ = 'tbl_queued_emails'
    __table_args__ = {'schema': 'queueing'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('queueing.tbl_emails_id_seq'::regclass)"))
    v_subject = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    t_body = db.Column(db.Text, nullable=False, server_default=text("''::text"))
    i_company_id = db.Column(db.Integer, nullable=False, server_default=text("0"))
    i_campaign_id = db.Column(db.Integer, nullable=False, server_default=text("0"))
    dt_target = db.Column(db.DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP"))
    v_email_from = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_email_reply_to = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_reference_number = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    bl_done = db.Column(db.Boolean, nullable=False, server_default=text("false"))
    bl_active = db.Column(db.Boolean, nullable=False, server_default=text("true"))
    dt_processed = db.Column(db.DateTime, nullable=True)
    v_result = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_user_id = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_password = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_server_name = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    i_port = db.Column(db.Integer, nullable=False, server_default=text("587"))
    bl_secure = db.Column(db.Boolean, nullable=False, server_default=text("true"))
    bl_starttls = db.Column(db.Boolean, nullable=False, server_default=text("true"))
    dt_started = db.Column(db.DateTime, nullable=True)
# end of tbl_queued_emails ORM model class


class tbl_queued_attachments(db.Model):
    __tablename__ = 'tbl_queued_attachments'
    __table_args__ = {'schema': 'queueing'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('queueing.tbl_queued_attachments_id_seq'::regclass)"))
    i_queued_email_id = db.Column(db.ForeignKey('queueing.tbl_queued_emails.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    v_file_name = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_mime_type = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    b_file = db.Column(db.LargeBinary, nullable=False)

    i_queued_email = db.relationship('tbl_queued_emails')
# end of tbl_queued_attachments ORM model class


class tbl_queued_customers(db.Model):
    __tablename__ = 'tbl_queued_customers'
    __table_args__ = {'schema': 'queueing'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('queueing.tbl_queued_customers_id_seq'::regclass)"))
    v_title = db.Column(db.String(32), nullable=False, server_default=text("''::character varying"))
    v_first_names = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_last_name = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_mobile_number = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    v_email = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    i_queued_email_id = db.Column(db.ForeignKey('queueing.tbl_queued_emails.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    bl_success = db.Column(db.Boolean, nullable=True)
    v_reason = db.Column(db.String(256), nullable=False, server_default=text("''::character varying"))
    i_customer_id = db.Column(db.ForeignKey('customers.tbl_customers.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    dt_processed = db.Column(db.DateTime)

    i_customer = db.relationship('tbl_customers')
    i_queued_email = db.relationship('tbl_queued_emails')
# end of tbl_queued_customers ORM model class


class tbl_queued_click_throughs(db.Model):
    __tablename__ = 'tbl_queued_click_throughs'
    __table_args__ = {'schema': 'queueing'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('queueing.tbl_queued_click_throughs_id_seq'::regclass)"))
    i_queued_email_id = db.Column(db.ForeignKey('queueing.tbl_queued_emails.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    v_destination_url = db.Column(db.String(256), nullable=False, server_default=text("''::character varying"))
    u_identify = db.Column(db.UUID, nullable=False)

    i_queued_email = db.relationship('tbl_queued_emails')
# end of tbl_queued_email_click_throughs ORM model class


class tbl_queued_click_through_records(db.Model):
    __tablename__ = 'tbl_queued_click_through_records'
    __table_args__ = {'schema': 'queueing'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('queueing.tbl_queued_click_through_records_id_seq'::regclass)"))
    i_queued_click_through_id = db.Column(db.ForeignKey('queueing.tbl_queued_click_throughs.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    i_queued_customer_id = db.Column(db.ForeignKey('queueing.tbl_queued_customers.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    si_count = db.Column(db.SmallInteger, nullable=False, server_default=text("'0'::smallint"))
    dt_last = db.Column(db.DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP"))

    i_queued_click_through = db.relationship('tbl_queued_click_throughs')
    i_queued_customer = db.relationship('tbl_queued_customers')
# end of tbl_queued_click_through_records ORM model class
