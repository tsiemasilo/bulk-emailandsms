# coding: utf-8
# from sqlalchemy import CHAR, Column, Date, ForeignKey, Integer, LargeBinary, SmallInteger, String, text
from sqlalchemy import text
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
from app import db

Base = declarative_base()
metadata = Base.metadata


class tbl_all_languages(Base):
    __tablename__ = 'tbl_all_languages'
    __table_args__ = {'schema': 'cv_data'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('cv_data.tbl_all_languages_id_seq'::regclass)"))
    v_language_abbreviation = db.Column(db.String(10), nullable=False, server_default=text("''::character varying"))
    v_language_name = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    bl_south_african = db.Column(db.Boolean, nullable=False, server_default=text("false"))
# end of tbl_all_languages ORM model class


class tbl_records(Base):
    __tablename__ = 'tbl_records'
    __table_args__ = {'schema': 'cv_data'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('cv_data.tbl_records_id_seq'::regclass)"))
    v_name_1 = db.Column(db.String(50), nullable=False, server_default=text("''::character varying"))
    v_name_2 = db.Column(db.String(50), nullable=False, server_default=text("''::character varying"))
    v_name_3 = db.Column(db.String(50), nullable=False, server_default=text("''::character varying"))
    v_surname = db.Column(db.String(50), nullable=False, server_default=text("''::character varying"))
    v_id_number = db.Column(db.String(50), nullable=False, server_default=text("''::character varying"))
    c_gender = db.Column(db.CHAR(1), nullable=False, server_default=text("'m'::bpchar"))
    si_years_experience = db.Column(db.SmallInteger, nullable=False, server_default=text("'0'::smallint"))
    v_sap_k_level = db.Column(db.String(2), nullable=False, server_default=text("''::character varying"))
    v_contact_number = db.Column(db.String(18), nullable=False, server_default=text("''::character varying"))
    v_email = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    i_department_id = db.Column(db.Integer, nullable=False, server_default=text("0"))
    i_role_id = db.Column(db.Integer, nullable=False, server_default=text("0"))
# end of tbl_records ORM model class


class tbl_qualification_types(Base):
    __tablename__ = 'tbl_qualification_types'
    __table_args__ = {'schema': 'qualifications_certifications'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('qualifications_certifications.tbl_qualification_types_id_seq'::regclass)"))
    v_qualification_type = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
# end of tbl_qualification_types ORM model class


class tbl_languages(Base):
    __tablename__ = 'tbl_languages'
    __table_args__ = {'schema': 'cv_data'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('cv_data.tbl_languages_id_seq'::regclass)"))
    i_record_id = db.Column(db.ForeignKey('cv_data.tbl_records.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    v_language_abbreviation = db.Column(db.String(5), nullable=False, server_default=text("''::character varying"))
    v_language_name = db.Column(db.String(32), nullable=False, server_default=text("''::character varying"))
    si_ranking = db.Column(db.SmallInteger, nullable=False, server_default=text("'0'::smallint"))
    si_level = db.Column(db.SmallInteger, nullable=False, server_default=text("'0'::smallint"))

    i_record = relationship('tbl_records')
# end of tbl_languages ORM model class


class tbl_uploads(Base):
    __tablename__ = 'tbl_uploads'
    __table_args__ = {'schema': 'cv_data'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('cv_data.tbl_uploads_id_seq'::regclass)"))
    i_record_id = db.Column(db.ForeignKey('cv_data.tbl_records.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    si_upload_type = db.Column(db.SmallInteger, nullable=False, server_default=text("'0'::smallint"))
    i_matching_id = db.Column(db.Integer, nullable=False, server_default=text("0"))
    v_description = db.Column(db.String(256), nullable=False, server_default=text("''::character varying"))
    v_filename = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_mime_type = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    b_file = db.Column(db.LargeBinary)

    i_record = relationship('tbl_records')
# end of tbl_uploads ORM model class


class tbl_qualifications(Base):
    __tablename__ = 'tbl_qualifications'
    __table_args__ = {'schema': 'qualifications_certifications'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('qualifications_certifications.tbl_qualifications_id_seq'::regclass)"))
    i_qualification_type = db.Column(db.ForeignKey('qualifications_certifications.tbl_qualification_types.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    v_qualification_name = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_description = db.Column(db.String(255), nullable=False, server_default=text("''::character varying"))

    tbl_qualification_types = relationship('tbl_qualification_types')
# end of tbl_qualifications ORM model class


class tbl_record_qualifications(Base):
    __tablename__ = 'tbl_record_qualifications'
    __table_args__ = {'schema': 'cv_data'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('cv_data.tbl_record_qualifications_id_seq'::regclass)"))
    i_qualification_id = db.Column(db.ForeignKey('qualifications_certifications.tbl_qualifications.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    i_record_id = db.Column(db.ForeignKey('cv_data.tbl_records.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    d_acquired = db.Column(db.Date)

    i_qualification = relationship('tbl_qualifications')
    i_record = relationship('tbl_records')
# end of tbl_record_qualifications ORM model class


class tbl_role_departments(Base):
    __tablename__ = 'tbl_role_departments'
    __table_args__ = {'schema': 'cv_data'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('cv_data.tbl_role_departments_id_seq'::regclass)"))
    v_department_name = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
# end of tbl_role_departments ORM model class


class tbl_roles(Base):
    __tablename__ = 'tbl_roles'
    __table_args__ = {'schema': 'cv_data'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('cv_data.tbl_roles_id_seq'::regclass)"))
    i_department_id = db.Column(db.ForeignKey('cv_data.tbl_role_departments.id', ondelete='CASCADE'), nullable=False, server_default=text("0"))
    v_role_name = db.Column(db.String(128), nullable=False, server_default=text("''::character varying"))
    v_description = db.Column(db.String(255), nullable=False, server_default=text("''::character varying"))

    i_department = relationship('tbl_role_departments')
# end of tbl_roles ORM model class


class tbl_tender_cvs(Base):
    __tablename__ = 'tbl_tender_cvs'
    __table_args__ = {'schema': 'cv_data'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('cv_data.tbl_tender_cvs_id_seq'::regclass)"))
    i_record_id = db.Column(db.Integer, nullable=False, server_default=text("0"))
    i_tender_id = db.Column(db.Integer, nullable=False, server_default=text("0"))
    dt_when = db.Column(db.DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP"))
# end of tbl_tender_cvs ORM model class


class tbl_tenders(Base):
    __tablename__ = 'tbl_tenders'
    __table_args__ = {'schema': 'cv_data'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('cv_data.tbl_tenders_id_seq'::regclass)"))
    v_reference_number = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    v_description = db.Column(db.String(512), nullable=False, server_default=text("''::character varying"))
# end of tbl_tenders ORM model class
