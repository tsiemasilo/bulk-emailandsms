import app, sys
from app.extensions import db
from sqlalchemy import text
from sqlalchemy.ext.declarative import declarative_base
# for foreign relationships
from .authentication import tbl_users
from .companies import tbl_countries

Base = declarative_base()
metadata = Base.metadata


class tbl_attachments(db.Model):
    __tablename__ = 'tbl_attachments'
    __table_args__ = {'schema': 'emails'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('emails.tbl_attachments_id_seq'::regclass)"))
    v_file_name = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_mime_type = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    b_file = db.Column(db.LargeBinary, nullable=False)
    i_campaign_id = db.Column(db.ForeignKey('emails.tbl_campaigns.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))

    i_campaign = db.relationship('tbl_campaigns')
# end of tbl_attachments ORM model class


class tbl_campaign_customers(db.Model):
    __tablename__ = 'tbl_campaign_customers'
    __table_args__ = {'schema': 'emails'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('emails.tbl_campaign_customers_id_seq'::regclass)"))
    i_campaign_id = db.Column(db.Integer, nullable=False, server_default=text("0"))
    i_customer_id = db.Column(db.Integer, nullable=False, server_default=text("0"))
# end of tbl_campaign_customers ORM model class


from .companies import tbl_companies, tbl_company_email_addresses

class tbl_emails(db.Model):
    __tablename__ = 'tbl_emails'
    __table_args__ = {'schema': 'emails'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('emails.tbl_emails_id_seq'::regclass)"))
    v_title = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_subject = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    t_body = db.Column(db.Text, nullable=False, server_default=text("''::text"))
    i_company_id = db.Column(db.ForeignKey('companies.tbl_companies.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))

    i_company = db.relationship('tbl_companies')
# end of tbl_emails ORM model class


class tbl_campaigns(db.Model):
    __tablename__ = 'tbl_campaigns'
    __table_args__ = {'schema': 'emails'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('emails.tbl_campaigns_id_seq'::regclass)"))
    i_company_id = db.Column(db.ForeignKey('companies.tbl_companies.id'), nullable=False, server_default=text("0"))
    v_campaign_title = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_description = db.Column(db.String(512), nullable=False, server_default=text("''::character varying"))
    i_email_id = db.Column(db.ForeignKey('emails.tbl_emails.id'), nullable=False, server_default=text("0"))
    dt_target = db.Column(db.DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP"))
    v_email_from = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_email_reply_to = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_reference_number = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    i_company_email_address_id = db.Column(db.ForeignKey('companies.tbl_company_email_addresses.id'), nullable=False, server_default=text("0"))

    i_company_email_address = db.relationship('tbl_company_email_addresses')
    i_company = db.relationship('tbl_companies')
    i_email = db.relationship('tbl_emails')
# end of tbl_campaigns ORM model class


from .customers import tbl_customer_groups


class tbl_campaign_groups(db.Model):
    __tablename__ = 'tbl_campaign_groups'
    __table_args__ = {'schema': 'emails'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('emails.tbl_campaign_groups_id_seq'::regclass)"))
    i_campaign_id = db.Column(db.ForeignKey('emails.tbl_campaigns.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    i_group_id = db.Column(db.ForeignKey('customers.tbl_customer_groups.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))

    i_campaign = db.relationship('tbl_campaigns')
    i_group = db.relationship('tbl_customer_groups')
# end of tbl_campaign_groups ORM model class
