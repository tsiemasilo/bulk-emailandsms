# coding: utf-8
from sqlalchemy import Boolean, Column, Date, ForeignKey, Integer, String, text
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
metadata = Base.metadata


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
