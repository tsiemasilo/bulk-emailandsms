# coding: utf-8
from sqlalchemy import Boolean, Column, Date, ForeignKey, Integer, String, Text, LargeBinary, DateTime, UUID, SmallInteger, text
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
metadata = Base.metadata


class tbl_queued_emails(Base):
    __tablename__ = 'tbl_queued_emails'
    __table_args__ = {'schema': 'queueing'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('queueing.tbl_emails_id_seq'::regclass)"))
    v_subject = Column(String(128), nullable=False, server_default=text("''::character varying"))
    t_body = Column(Text, nullable=False, server_default=text("''::text"))
    i_company_id = Column(Integer, nullable=False, server_default=text("0"))
    i_campaign_id = Column(Integer, nullable=False, server_default=text("0"))
    dt_target = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP"))
    v_email_from = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_email_reply_to = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_reference_number = Column(String(64), nullable=False, server_default=text("''::character varying"))
    bl_done = Column(Boolean, nullable=False, server_default=text("false"))
    bl_active = Column(Boolean, nullable=False, server_default=text("true"))
    dt_processed = Column(DateTime, nullable=True)
    v_result = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_user_id = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_password = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_server_name = Column(String(128), nullable=False, server_default=text("''::character varying"))
    i_port = Column(Integer, nullable=False, server_default=text("587"))
    bl_secure = Column(Boolean, nullable=False, server_default=text("true"))
    bl_starttls = Column(Boolean, nullable=False, server_default=text("true"))
    dt_started = Column(DateTime, nullable=True)
# end of tbl_queued_emails ORM model class


class tbl_queued_attachments(Base):
    __tablename__ = 'tbl_queued_attachments'
    __table_args__ = {'schema': 'queueing'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('queueing.tbl_queued_attachments_id_seq'::regclass)"))
    i_queued_email_id = Column(ForeignKey('queueing.tbl_queued_emails.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    v_file_name = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_mime_type = Column(String(128), nullable=False, server_default=text("''::character varying"))
    b_file = Column(LargeBinary, nullable=False)

    i_queued_email = relationship('tbl_queued_emails')
# end of tbl_queued_attachments ORM model class


class tbl_queued_customers(Base):
    __tablename__ = 'tbl_queued_customers'
    __table_args__ = {'schema': 'queueing'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('queueing.tbl_queued_customers_id_seq'::regclass)"))
    v_title = Column(String(32), nullable=False, server_default=text("''::character varying"))
    v_first_names = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_last_name = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_mobile_number = Column(String(64), nullable=False, server_default=text("''::character varying"))
    v_email = Column(String(128), nullable=False, server_default=text("''::character varying"))
    i_queued_email_id = Column(ForeignKey('queueing.tbl_queued_emails.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    bl_success = Column(Boolean, nullable=True)
    v_reason = Column(String(64), nullable=False, server_default=text("''::character varying"))
    i_customer_id = Column(ForeignKey('customers.tbl_customers.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    dt_processed = Column(DateTime)

    i_customer = relationship('tbl_customers')
    i_queued_email = relationship('tbl_queued_emails')
# end of tbl_queued_customers ORM model class


class tbl_queued_click_throughs(Base):
    __tablename__ = 'tbl_queued_click_throughs'
    __table_args__ = {'schema': 'queueing'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('queueing.tbl_queued_click_throughs_id_seq'::regclass)"))
    i_queued_email_id = Column(ForeignKey('queueing.tbl_queued_emails.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    v_destination_url = Column(String(256), nullable=False, server_default=text("''::character varying"))
    u_identify = Column(UUID, nullable=False)

    i_queued_email = relationship('tbl_queued_emails')
# end of tbl_queued_click_throughs ORM model class


class tbl_queued_click_through_records(Base):
    __tablename__ = 'tbl_queued_click_through_records'
    __table_args__ = {'schema': 'queueing'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('queueing.tbl_queued_click_through_records_id_seq'::regclass)"))
    i_queued_click_through_id = Column(ForeignKey('queueing.tbl_queued_click_throughs.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    i_queued_customer_id = Column(ForeignKey('queueing.tbl_queued_customers.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    si_count = Column(SmallInteger, nullable=False, server_default=text("'0'::smallint"))
    dt_last = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP"))

    i_queued_click_through = relationship('tbl_queued_click_throughs')
    i_queued_customer = relationship('tbl_queued_customers')
# end of tbl_queued_click_through_records ORM model class