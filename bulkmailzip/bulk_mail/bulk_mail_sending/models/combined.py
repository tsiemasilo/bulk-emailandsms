# coding: utf-8
from sqlalchemy import Boolean, Column, Date, ForeignKey, Integer, String, Text, LargeBinary, DateTime, UUID, SmallInteger, text
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
metadata = Base.metadata

### companies
class tbl_countries(Base):
    __tablename__ = 'tbl_countries'
    __table_args__ = {'schema': 'companies'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('companies.tbl_countries_id_seq'::regclass)"))
    v_country_code = Column(String(3), nullable=False, server_default=text("''::character varying"))
    v_country_name = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_dial_code = Column(String(16), nullable=False, server_default=text("''::character varying"))
# end of tbl_countries ORM model class


class tbl_company_id_types(Base):
    __tablename__ = 'tbl_company_id_types'
    __table_args__ = {'schema': 'companies'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('companies.tbl_id_types_id_seq'::regclass)"))
    v_description = Column(String(64), nullable=False, server_default=text("''::character varying"))
# end of tbl_company_id_types ORM model class


class tbl_companies(Base):
    __tablename__ = 'tbl_companies'
    __table_args__ = {'schema': 'companies'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('companies.tbl_companies_id_seq'::regclass)"))
    i_id_type = Column(ForeignKey('companies.tbl_company_id_types.id'), nullable=False, server_default=text("0"))
    v_registration_number = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_organisation_name = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_trading_name = Column(String(128), nullable=False, server_default=text("''::character varying"))
    d_registration_date = Column(Date)
    v_contact_person = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_contact_person_alternate = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_email = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_email_alternate = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_mobile_number = Column(String(32), nullable=False, server_default=text("''::character varying"))
    v_mobile_number_alternate = Column(String(32), nullable=False, server_default=text("''::character varying"))
    v_landline_number = Column(String(32), nullable=False, server_default=text("''::character varying"))
    v_landline_number_alternate = Column(String(32), nullable=False, server_default=text("''::character varying"))
    v_additional_address = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_building_number_name = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_street_name = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_suburb = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_city = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_province = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_municipality = Column(String(128), nullable=False, server_default=text("''::character varying"))
    i_country = Column(ForeignKey('companies.tbl_countries.id'), nullable=False, server_default=text("0"))
    v_code = Column(String(16), nullable=False, server_default=text("''::character varying"))

    tbl_countries = relationship('tbl_countries')
    tbl_company_id_types = relationship('tbl_company_id_types')
# end of tbl_companies ORM model class


class tbl_company_email_addresses(Base):
    __tablename__ = 'tbl_company_email_addresses'
    __table_args__ = {'schema': 'companies'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('companies.tbl_email_addresses_id_seq'::regclass)"))
    i_company_id = Column(ForeignKey('companies.tbl_companies.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    v_email_address = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_reply_to_address = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_user_id = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_password = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_server_name = Column(String(128), nullable=False, server_default=text("''::character varying"))
    i_port = Column(Integer, nullable=False, server_default=text("587"))
    bl_secure = Column(Boolean, nullable=False, server_default=text("true"))
    bl_starttls = Column(Boolean, nullable=False, server_default=text("true"))

    i_company = relationship('tbl_companies')
# end of tbl_company_email_addresses ORM model class

### customers
class tbl_customer_id_types(Base):
    __tablename__ = 'tbl_customer_id_types'
    __table_args__ = {'schema': 'customers'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('customers.tbl_id_types_id_seq'::regclass)"))
    v_description = Column(String(64), nullable=False, server_default=text("''::character varying"))
# end of tbl_id_types ORM model class


class tbl_customers(Base):
    __tablename__ = 'tbl_customers'
    __table_args__ = {'schema': 'customers'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('customers.tbl_customers_id_seq'::regclass)"))
    i_id_type = Column(ForeignKey('customers.tbl_customer_id_types.id'), nullable=False, server_default=text("0"))
    v_id_number = Column(String(64), nullable=False, server_default=text("''::character varying"))
    v_title = Column(String(32), nullable=False, server_default=text("''::character varying"))
    v_first_names = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_last_name = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_gender = Column(String(8), nullable=False, server_default=text("''::character varying"))
    v_nationality = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_mobile_number = Column(String(64), nullable=False, server_default=text("''::character varying"))
    v_mobile_number_alternate = Column(String(64), nullable=False, server_default=text("''::character varying"))
    v_landline_number = Column(String(64), nullable=False, server_default=text("''::character varying"))
    v_landline_number_alternate = Column(String(64), nullable=False, server_default=text("''::character varying"))
    v_email = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_email_alternate = Column(String(128), nullable=False, server_default=text("''::character varying"))
    v_address = Column(String(64), nullable=False, server_default=text("''::character varying"))
    v_street_name = Column(String(64), nullable=False, server_default=text("''::character varying"))
    v_suburb = Column(String(64), nullable=False, server_default=text("''::character varying"))
    v_city = Column(String(64), nullable=False, server_default=text("''::character varying"))
    v_province = Column(String(64), nullable=False, server_default=text("''::character varying"))
    v_postal_code = Column(String(32), nullable=False, server_default=text("''::character varying"))
    v_postal_address = Column(String(128), nullable=False, server_default=text("''::character varying"))

    tbl_customer_id_types = relationship('tbl_customer_id_types')
# end of tbl_customers ORM model class


class tbl_customers_companies(Base):
    __tablename__ = 'tbl_customers_companies'
    __table_args__ = {'schema': 'customers'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('customers.tbl_customers_companies_id_seq'::regclass)"))
    i_customer_id = Column(ForeignKey('customers.tbl_customers.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    i_company_id = Column(ForeignKey('companies.tbl_companies.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))

    i_company = relationship('tbl_companies')
    i_customer = relationship('tbl_customers')
# end of tbl_customers_companies ORM model class


class tbl_customer_groups(Base):
    __tablename__ = 'tbl_customer_groups'
    __table_args__ = {'schema': 'customers'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('customers.tbl_customer_groups_id_seq'::regclass)"))
    i_company_id = Column(ForeignKey('companies.tbl_companies.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    v_group_name = Column(String(64), nullable=False, server_default=text("''::character varying"))
    v_description = Column(String(128), nullable=False, server_default=text("''::character varying"))

    i_company = relationship('tbl_companies')
# end of tbl_customer_groups ORM model class

class tbl_customer_group_members(Base):
    __tablename__ = 'tbl_customer_group_members'
    __table_args__ = {'schema': 'customers'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('customers.tbl_customer_group_members_id_seq'::regclass)"))
    i_customer_id = Column(ForeignKey('customers.tbl_customers.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    i_group_id = Column(ForeignKey('customers.tbl_customer_groups.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    
    i_customer = relationship('tbl_customers')
    i_group = relationship('tbl_customer_groups')
# end of tbl_customer_group_members ORM model class


### emails
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


### queueing
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
    v_reason = Column(String(256), nullable=False, server_default=text("''::character varying"))
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