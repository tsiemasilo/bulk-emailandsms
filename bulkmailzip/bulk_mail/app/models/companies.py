import app, sys
from app.extensions import db
from sqlalchemy import text
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
metadata = Base.metadata


class tbl_countries(db.Model):
    __tablename__ = 'tbl_countries'
    __table_args__ = {'schema': 'companies'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('companies.tbl_countries_id_seq'::regclass)"))
    v_country_code = db.Column(db.String(3), nullable=False, server_default=text("''::character varying"))
    v_country_name = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_dial_code = db.Column(db.String(16), nullable=False, server_default=text("''::character varying"))
# end of tbl_countries ORM model class


class tbl_company_id_types(db.Model):
    __tablename__ = 'tbl_company_id_types'
    __table_args__ = {'schema': 'companies'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('companies.tbl_id_types_id_seq'::regclass)"))
    v_description = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
# end of tbl_company_id_types ORM model class


class tbl_companies(db.Model):
    __tablename__ = 'tbl_companies'
    __table_args__ = {'schema': 'companies'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('companies.tbl_companies_id_seq'::regclass)"))
    i_id_type = db.Column(db.ForeignKey('companies.tbl_company_id_types.id'), nullable=False, server_default=text("0"))
    v_registration_number = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_organisation_name = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_trading_name = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    d_registration_date = db.Column(db.Date)
    v_contact_person = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_contact_person_alternate = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_email = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_email_alternate = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_mobile_number = db.Column(db.String(32), nullable=False, server_default=text("''::character varying"))
    v_mobile_number_alternate = db.Column(db.String(32), nullable=False, server_default=text("''::character varying"))
    v_landline_number = db.Column(db.String(32), nullable=False, server_default=text("''::character varying"))
    v_landline_number_alternate = db.Column(db.String(32), nullable=False, server_default=text("''::character varying"))
    v_additional_address = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_building_number_name = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_street_name = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_suburb = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_city = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_province = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_municipality = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    i_country = db.Column(db.ForeignKey('companies.tbl_countries.id'), nullable=False, server_default=text("0"))
    v_code = db.Column(db.String(16), nullable=False, server_default=text("''::character varying"))

    tbl_countries = db.relationship('tbl_countries')
    tbl_company_id_types = db.relationship('tbl_company_id_types')
# end of tbl_companies ORM model class


class tbl_company_email_addresses(db.Model):
    __tablename__ = 'tbl_company_email_addresses'
    __table_args__ = {'schema': 'companies'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('companies.tbl_email_addresses_id_seq'::regclass)"))
    i_company_id = db.Column(db.ForeignKey('companies.tbl_companies.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    v_email_address = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_reply_to_address = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_user_id = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_password = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_server_name = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    i_port = db.Column(db.Integer, nullable=False, server_default=text("587"))
    bl_secure = db.Column(db.Boolean, nullable=False, server_default=text("true"))
    bl_starttls = db.Column(db.Boolean, nullable=False, server_default=text("true"))

    i_company = db.relationship('tbl_companies')
# end of tbl_company_email_addresses ORM model class
