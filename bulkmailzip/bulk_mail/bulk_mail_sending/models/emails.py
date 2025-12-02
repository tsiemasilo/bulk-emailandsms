# coding: utf-8
from sqlalchemy import Boolean, Column, Date, ForeignKey, Integer, String, Text, LargeBinary, DateTime, text
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
# for foreign relationships
from models.companies import tbl_countries
from models.companies import tbl_companies, tbl_company_email_addresses
from models.customers import tbl_customer_groups


Base = declarative_base()
metadata = Base.metadata


class tbl_attachments(Base):
    __tablename__ = 'tbl_attachments'
    __table_args__ = {'schema': 'emails'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('emails.tbl_attachments_id_seq'::regclass)"))
    v_file_name = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_mime_type = Column(String(128), nullable=False, server_default=text("''::character varying"))
    b_file = Column(LargeBinary, nullable=False)
    i_campaign_id = Column(ForeignKey('emails.tbl_campaigns.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))

    i_campaign = relationship('tbl_campaigns')
# end of tbl_attachments ORM model class


class tbl_campaign_customers(Base):
    __tablename__ = 'tbl_campaign_customers'
    __table_args__ = {'schema': 'emails'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('emails.tbl_campaign_customers_id_seq'::regclass)"))
    i_campaign_id = Column(Integer, nullable=False, server_default=text("0"))
    i_customer_id = Column(Integer, nullable=False, server_default=text("0"))
# end of tbl_campaign_customers ORM model class


class tbl_emails(Base):
    __tablename__ = 'tbl_emails'
    __table_args__ = {'schema': 'emails'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('emails.tbl_emails_id_seq'::regclass)"))
    v_title = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_subject = Column(String(128), nullable=False, server_default=text("''::character varying"))
    t_body = Column(Text, nullable=False, server_default=text("''::text"))
    i_company_id = Column(ForeignKey('companies.tbl_companies.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))

    i_company = relationship('tbl_companies')
# end of tbl_emails ORM model class


class tbl_campaigns(Base):
    __tablename__ = 'tbl_campaigns'
    __table_args__ = {'schema': 'emails'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('emails.tbl_campaigns_id_seq'::regclass)"))
    i_company_id = Column(ForeignKey('companies.tbl_companies.id'), nullable=False, server_default=text("0"))
    v_campaign_title = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_description = Column(String(512), nullable=False, server_default=text("''::character varying"))
    i_email_id = Column(ForeignKey('emails.tbl_emails.id'), nullable=False, server_default=text("0"))
    dt_target = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP"))
    v_email_from = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_email_reply_to = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_reference_number = Column(String(64), nullable=False, server_default=text("''::character varying"))
    i_company_email_address_id = Column(ForeignKey('companies.tbl_company_email_addresses.id'), nullable=False, server_default=text("0"))

    i_company_email_address = relationship('tbl_company_email_addresses')
    i_company = relationship('tbl_companies')
    i_email = relationship('tbl_emails')
# end of tbl_campaigns ORM model class




class tbl_campaign_groups(Base):
    __tablename__ = 'tbl_campaign_groups'
    __table_args__ = {'schema': 'emails'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('emails.tbl_campaign_groups_id_seq'::regclass)"))
    i_campaign_id = Column(ForeignKey('emails.tbl_campaigns.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    i_group_id = Column(ForeignKey('customers.tbl_customer_groups.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))

    i_campaign = relationship('tbl_campaigns')
    i_group = relationship('tbl_customer_groups')
# end of tbl_campaign_groups ORM model class
