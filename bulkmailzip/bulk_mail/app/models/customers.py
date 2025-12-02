import app, sys
from app.extensions import db
from sqlalchemy import text
from sqlalchemy.ext.declarative import declarative_base
# for foreign relationships
from .companies import tbl_companies

Base = declarative_base()
metadata = Base.metadata


class tbl_customer_id_types(db.Model):
    __tablename__ = 'tbl_customer_id_types'
    __table_args__ = {'schema': 'customers'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('customers.tbl_id_types_id_seq'::regclass)"))
    v_description = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
# end of tbl_id_types ORM model class


class tbl_customers(db.Model):
    __tablename__ = 'tbl_customers'
    __table_args__ = {'schema': 'customers'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('customers.tbl_customers_id_seq'::regclass)"))
    i_id_type = db.Column(db.ForeignKey('customers.tbl_customer_id_types.id'), nullable=False, server_default=text("0"))
    v_id_number = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    v_title = db.Column(db.String(32), nullable=False, server_default=text("''::character varying"))
    v_first_names = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_last_name = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_gender = db.Column(db.String(8), nullable=False, server_default=text("''::character varying"))
    v_nationality = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_mobile_number = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    v_mobile_number_alternate = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    v_landline_number = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    v_landline_number_alternate = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    v_email = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_email_alternate = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_address = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    v_street_name = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    v_suburb = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    v_city = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    v_province = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    v_postal_code = db.Column(db.String(32), nullable=False, server_default=text("''::character varying"))
    v_postal_address = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    bl_email_issue = db.Column(db.Boolean, nullable=False, server_default=text("false"))

    tbl_customer_id_types = db.relationship('tbl_customer_id_types')
# end of tbl_customers ORM model class


class tbl_customers_companies(db.Model):
    __tablename__ = 'tbl_customers_companies'
    __table_args__ = {'schema': 'customers'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('customers.tbl_customers_companies_id_seq'::regclass)"))
    i_customer_id = db.Column(db.ForeignKey('customers.tbl_customers.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    i_company_id = db.Column(db.ForeignKey('companies.tbl_companies.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))

    i_company = db.relationship('tbl_companies')
    i_customer = db.relationship('tbl_customers')
# end of tbl_customers_companies ORM model class


class tbl_customer_groups(db.Model):
    __tablename__ = 'tbl_customer_groups'
    __table_args__ = {'schema': 'customers'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('customers.tbl_customer_groups_id_seq'::regclass)"))
    i_company_id = db.Column(db.ForeignKey('companies.tbl_companies.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    v_group_name = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    v_description = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))

    i_company = db.relationship('tbl_companies')
# end of tbl_customer_groups ORM model class

class tbl_customer_group_members(db.Model):
    __tablename__ = 'tbl_customer_group_members'
    __table_args__ = {'schema': 'customers'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('customers.tbl_customer_group_members_id_seq'::regclass)"))
    i_customer_id = db.Column(db.ForeignKey('customers.tbl_customers.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    i_group_id = db.Column(db.ForeignKey('customers.tbl_customer_groups.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    
    i_customer = db.relationship('tbl_customers')
    i_group = db.relationship('tbl_customer_groups')
# end of tbl_customer_group_members ORM model class
