from flask import render_template, request, session, jsonify, flash, make_response, redirect, url_for, abort, send_file, render_template_string
from flask_login import login_required, current_user
from app.main import bp
from app import db
from app.extensions import dict_row, dict_instance, extract_exc, check_date
from app.models.authentication import tbl_users
from app.models.customers import tbl_customers, tbl_customer_id_types, tbl_customers_companies, tbl_customer_groups, tbl_customer_group_members
from app.models.companies import tbl_countries, tbl_companies, tbl_company_id_types, tbl_company_email_addresses
from app.models.emails import tbl_attachments, tbl_campaign_customers, tbl_emails, tbl_campaigns, tbl_campaign_groups
from app.models.queueing import tbl_queued_emails, tbl_queued_attachments, tbl_queued_customers, tbl_queued_click_throughs, tbl_queued_click_through_records
from app.auth import check_admin
from sqlalchemy import insert, delete, update, select
from sqlalchemy import and_, or_, not_, func
import json, requests, re, os
from .forms import CompanyForm, RemoveCompanyForm, CustomerIDTypeForm, CompanyIDTypeForm
from .forms import RemoveCompanyIDTypeForm, RemoveCustomerIDTypeForm, CustomerForm, RemoveCustomerForm
from .forms import CompanyUserForm, RemoveCompanyUserForm, CompanyCampaignForm, CustomerBulkUploadForm, CustomerGroupForm, RemoveCustomerGroupForm, CustomerGroupMembersChangeForm
from .forms import EmailTemplateForm, RemoveEmailTemplateForm, RemoveCompanyCampaignForm, CampaignAttachmentUploadForm, RemoveCampaignAttachmentForm, QueueCampaignSendingForm,\
    CompanyEmailAddressForm, RemoveCompanyEmailAddressForm, CampaignReportsFilterForm, RecipientsExportForm
import re
import datetime as datetime_class
from datetime import datetime, time, timezone, timedelta, date
from app import Config
import io
from copy import copy
import uuid
from bs4 import BeautifulSoup as bs
import pdfkit

def end_user_debugging(s_additional:str = "", bl_html:bool = True):
    """just for initial testing"""
    d_exc = extract_exc(s_additional)
    s_dt = datetime.now().astimezone(timezone(timedelta(hours=2))).strftime("%Y-%m-%d %H:%M:%S")
    s_logging = f"<ul><li>date-time: {s_dt}</li>\n<li>filename: {d_exc['s_filename']}</li>\n<li>line no.: {d_exc['i_lineno']}</li>\n<li>except: {d_exc['s_except']}</li>\n<li>additional: {d_exc['s_additional']}</li>\n</ul>" if (isinstance(d_exc, dict) and bl_html) else f"date-time: {s_dt}\nindex-landing page\n" + str(d_exc["s_except"])
    return f"<!doctype html>\n<html lang=\"en\">\n<head>\n<title>Issue</title>\n</head>\n<body>\n<h2>Issue details</h2>\n{s_logging}\n</body>\n</html>"
# end of end_user_debugging function

# l_countries, d_countries = ([], {})
def populate_countries():
    """populate country lookup|reference values"""
    l_countries, d_countries = ([], {})
    q_countries = db.session.query(tbl_countries.id, tbl_countries.v_country_name).order_by(tbl_countries.v_country_name).all()
    l_countries = list(map(dict_row, q_countries))
    for ix, d_country in enumerate(l_countries):
        d_countries[d_country["id"]] = d_country["v_country_name"]
    # end of populating d_countries
    l_countries = list(map(tuple, q_countries))
    return (l_countries, d_countries)
# end of populate_countries function


@bp.route("/", methods=["GET", "POST"])
@login_required
def index():
    """landing page"""
    try:
        s_base = "base_bs.html" if Config.BOOTSTRAP else "base.html"
        s_url = url_for("main.index")#, _external=True)
        i_company_id = current_user.i_company_id
        s_company_name = ""
        if i_company_id>0:
            o_company = db.session.get(tbl_companies, i_company_id)
            if o_company is not None:
                s_company_name = o_company.v_organisation_name
            # end of checking for company retrieval
        # end of checking if company user
        return render_template("index.html", js=True, base=s_base, url=s_url, company_id=i_company_id, company_name=s_company_name)
    except Exception as exc:
        return render_template_string(end_user_debugging("index/landing page"))
    # end of surrounding try-except
# end of index view function for route /


@bp.route("/id_types", methods=["GET", "POST"])
@login_required
@check_admin
def id_types():
    """id types administration"""
    try:
        customer_id_type_form = CustomerIDTypeForm()
        company_id_type_form = CompanyIDTypeForm()
        remove_company_type_form = RemoveCompanyIDTypeForm()
        remove_customer_type_form = RemoveCustomerIDTypeForm()
        if customer_id_type_form.validate_on_submit() and request.form.get("btn_save_customer_type", None) is not None:
            i_type_id, s_description = (int(customer_id_type_form.hid_customer_id_type_id.data), str(customer_id_type_form.txt_customer_id_type_description.data))
            if i_type_id>0:
                if db.session.query(tbl_customer_id_types).filter(tbl_customer_id_types.id!=i_type_id, tbl_customer_id_types.v_description==s_description).count()<1:
                    o_type = db.session.get(tbl_customer_id_types, i_type_id)
                    o_type.v_description = s_description
                    db.session.add(o_type)
                    db.session.commit()
                    flash("Type updated")
                else:
                    flash("There is another customer ID type with same description")
                # end of checking for other matching type description
            else:
                if db.session.query(tbl_customer_id_types).filter(tbl_customer_id_types.v_description==s_description).count()<1:
                    o_type = tbl_customer_id_types(v_description=s_description)
                    db.session.add(o_type)
                    db.session.commit()
                    flash("Type added")
                else:
                    flash("There is another customer ID type with same description")
                # end of making sure no other matching customer ID type
            # end of checking if new or existing type
        elif company_id_type_form.validate_on_submit() and request.form.get("btn_save_company_type", None) is not None:
            i_type_id, s_description = (int(company_id_type_form.hid_company_id_type_id.data), str(company_id_type_form.txt_company_id_type_description.data))
            if i_type_id>0:
                if db.session.query(tbl_company_id_types).filter(tbl_company_id_types.id!=i_type_id, tbl_company_id_types.v_description==s_description).count()<1:
                    o_type = db.session.get(tbl_company_id_types, i_type_id)
                    o_type.v_description = s_description
                    db.session.add(o_type)
                    db.session.commit()
                    flash("Type updated")
                else:
                    flash("There is another company ID type with same description")
                # end of checking for other matching type description
            else:
                if db.session.query(tbl_company_id_types).filter(tbl_company_id_types.v_description==s_description).count()<1:
                    o_type = tbl_company_id_types(v_description=s_description)
                    db.session.add(o_type)
                    db.session.commit()
                    flash("Type added")
                else:
                    flash("There is another company ID type with same description")
                # end of making sure no other matching customer ID type
            # end of checking if new or existing type
        elif remove_company_type_form.validate_on_submit() and request.form.get("hid_remove_company_type_id", None) is not None:
            i_type_id = int(remove_company_type_form.hid_remove_company_type_id.data)
            o_removal = db.session.get(tbl_company_id_types, i_type_id)
            if o_removal is not None:
                db.session.delete(o_removal)
                db.session.commit()
                flash("Type removed")
            # end of checking for existing type
        elif remove_customer_type_form.validate_on_submit() and request.form.get("hid_remove_customer_type_id", None) is not None:
            i_type_id = int(remove_customer_type_form.hid_remove_customer_type_id.data)
            o_removal = db.session.get(tbl_customer_id_types, i_type_id)
            if o_removal is not None:
                db.session.delete(o_removal)
                db.session.commit()
                flash("Type removed")
            # end of checking for existing type
        # end of checking for form submissions
        # reset form values
        customer_id_type_form.hid_customer_id_type_id.data, customer_id_type_form.txt_customer_id_type_description.data = (0, "")
        company_id_type_form.hid_company_id_type_id.data, company_id_type_form.txt_company_id_type_description.data = (0, "")
        # pull existing values
        l_customer_types = list(map(dict_row, db.session.query(tbl_customer_id_types.id, tbl_customer_id_types.v_description).order_by(tbl_customer_id_types.v_description).all()))
        l_company_types = list(map(dict_row, db.session.query(tbl_company_id_types.id, tbl_company_id_types.v_description).order_by(tbl_company_id_types.v_description).all()))
        s_base = "base_bs.html" if Config.BOOTSTRAP else "base.html"
        s_url = url_for("main.id_types")#, _external=True)
        return render_template("id_types.html", js=True, base=s_base, url=s_url, customer_type_form=customer_id_type_form, company_type_form=company_id_type_form, customer_types=l_customer_types, company_types=l_company_types, remove_company_type_form=remove_company_type_form, remove_customer_type_form=remove_customer_type_form)
    except Exception as exc:
        return render_template_string(end_user_debugging("id_types"))
    # end of surrounding try-except
# end of id_types view function for route /id_types


@bp.route("/company_id_type/<int:i_type_id>", methods=["GET"])
@login_required
@check_admin
def company_id_type(i_type_id):
    """company ID type description"""
    try:
        d_out = {}
        o_company_id_type = db.session.get(tbl_company_id_types, i_type_id)
        if o_company_id_type is not None:
            d_out = dict_instance(o_company_id_type)
        # end of checking if record retrieved
        return make_response(jsonify(d_out), 200)
    except Exception as exc:
        return render_template_string(end_user_debugging("company id type description"))
    # end of surrounding try-except
# end of company_id_type view function for route /company_id_type/<int: i_type_id>

@bp.route("/customer_id_type/<int:i_type_id>", methods=["GET"])
@login_required
@check_admin
def customer_id_type(i_type_id):
    """customer ID type description"""
    try:
        d_out = {}
        o_customer_id_type = db.session.get(tbl_customer_id_types, i_type_id)
        if o_customer_id_type is not None:
            d_out = dict_instance(o_customer_id_type)
        # end of checking if record retrieved
        return make_response(jsonify(d_out), 200)
    except Exception as exc:
        return render_template_string(end_user_debugging("customer id type description"))
    # end of surrounding try-except
# end of customer_id_type view function for route /customer_id_type/<int: i_type_id>


@bp.route("/companies", methods=["GET", "POST"])
@login_required
@check_admin
def companies():
    """company administration"""
    try:
        l_id_types = list(map(tuple, db.session.query(tbl_company_id_types.id, tbl_company_id_types.v_description).order_by(tbl_company_id_types.v_description).all()))
        l_countries = list(map(tuple, db.session.query(tbl_countries.id, func.concat(tbl_countries.v_country_name, " - ", tbl_countries.v_country_code).label("v_country")).order_by(tbl_countries.v_country_name).all()))
        form = CompanyForm()
        form.sel_id_type.choices = l_id_types
        form.sel_country.choices = form.sel_country.choices + l_countries
        remove_form = RemoveCompanyForm()
        if form.validate_on_submit() and request.form.get("btn_save_company", None) is not None:
            i_company_id, i_registration_type_id, s_registration_number, s_organisation_name, s_trading_name, d_registration_date, s_contact_person, s_contact_person_alternate = (int(form.hid_company_id.data), int(form.sel_id_type.data), str(form.txt_registration_number.data), str(form.txt_organisation_name.data), str(form.txt_trading_name.data), form.d_registration_date.data, str(form.txt_contact_person.data), str(form.txt_contact_person_alternate.data))
            s_email, s_email_alternate, s_mobile_number, s_mobile_number_alternate, s_landline_number, s_landline_number_alternate = (str(form.txt_email.data), str(form.txt_email_alternate.data), str(form.txt_mobile_number.data), str(form.txt_mobile_number_alternate.data), str(form.txt_landline_number.data), str(form.txt_landline_number_alternate.data))
            s_additional_address, s_building_number_name, s_street_name, s_suburb, s_city, s_province, s_municipality, i_country, s_code = (str(form.txt_additional_address.data), str(form.txt_building_number_name.data), str(form.txt_street_name.data), str(form.txt_suburb.data), str(form.txt_city.data), str(form.txt_province.data), str(form.txt_municipality.data), int(form.sel_country.data), str(form.txt_code.data))
            d_registration_date = None if i_registration_type_id==0 else d_registration_date
            q_action = None
            s_activity = "inserted"
            if i_company_id>0:
                q_action = update(tbl_companies).where(tbl_companies.id==i_company_id)
                s_activity = "updated"
            else:
                q_action = insert(tbl_companies)
            # end of checking if insert or update
            if q_action is not None:
                d_values = {"i_id_type": i_registration_type_id, "v_registration_number": s_registration_number, "v_organisation_name": s_organisation_name, "v_trading_name": s_trading_name, \
                    "d_registration_date": d_registration_date, "v_contact_person": s_contact_person, "v_contact_person_alternate": s_contact_person_alternate, \
                    "v_email": s_email, "v_email_alternate": s_email_alternate, "v_mobile_number": s_mobile_number, "v_mobile_number_alternate": s_mobile_number_alternate, "v_landline_number": s_landline_number, "v_landline_number_alternate": s_landline_number_alternate, \
                    "v_additional_address": s_additional_address, "v_building_number_name": s_building_number_name, "v_street_name": s_street_name, "v_suburb": s_suburb, "v_city": s_city, "v_province": s_province, "v_municipality": s_municipality, "i_country": i_country, "v_code": s_code
                }# end of populating query values
                q_action = q_action.values(d_values)
                db.session.execute(q_action)
                db.session.commit()
                flash(f"Company record {s_activity}")
            # end of making sure query initiated
        elif remove_form.validate_on_submit() and request.form.get("hid_remove_company_id", None) is not None:
            i_company_id = int(remove_form.hid_remove_company_id.data)
            o_company = db.session.get(tbl_companies, i_company_id)
            if o_company is not None:
                db.session.delete(o_company)
                db.session.commit()
                flash("Company removed")
            # end of first checking for retrieval
        # end of checking for form submission
        form.hid_company_id.data, form.sel_id_type.data, form.txt_registration_number.data, form.txt_organisation_name.data, form.txt_trading_name.data, form.d_registration_date.data = (0, 0, "", "", "", date.today())
        form.txt_contact_person.data, form.txt_contact_person_alternate.data, form.txt_email.data, form.txt_email_alternate.data, form.txt_mobile_number.data, form.txt_mobile_number_alternate.data, form.txt_landline_number.data, form.txt_landline_number_alternate.data = ("", "", "", "", "", "", "", "")
        form.txt_additional_address.data, form.txt_building_number_name.data, form.txt_street_name.data, form.txt_suburb.data, form.txt_city.data, form.txt_province.data, form.txt_municipality.data, form.sel_country.data, form.txt_code.data = ("", "", "", "", "", "", "", 1, "")
        remove_form.hid_remove_company_id.data = 0
        i_page = request.form.get("hid_page", 1, type=int)
        q_companies = db.session.query(tbl_companies.id, tbl_companies.i_id_type, tbl_company_id_types.v_description.label("v_registration_type"), tbl_companies.v_registration_number, tbl_companies.v_organisation_name, tbl_companies.v_trading_name, tbl_companies.v_contact_person, tbl_companies.v_email, tbl_companies.v_mobile_number, tbl_companies.v_landline_number, tbl_companies.v_city, tbl_companies.i_country, tbl_countries.v_country_name).join(tbl_company_id_types, tbl_company_id_types.id==tbl_companies.i_id_type, isouter=False).join(tbl_countries, tbl_countries.id==tbl_companies.i_country, isouter=False).order_by(tbl_companies.v_organisation_name, tbl_companies.v_trading_name)
        pagination = q_companies.paginate(page=i_page, per_page=20)
        l_companies = list(map(dict_row, pagination.items))
        s_base = "base_bs.html" if Config.BOOTSTRAP else "base.html"
        s_url = url_for("main.companies")#, _external=True)
        return render_template("companies.html", js=True, base=s_base, url=s_url, form=form, remove_form=remove_form, id_types=l_id_types, countries=l_countries, companies=l_companies, paging=pagination, page=i_page)
    except Exception as exc:
        return render_template_string(end_user_debugging("companies"))
    # end of surrounding try-except
# end of companies view function for route /companies

@bp.route("/company_details/<int:i_company_id>/", methods=["GET"])
@login_required
@check_admin
def company_details(i_company_id:int = 0):
    """company details"""
    try:
        d_out = {}
        o_company = db.session.get(tbl_companies, i_company_id)
        if o_company is not None:
            d_out = dict_instance(o_company)
            d_out["d_registration_date"] = d_out["d_registration_date"].strftime("%Y-%m-%d") if isinstance(d_out["d_registration_date"], date) or isinstance(d_out["d_registration_date"], datetime) else ""
        # end of checking if record retrieved
        return make_response(jsonify(d_out), 200)
    except Exception as exc:
        return render_template_string(end_user_debugging("company details"))
    # end of surrounding try-except
# end of company_details view function for route /company_details/<int: i_company_id>


@bp.route("/customers/<int:i_company_id>/", methods=["GET", "POST"])
@login_required
def customers(i_company_id:int):
    """customers on a per company basis"""
    l_countries, d_countries = populate_countries()
    try:
        # redirect if not company member
        if current_user.i_company_id!=i_company_id: return redirect(url_for("main.index"))
        i_group_id = request.form.get("sel_group_filter", 0, type=int)
        l_id_types = list(map(tuple, db.session.query(tbl_customer_id_types.id, tbl_customer_id_types.v_description).order_by(tbl_customer_id_types.v_description).all()))
        form = CustomerForm()
        form.sel_id_type.choices = form.sel_id_type.choices + l_id_types
        form.sel_nationality.choices = form.sel_nationality.choices + l_countries
        remove_customer_form = RemoveCustomerForm()
        q_groups = db.session.query(tbl_customer_groups.id, tbl_customer_groups.v_group_name).filter(tbl_customer_groups.i_company_id==i_company_id).order_by(tbl_customer_groups.v_group_name).all()
        l_groups = list(map(dict_row, q_groups))
        upload_form = CustomerBulkUploadForm()
        upload_form.sel_group_id.choices = [(0, "---no group associated---")] + list(map(tuple, q_groups))
        group_form = CustomerGroupForm()
        bl_groups_changed = False
        if form.validate_on_submit() and request.form.get("btn_save_customer", None) is not None:
            i_customer_id, i_id_type, s_id_number, s_title, s_first_names, s_last_name, s_mobile_number, s_mobile_number_alternate = (int(form.hid_customer_id.data), int(form.sel_id_type.data), str(form.txt_id_number.data), str(form.txt_title.data), str(form.txt_first_names.data), str(form.txt_last_name.data), str(form.txt_mobile_number.data), str(form.txt_mobile_number_alternate.data))
            i_nationality, s_gender, s_landline_number, s_landline_number_alternate, s_email, s_email_alternate = (int(form.sel_nationality.data), str(form.sel_gender.data), str(form.txt_landline_number.data), str(form.txt_landline_number_alternate.data), str(form.txt_email.data), str(form.txt_email_alternate.data))
            s_address, s_street_name, s_suburb, s_city, s_province, s_code, s_postal_address = (str(form.txt_address.data), str(form.txt_street_name.data), str(form.txt_suburb.data), str(form.txt_city.data), str(form.txt_province.data), str(form.txt_code.data), str(form.txt_postal_address.data))
            s_nationality = d_countries.get(i_nationality, "---")
            q_action = None
            s_activity = "updated"
            if i_customer_id>0:
                q_action = update(tbl_customers).where(tbl_customers.id==i_customer_id)
            else:
                q_action = insert(tbl_customers)
                s_activity = "inserted"
            # end of checking if insert or update
            if q_action is not None:
                d_values = {"i_id_type": i_id_type, "v_id_number": s_id_number, "v_title": s_title, "v_first_names": s_first_names, "v_last_name": s_last_name, "v_mobile_number": s_mobile_number, "v_mobile_number_alternate": s_mobile_number_alternate, "v_nationality": s_nationality, "v_gender": s_gender, "v_landline_number": s_landline_number, "v_landline_number_alternate": s_landline_number_alternate, "v_email": s_email, "v_email_alternate": s_email_alternate, "v_address": s_address, "v_street_name": s_street_name, "v_suburb": s_suburb, "v_city": s_city, "v_province": s_province, "v_postal_code": s_code, "v_postal_address": s_postal_address}
                q_action = q_action.values(d_values)
                if s_activity=="updated":
                    db.session.execute(q_action)
                else:
                    res = db.session.execute(q_action.returning(tbl_customers.id))
                    i_customer_id = res.one().id
                    db.session.add(tbl_customers_companies(i_customer_id=i_customer_id, i_company_id=i_company_id))
                    if i_group_id>0:
                        db.session.add(tbl_customer_group_members(i_customer_id=i_customer_id, i_group_id=i_group_id))
                    # end of checking if should also insert group membership record
                # end of checking if need to perform additional activities against new record
                db.session.commit()
                flash(f"Customer record {s_activity}")
            # end of making sure query initiated
        elif remove_customer_form.validate_on_submit() and request.form.get("hid_remove_customer_id", None) is not None:
            i_customer_id = int(remove_customer_form.hid_remove_customer_id.data)
            o_customer = db.session.get(tbl_customers, i_customer_id)
            if o_customer is not None:
                db.session.delete(o_customer)
                db.session.commit()
                flash("Customer record removed")
        elif group_form.validate_on_submit() and request.form.get("btn_save_group", None) is not None:
            i_group_id, s_group_name, s_group_description = (int(group_form.hid_group_id.data), str(group_form.txt_group_name.data), str(group_form.txt_group_description.data))
            o_group = None
            s_activity = "updated"
            if i_group_id>0:
                o_group = db.session.get(tbl_customer_groups, i_group_id)
                if o_group is not None:
                    if db.session.query(tbl_customer_groups).filter(tbl_customer_groups.id!=i_group_id, tbl_customer_groups.v_group_name==s_group_name, tbl_customer_groups.i_company_id==i_company_id).count()<1:
                        o_group.v_group_name = s_group_name
                        o_group.v_description = s_group_description
                        db.session.add(o_group)
                        db.session.commit()
                        flash("Group updated")
                    else:
                        flash("There is another group with same name")
                    # end of checking for existing group name
            else:
                s_activity = "inserted"
                if db.session.query(tbl_customer_groups).filter(tbl_customer_groups.i_company_id==i_company_id, tbl_customer_groups.v_group_name==s_group_name).count()<1:
                    o_group = tbl_customer_groups(i_company_id=i_company_id, v_group_name=s_group_name, v_description=s_group_description)
                    db.session.add(o_group)
                    db.session.commit()
                    flash("Group added")
                # end of checking if there was another existing record with same name
            # end of checking if new or existing record
            bl_groups_changed = True
        elif upload_form.validate_on_submit() and request.form.get("btn_upload_customers", None) is not None:
            i_group_id = int(upload_form.sel_group_id.data)
            fil_upload = request.files.get("fil_upload")
            if i_group_id>0:
                if fil_upload is not None and fil_upload.filename!="":
                    s_ext = os.path.splitext(fil_upload.filename)[1]
                    if s_ext not in [".csv"]:
                        abort(400)
                    # end of double-checking file extension
                    # extract data record values
                    s_filename= fil_upload.filename
                    with fil_upload.stream as fs_upload:
                        s_csv = fs_upload.read().decode("utf-8").strip()
                        d_columns = {"v_id_number": 64, "v_title": 32, "v_first_names": 128, "v_last_name": 128, "v_gender": 8, "v_nationality": 128, "v_mobile_number": 64, "v_landline_number": 64, "v_email": 128, "v_address": 64, "v_street_name": 64, "v_suburb": 64, "v_city": 64, "v_province": 64, "v_postal_code": 32, "v_postal_address": 128}
                        q_action = insert(tbl_customers)
                        i_inserted = 0
                        for s_record in s_csv.split("\n"):
                            l_values = s_record.split(",")
                            d_values = {"i_id_type": 1}
                            for ix, s_field in enumerate(list(d_columns.keys())):
                                i_len = d_columns[s_field]
                                d_values[s_field] = l_values[ix][:i_len]
                            # end of looping through column names and lengths
                            q_values = q_action.values(d_values)
                            res = db.session.execute(q_values.returning(tbl_customers.id))
                            i_customer_id = res.one().id
                            db.session.add(tbl_customers_companies(i_customer_id=i_customer_id, i_company_id=i_company_id))
                            if i_group_id>0:
                                db.session.add(tbl_customer_group_members(i_customer_id=i_customer_id, i_group_id=i_group_id))
                            # end of checking if should also insert group membership record
                            i_inserted = i_inserted + 1
                        # end of looping through rows
                        if i_inserted>0:
                            db.session.commit()
                            flash("Records from bulk upload recorded")
                        # end of checking if should commit records
                    # end of with open
                # end of making sure about file upload
            else:
                flash("You need to select a group to assign uploaded customers to")
            # end of making sure group was selected for assignation
        # end of checking for form submission
        form.hid_customer_id.data, form.sel_id_type.data, form.txt_id_number.data, form.txt_title.data, form.txt_first_names.data, form.txt_last_name.data, form.txt_mobile_number.data, form.txt_mobile_number_alternate.data = (0, 1, "", "", "", "", "", "")
        form.sel_nationality.data, form.sel_gender.data, form.txt_landline_number.data, form.txt_landline_number_alternate.data, form.txt_email.data, form.txt_email_alternate.data = (0, "M", "", "", "", "")
        form.txt_address.data, form.txt_street_name.data, form.txt_suburb.data, form.txt_city.data, form.txt_province.data, form.txt_code.data, form.txt_postal_address.data = ("", "", "", "", "", "", "")
        group_form.hid_group_id, group_form.txt_group_name.data, group_form.txt_group_description.data = (0, "", "")
        remove_customer_form.hid_remove_customer_id.data
        upload_form.sel_group_id.data, upload_form.fil_upload.data = (0, None)
        if bl_groups_changed:
            q_groups = db.session.query(tbl_customer_groups.id, tbl_customer_groups.v_group_name).filter(tbl_customer_groups.i_company_id==i_company_id).order_by(tbl_customer_groups.v_group_name).all()
            l_groups = list(map(dict_row, q_groups))
            upload_form.sel_group_id.choices = [(0, "---no group associated---")] + list(map(tuple, q_groups))
        # end of checking if need to update references to groups listings
        i_page = request.form.get("hid_page", 1, type=int)
        q_customers = db.session.query(tbl_customers.id, tbl_customers.i_id_type, tbl_customer_id_types.v_description.label("v_id_type"), tbl_customers.v_id_number, tbl_customers.v_first_names, tbl_customers.v_last_name, tbl_customers.v_mobile_number, tbl_customers.v_email, tbl_customers.v_nationality).join(tbl_customer_id_types, tbl_customer_id_types.id==tbl_customers.i_id_type).order_by(tbl_customers.v_last_name, tbl_customers.v_first_names)
        q_customers = q_customers.join(tbl_customers_companies, tbl_customers_companies.i_customer_id==tbl_customers.id).filter(tbl_customers_companies.i_company_id==i_company_id)
        if i_group_id>0:
            q_customers = q_customers.join(tbl_customer_group_members, tbl_customer_group_members.i_customer_id==tbl_customers.id).filter(tbl_customer_group_members.i_group_id==i_group_id)
        # end of checking if need to filter via join against group membership
        o_company = db.session.get(tbl_companies, i_company_id)
        s_company_name = o_company.v_organisation_name
        pagination = q_customers.paginate(page=i_page, per_page=10)
        l_customers = list(map(dict_row, pagination.items))
        s_base = "base_bs.html" if Config.BOOTSTRAP else "base.html"
        s_url = url_for("main.customers", i_company_id=i_company_id)#, _external=True)
        return render_template("customers.html", js=True, base=s_base, url=s_url, id_types=l_id_types, countries=l_countries, customers=l_customers, paging=pagination, company_id=i_company_id, form=form, remove_form=remove_customer_form, company_name=s_company_name, groups=l_groups, group_id=i_group_id, upload_form=upload_form, group_form=group_form)
    except Exception as exc:
        return render_template_string(end_user_debugging("customers"))
    # end of surrounding try-except
# end of customers view function for route /customers/<int:i_company_id>/


@bp.route("/customer_details/<int:i_customer_id>/", methods=["GET"])
@login_required
def customer_details(i_customer_id:int = 0):
    """customer details"""
    try:
        d_out = {}
        o_customer = db.session.get(tbl_customers, i_customer_id)
        if o_customer is not None:
            d_out = dict_instance(o_customer)
        # end of checking if record retrieved
        return make_response(jsonify(d_out), 200)
    except Exception as exc:
        return render_template_string(end_user_debugging("customer details"))
    # end of surrounding try-except
# end of customer_details view function for route /customer_details/<int: i_customer_id>


@bp.route("/customer_groups/<int:i_company_id>/", methods=["GET", "POST"])
@login_required
def customer_groups(i_company_id:int):
    """customer groups on a per company basis"""
    try:
        # redirect if not company member
        if current_user.i_company_id!=i_company_id: return redirect(url_for("main.index"))
        s_company_name = ""
        if i_company_id>0:
            o_company = db.session.get(tbl_companies, i_company_id)
            if o_company is not None:
                s_company_name = o_company.v_organisation_name
            # end of checking for company retrieval
        # end of checking if company user
        i_group_id = request.form.get("hid_group_id", 0, type=int)
        group_form = CustomerGroupForm()
        remove_form = RemoveCustomerGroupForm()
        if group_form.validate_on_submit() and request.form.get("btn_save_group", None) is not None:
            i_group_id, s_group_name, s_group_description = (int(group_form.hid_group_id.data), str(group_form.txt_group_name.data), str(group_form.txt_group_description.data))
            o_group = None
            s_activity = "updated"
            if i_group_id>0:
                o_group = db.session.get(tbl_customer_groups, i_group_id)
                if o_group is not None:
                    if db.session.query(tbl_customer_groups).filter(tbl_customer_groups.id!=i_group_id, tbl_customer_groups.v_group_name==s_group_name, tbl_customer_groups.i_company_id==i_company_id).count()<1:
                        o_group.v_group_name = s_group_name
                        o_group.v_description = s_group_description
                        db.session.add(o_group)
                        db.session.commit()
                        flash("Group updated")
                    else:
                        flash("There is another group with same name")
                    # end of checking for existing group name
                else:
                    flash("Group could not be retrieved")
                # end of checking if record retrieved
            else:
                s_activity = "inserted"
                if db.session.query(tbl_customer_groups).filter(tbl_customer_groups.i_company_id==i_company_id, tbl_customer_groups.v_group_name==s_group_name).count()<1:
                    o_group = tbl_customer_groups(i_company_id=i_company_id, v_group_name=s_group_name, v_description=s_group_description)
                    db.session.add(o_group)
                    db.session.commit()
                    flash("Group added")
                else:
                    flash("There is another group with the same name under company")
                # end of checking if there was another existing record with same name
            # end of checking if new or existing record
        elif remove_form.validate_on_submit() and request.form.get("hid_remove_group_id", None) is not None:
            i_group_id = int(remove_form.hid_remove_group_id.data)
            o_group = db.session.get(tbl_customer_groups, i_group_id)
            if o_group is not None:
                if o_group.i_company_id==current_user.i_company_id:
                    db.session.delete(o_group)
                    db.session.commit()
                    flash("Group record removed")
                # end of making sure group is under same company as user
            # end of first checking for retrieval
        # end of checking for form submission
        group_form.hid_group_id.data, group_form.txt_group_name.data, group_form.txt_group_description.data = (0, "", "")
        remove_form.hid_remove_group_id.data = 0
        i_page = request.form.get("hid_page", 1, type=int)
        q_groups = db.session.query(tbl_customer_groups.id, tbl_customer_groups.v_group_name, tbl_customer_groups.v_description).filter(tbl_customer_groups.i_company_id==i_company_id).order_by(tbl_customer_groups.v_group_name)
        pagination = q_groups.paginate(page=i_page, per_page=20)
        l_groups = list(map(dict_row, pagination.items))
        s_base = "base_bs.html" if Config.BOOTSTRAP else "base.html"
        s_url = url_for("main.customer_groups", i_company_id=i_company_id)#, _external=True)
        return render_template("customer_groups.html", js=True, base=s_base, url=s_url, paging=pagination, page=i_page, company_id=i_company_id, company_name=s_company_name, groups=l_groups, group_form=group_form, remove_form=remove_form)
    except Exception as exc:
        return render_template_string(end_user_debugging("customer groups"))
    # end of surrounding try-except
# end of customer_groups view function for route /customer_groups/<int:i_company_id>/


@bp.route("/group_details/<int:i_group_id>/", methods=["GET"])
@login_required
def group_details(i_group_id:int = 0):
    """customer group details"""
    try:
        d_out = {}
        o_group = db.session.get(tbl_customer_groups, i_group_id)
        if o_group is not None:
            if o_group.i_company_id!=current_user.i_company_id:
                return make_response("Incorrect Customer Group selection", 404)
            else:
                d_out = dict_instance(o_group)
            # end of making sure group and current_user fall under same company
        else:
            return make_response("Customer group could not be retrieved", 404)
        # end of checking if record retrieved
        return make_response(jsonify(d_out), 200)
    except Exception as exc:
        return render_template_string(end_user_debugging("customer group details"))
    # end of surrounding try-except
# end of group_details view function for route /group_details/<int: i_group_id>


@bp.route("/group_customers/<int:i_group_id>/", methods=["GET", "POST"])
@login_required
def group_customers(i_group_id:int):
    """allocate customers to a group on a per company basis"""
    try:
        # redirect if group not under user company
        i_company_id = current_user.i_company_id
        o_group = db.session.get(tbl_customer_groups, i_group_id)
        if o_group is None: return redirect(url_for("main.index"))
        if o_group.i_company_id!=current_user.i_company_id: return redirect(url_for("main.index"))
        s_group_name = o_group.v_group_name
        l_countries, d_countries = populate_countries()
        l_countries.insert(0, (0, "---all---"))
        s_filter_names = request.form.get("txt_filter_names", "", type=str)
        i_filter_country = request.form.get("sel_country_filter", 0, type=int)
        s_filter_nationality = d_countries.get(i_filter_country, "")
        change_form = CustomerGroupMembersChangeForm()
        if change_form.validate_on_submit() and request.form.get("hid_membership_change", None) is not None:
            bl_changed = False
            s_add = str(change_form.hid_membership_add.data).strip()
            s_remove = str(change_form.hid_membership_remove.data).strip()
            if s_remove!="":
                l_removal = list(map(int, s_remove.split(",")))
                q_del = delete(tbl_customer_group_members).where(tbl_customer_group_members.i_group_id==i_group_id)
                for i_customer_id in l_removal:
                    q_del2 = q_del.where(tbl_customer_group_members.i_customer_id==i_customer_id)
                    res = db.session.execute(q_del2)
                # end of looping through removal customers
                db.session.commit()
                bl_changed = True
            # end of checking if need to remove members
            if s_add!="":
                q_insert = insert(tbl_customer_group_members)
                bl_commit = False
                for i_customer_id in list(map(int, s_add.split(","))):
                    if db.session.query(tbl_customer_group_members.id).filter(tbl_customer_group_members.i_group_id==i_group_id, tbl_customer_group_members.i_customer_id==i_customer_id).count()<1:
                        res = db.session.execute(q_insert.values({"i_group_id": i_group_id, "i_customer_id": i_customer_id}))
                        bl_commit = True
                    # end of making sure need to insert record
                # end of looping through customers that need to be added
                if bl_commit:
                    db.session.commit()
                    bl_changed = True
                # end of making sure need to commit changes
            # end of checking if need to add members
            if bl_changed: flash("Membership changes saved")
        # end of checking for change membership form submission
        i_page = request.form.get("hid_page", 1, type=int)
        sq_membership = select(tbl_customer_group_members.i_customer_id).filter(tbl_customer_group_members.i_group_id==i_group_id)
        q_customers = db.session.query(tbl_customers.id, tbl_customers.i_id_type, tbl_customer_id_types.v_description.label("v_id_type"), tbl_customers.v_id_number, tbl_customers.v_first_names, tbl_customers.v_last_name, tbl_customers.v_mobile_number, tbl_customers.v_email, tbl_customers.v_nationality, tbl_customers.id.in_(sq_membership).label("bl_membership")).join(tbl_customer_id_types, tbl_customer_id_types.id==tbl_customers.i_id_type)
        q_customers = q_customers.order_by(tbl_customers.v_last_name, tbl_customers.v_first_names)
        if s_filter_names!="": q_customers = q_customers.filter(tbl_customers.v_first_names.like(f"%{s_filter_names}%") | tbl_customers.v_last_name.like(f"%{s_filter_names}%"))
        if s_filter_nationality!="": q_customers = q_customers.filter(tbl_customers.v_nationality==s_filter_nationality)
        q_customers = q_customers.join(tbl_customers_companies, tbl_customers_companies.i_customer_id==tbl_customers.id).filter(tbl_customers_companies.i_company_id==i_company_id)
        l_membership = db.session.execute(sq_membership).all()
        l_membership = list(map((lambda x : x[0]), l_membership))
        o_company = db.session.get(tbl_companies, i_company_id)
        s_company_name = o_company.v_organisation_name
        pagination = q_customers.paginate(page=i_page, per_page=50)
        l_customers = list(map(dict_row, pagination.items))
        s_base = "base_bs.html" if Config.BOOTSTRAP else "base.html"
        s_url = url_for("main.group_customers", i_group_id=i_group_id)#, _external=True)
        return render_template("group_customers.html", js=True, base=s_base, url=s_url, group_id=i_group_id, customers=l_customers, paging=pagination, page=i_page, company_name=s_company_name, group_name=s_group_name, filter_names=s_filter_names, countries=l_countries, country_filter=i_filter_country, membership=l_membership, change_form=change_form)
    except Exception as exc:
        return render_template_string(end_user_debugging("customer group members"))
    # end of surrounding try-except
# end of group_customers view function for route /group_customers/<int:i_group_id>/


@bp.route("/company_users/<int:i_company_id>/", methods=["GET", "POST"])
@bp.route("/company_users/", defaults={"i_company_id": 0}, methods=["GET", "POST"])
@login_required
@check_admin
def company_users(i_company_id:int = 0):
    """company users administration page"""
    try:
        if current_user.bl_admin!=True and i_company_id<1: return redirect(url_for("main.index"))
        q_companies = db.session.query(tbl_companies.id, tbl_companies.v_organisation_name).order_by(tbl_companies.v_organisation_name).all()
        l_companies = list(map(dict_row, q_companies))
        form = CompanyUserForm()
        form.sel_company.choices = list(map(tuple, q_companies))
        remove_form = RemoveCompanyUserForm()
        if form.validate_on_submit() and request.form.get("btn_save_user", None) is not None:
            i_user_id, s_user_id, i_company_id, s_password, s_password_confirm = (int(form.hid_user_id.data), str(form.txt_user_id.data), int(form.sel_company.data), str(form.txt_password.data), str(form.txt_password_confirm.data))
            if s_user_id!="" and i_company_id>0:
                o_user = None
                s_activity = "inserted"
                s_issue = "No activity to be performed"
                if i_user_id>0:
                    o_user = db.session.get(tbl_users, i_user_id)
                    s_activity = "updated"
                    # check which actions required
                    if s_user_id!=o_user.v_user_id:
                        # check that doesn't conflict with another user
                        if db.session.query(tbl_users.id).filter(tbl_users.id!=i_user_id, tbl_users.v_user_id==s_user_id).count()<1:
                            o_user.v_user_id = s_user_id
                            s_issue = ""
                        else:
                            s_issue = "There is another user with same User ID"
                        # end of checking for existing user match
                    # end of checking if changing user id
                    if (s_password!="" and s_password==s_password_confirm) and s_issue=="":
                        o_user.set_password(s_password)
                        s_activity = s_activity + " - Password changed"
                    # end of checking if should change password
                else:
                    if db.session.query(tbl_users.id).filter(tbl_users.v_user_id==s_user_id).count()<1:
                        if s_password!="" and s_password==s_password_confirm:
                            o_user = tbl_users(v_user_id=s_user_id, i_company_id=i_company_id, v_password=s_password)
                            s_issue = ""
                        else:
                            s_issue = "Password values must be submitted and must match"
                        # end of making sure password values submitted and match
                    else:
                        s_issue = "There is an existing user with same User ID"
                    # end of making sure there is not already another user with same user_id
                # end of checking if new or existing user
                if o_user is not None and s_issue=="":
                    db.session.add(o_user)
                    db.session.commit()
                    s_issue = ""
                    flash(f"Company user record {s_activity}")
                elif s_issue!="":
                    flash(s_issue)
                # end of making sure should continue with DB activity
            else:
                flash("User ID must be entered and company must be selected")
            # end of making sure s_user_id and i_company_id have been submitted
        elif remove_form.validate_on_submit() and request.form.get("hid_remove_user_id", None) is not None:
            i_company_user_id = int(remove_form.hid_remove_user_id.data)
            o_user = db.session.get(tbl_users, i_company_user_id)
            if o_user is not None:
                db.session.delete(o_user)
                db.session.commit()
                flash("Company user record removed")
            # end of making sure user record retrieved
        # end of checking for form submission
        form.hid_user_id.data, form.txt_user_id.data, form.sel_company.data, form.txt_password.data, form.txt_password_confirm.data = (0, "", i_company_id, "", "")
        q_users = db.session.query(tbl_users.id, tbl_users.v_user_id, tbl_users.i_company_id, tbl_companies.v_organisation_name).join(tbl_companies, tbl_companies.id==tbl_users.i_company_id)
        if i_company_id>0: q_users = q_users.filter(tbl_users.i_company_id==i_company_id)
        q_users = q_users.order_by(tbl_users.v_user_id)
        l_users = list(map(dict_row, q_users.all()))
        s_base = "base_bs.html" if Config.BOOTSTRAP else "base.html"
        s_url = url_for("main.company_users", i_company_id=i_company_id)#, _external=True)
        return render_template("company_users.html", js=True, base=s_base, url=s_url, company_id=i_company_id, companies=l_companies, users=l_users, form=form, remove_form=remove_form)
    except Exception as exc:
        return render_template_string(end_user_debugging("company users page"))
    # end of surrounding try-except
# end of company_users view function for route /company_users/<int:i_company_id>/


@bp.route("/company_user_details/<int:i_company_user_id>/", methods=["GET"])
@login_required
@check_admin
def company_user_details(i_company_user_id:int = 0):
    """company user details"""
    try:
        d_out = {}
        o_user = db.session.get(tbl_users, i_company_user_id)
        if o_user is not None:
            d_out = dict_instance(o_user)
        # end of checking if record retrieved
        return make_response(jsonify(d_out), 200)
    except Exception as exc:
        return render_template_string(end_user_debugging("company user details"))
    # end of surrounding try-except
# end of company_user_details view function for route /company_user_details/<int: i_user_id>


@bp.route("/campaigns", methods=["GET", "POST"])
@login_required
def campaigns():
    """campaigns page"""
    try:
        l_emails = list(map(tuple, db.session.query(tbl_emails.id, tbl_emails.v_title).filter(tbl_emails.i_company_id==current_user.i_company_id).order_by(tbl_emails.v_title).all()))
        l_email_reply_to_addresses = list(map(dict_row, db.session.query(tbl_company_email_addresses.id, tbl_company_email_addresses.v_email_address, tbl_company_email_addresses.v_reply_to_address, tbl_company_email_addresses.v_server_name).filter(tbl_company_email_addresses.i_company_id==current_user.i_company_id).order_by(tbl_company_email_addresses.v_email_address, tbl_company_email_addresses.v_server_name).all()))
        l_email_addresses = list(map((lambda x : (x["id"], " - ".join([x["v_email_address"], x["v_server_name"]]))), l_email_reply_to_addresses))
        form = CompanyCampaignForm()
        form.sel_email_id.choices = form.sel_email_id.choices + l_emails
        form.sel_company_email_address_id.choices = form.sel_company_email_address_id.choices + l_email_addresses
        remove_form = RemoveCompanyCampaignForm()
        if form.validate_on_submit() and request.form.get("btn_save_campaign", None) is not None:
            i_campaign_id, s_reference_number, s_campaign_title, s_description, i_email_id, d_target, t_target, i_company_email_address_id, s_email_from, s_email_reply_to = (int(form.hid_campaign_id.data), str(form.txt_reference_number.data), str(form.txt_campaign_title.data), str(form.txt_description.data), int(form.sel_email_id.data), form.d_target.data, form.t_target.data, int(form.sel_company_email_address_id.data), form.txt_email_from.data, form.txt_email_reply_to.data)
            d_target = d_target if isinstance(d_target, date) else datetime.now().date()
            t_target = t_target if isinstance(t_target, time) else datetime.now().time()
            dt_target = datetime(d_target.year, d_target.month, d_target.day, t_target.hour, t_target.minute).astimezone(timezone(timedelta(hours=2)))
            q_action = None
            s_activity = "inserted"
            d_values = {"v_reference_number": s_reference_number, "v_campaign_title": s_campaign_title, "v_description": s_description, "i_email_id": i_email_id, "dt_target": dt_target, "i_company_email_address_id": i_company_email_address_id, "v_email_from": s_email_from, "v_email_reply_to": s_email_reply_to, "i_company_id": current_user.i_company_id}
            if i_campaign_id>0:
                o_campaign = db.session.get(tbl_campaigns, i_campaign_id)
                if o_campaign is not None:
                    if db.session.query(tbl_campaigns).filter(tbl_campaigns.id!=i_campaign_id, tbl_campaigns.i_company_id==current_user.i_company_id, or_(tbl_campaigns.v_campaign_title==s_campaign_title, tbl_campaigns.v_reference_number==s_reference_number)).count()<1:
                        q_action = update(tbl_campaigns).where(tbl_campaigns.id==i_campaign_id)
                        s_activity = "updated"
                    else:
                        flash("There is another campaign with same title and/or reference number")
                      # end of making sure will not clash with another existing campaign
                # end of checking for record retrieval
            else:
                if db.session.query(tbl_campaigns).filter(tbl_campaigns.i_company_id==current_user.i_company_id, or_(tbl_campaigns.v_campaign_title==s_campaign_title, tbl_campaigns.v_reference_number==s_reference_number)).count()<1:
                    q_action = insert(tbl_campaigns)
                    d_values["i_company_id"] = current_user.i_company_id
                else:
                    flash("There is another campaign with same title and/or reference number")
                # end of checking for another existing campaign with same reference number or title
            # end of checking if new or existing
            if q_action is not None:
                res = db.session.execute(q_action.values(d_values))
                db.session.commit()
                if res.rowcount>0:
                    flash(f"Campaign record {s_activity}")
                # end of checking for execution result
            # end of checking if need to execute statement
        elif remove_form.validate_on_submit() and request.form.get("hid_remove_campaign_id", None) is not None:
            i_campaign_id = int(remove_form.hid_remove_campaign_id.data)
            o_campaign = db.session.get(tbl_campaigns, i_campaign_id)
            if o_campaign is not None:
                db.session.delete(o_campaign)
                db.session.commit()
                flash("Campaign removed")
            # end of checking for retrieval
        # end of checking for formr submission
        form.hid_campaign_id.data, form.txt_reference_number.data, form.txt_campaign_title.data, form.txt_description.data, form.sel_email_id.data, form.d_target.data, form.t_target.data, form.sel_company_email_address_id.data, form.txt_email_from.data, form.txt_email_reply_to.data = (0, "", "", "", 0, datetime.now().date(), datetime.now().time(), 0, "", "")
        remove_form.hid_remove_campaign_id.data = 0
        i_page = request.form.get("hid_page", 1, type=int)
        q_campaigns = db.session.query(tbl_campaigns.id, tbl_campaigns.v_reference_number, tbl_campaigns.v_campaign_title, func.substring(tbl_campaigns.v_description, 0, 50).label("v_description")).filter(tbl_campaigns.i_company_id==current_user.i_company_id).order_by(tbl_campaigns.v_reference_number, tbl_campaigns.v_campaign_title)
        pagination = q_campaigns.paginate(page=i_page, per_page=20)
        l_campaigns = list(map(dict_row, pagination.items))
        s_base = "base_bs.html" if Config.BOOTSTRAP else "base.html"
        s_url = url_for("main.campaigns")#, _external=True)
        return render_template("campaigns.html", js=True, base=s_base, url=s_url, form=form, page=i_page, paging=pagination, campaigns=l_campaigns, remove_form=remove_form, email_reply_to_addresses=l_email_reply_to_addresses)
    except Exception as exc:
        return render_template_string(end_user_debugging("campaigns page"))
    # end of surrounding try-except
# end of campaigns view function for route /campaigns


@bp.route("/campaign_details/<int:i_campaign_id>/", methods=["GET"])
@login_required
def campaign_details(i_campaign_id:int = 0):
    """campaign details"""
    try:
        d_out = {}
        o_campaign = db.session.get(tbl_campaigns, i_campaign_id)
        if o_campaign is not None:
            if o_campaign.i_company_id==current_user.i_company_id:
                d_out = dict_instance(o_campaign)
                d_out["dt_target"] = d_out["dt_target"] if isinstance(d_out["dt_target"], datetime) else datetime.now()# .strftime("%Y-%m-%dT%H:%M:00") if isinstance(d_out["dt_target"], datetime) else None
                d_out["d_target"] = d_out["dt_target"].strftime("%Y-%m-%d")
                d_out["t_target"] = d_out["dt_target"].strftime("%H:%M")
            # end of company match check
        # end of checking if record retrieved
        return make_response(jsonify(d_out), 200)
    except Exception as exc:
        return render_template_string(end_user_debugging("campaign details"))
    # end of surrounding try-except
# end of campaign_details view function for route /campaign_details/<int:i_campaign_id>


@bp.route("/email_templates", methods=["GET", "POST"])
@login_required
def email_templates():
    """email templates page"""
    try:
        d_tags = {"title": tbl_customers.v_title, "full_names": (tbl_customers.v_first_names, tbl_customers.v_last_name), "mobile": tbl_customers.v_mobile_number}
        l_tags = list(d_tags.keys())
        form = EmailTemplateForm()
        remove_form = RemoveEmailTemplateForm()
        if form.validate_on_submit() and request.form.get("btn_save_email", None) is not None:
            i_email_id, s_title, s_subject, s_body = (int(form.hid_email_id.data), str(form.txt_title.data), str(form.txt_subject.data), str(form.txt_body.data))
            q_action = None
            s_activity = "inserted"
            if i_email_id>0:
                if db.session.query(tbl_emails).filter(tbl_emails.id!=i_email_id, tbl_emails.v_title==s_title, tbl_emails.v_subject==s_subject, tbl_emails.i_company_id==current_user.i_company_id).count()<1:
                    q_action = update(tbl_emails).where(tbl_emails.id==i_email_id)
                    s_activity = "updated"
                else:
                    flash("The combination of Title and Subject must be unique")
                # end of duplicate check
            else:
                if db.session.query(tbl_emails).filter(tbl_emails.v_title==s_title, tbl_emails.v_subject==s_subject, tbl_emails.i_company_id==current_user.i_company_id).count()<1:
                    q_action = insert(tbl_emails)
                else:
                    flash("The combination of Title and Subject must be unique")
                # end of existing duplicate check
            # end of checking if update or insert requested
            if q_action is not None:
                d_values = {"v_title": s_title, "v_subject": s_subject, "t_body": s_body, "i_company_id": current_user.i_company_id}
                q_action = q_action.values(d_values)
                db.session.execute(q_action)
                db.session.commit()
                flash(f"E-mail Template record {s_activity}")
            # end of additional None check against q_action
        elif remove_form.validate_on_submit() and request.form.get("hid_remove_email_id", None) is not None:
            i_email_id = int(remove_form.hid_remove_email_id.data)
            o_removal = db.session.get(tbl_emails, i_email_id)
            if o_removal is not None:
                db.session.delete(o_removal)
                db.session.commit()
                flash("E-Mail Template removed")
            # end of confirming retrieval
        # end of checking for form submission
        form.hid_email_id.data, form.txt_title.data, form.txt_subject.data, form.txt_body.data = (0, "", "", "")
        remove_form.hid_remove_email_id.data = 0
        q_emails = db.session.query(tbl_emails.id, tbl_emails.v_title, tbl_emails.v_subject).filter(tbl_emails.i_company_id==current_user.i_company_id).order_by(tbl_emails.v_title, tbl_emails.v_subject)
        i_page = request.form.get("hid_page", 1, type=int)
        pagination = q_emails.paginate(page=i_page, per_page=20)
        l_emails = list(map(dict_row, pagination.items))
        s_base = "base_bs.html" if Config.BOOTSTRAP else "base.html"
        s_url = url_for("main.email_templates")#, _external=True)
        return render_template("email_templates.html", js=True, base=s_base, url=s_url, form=form, emails=l_emails, paging=pagination, page=i_page, remove_form=remove_form, tags=l_tags)
    except Exception as exc:
        return render_template_string(end_user_debugging("e-mail templates page"))
    # end of surrounding try-except
# end of email_templates view function for route /campaigns


@bp.route("/email_template_editing/<int:i_email_id>/", methods=["GET", "POST"])
@login_required
def email_template_editing(i_email_id:int):
    """email template editing page"""
    try:
        d_tags = {"title": tbl_customers.v_title, "full_names": (tbl_customers.v_first_names, tbl_customers.v_last_name), "mobile": tbl_customers.v_mobile_number}
        l_tags = list(d_tags.keys())
        form = EmailTemplateForm()
        if form.validate_on_submit() and request.form.get("btn_save_email", None) is not None:
            s_title, s_subject, s_body = (str(form.txt_title.data), str(form.txt_subject.data), str(form.txt_body.data))
            q_action = None
            s_activity = "inserted"
            if i_email_id>0:
                if db.session.query(tbl_emails).filter(tbl_emails.id!=i_email_id, tbl_emails.v_title==s_title, tbl_emails.v_subject==s_subject, tbl_emails.i_company_id==current_user.i_company_id).count()<1:
                    q_action = update(tbl_emails).where(tbl_emails.id==i_email_id)
                    s_activity = "updated"
                else:
                    flash("The combination of Title and Subject must be unique")
                # end of duplicate check
            else:
                if db.session.query(tbl_emails).filter(tbl_emails.v_title==s_title, tbl_emails.v_subject==s_subject, tbl_emails.i_company_id==current_user.i_company_id).count()<1:
                    q_action = insert(tbl_emails)
                else:
                    flash("The combination of Title and Subject must be unique")
                # end of existing duplicate check
            # end of checking if update or insert requested
            if q_action is not None:
                d_values = {"v_title": s_title, "v_subject": s_subject, "t_body": s_body, "i_company_id": current_user.i_company_id}
                q_action = q_action.values(d_values)
                if s_activity=="updated":
                    db.session.execute(q_action)
                    db.session.commit()
                    flash(f"E-mail Template record {s_activity}")
                else:
                    res = db.session.execute(q_action.returning(tbl_emails.id))
                    i_email_id = res.one().id                
                    db.session.commit()
                    flash(f"E-mail Template record {s_activity}")
                    return redirect(url_for("main.email_template_editing", i_email_id=i_email_id))
                # end of checking for insert or update
            # end of additional None check against q_action
        # end of checking for form submission
        form.txt_title.data, form.txt_subject.data, form.txt_body.data = ("", "", "")
        if i_email_id>0:
            o_email = db.session.get(tbl_emails, i_email_id)
            if o_email is not None:
                if o_email.i_company_id==current_user.i_company_id:
                    form.txt_title.data, form.txt_subject.data, form.txt_body.data = (o_email.v_title, o_email.v_subject, o_email.t_body)
                else:
                    i_email_id = 0
                    flash("E-Mail template does not match parent company")
                    return redirect(url_for("main.email_template_editing", i_email_id=i_email_id))
                # end of company match check
            else:
                i_email_id = 0
                flash("E-Mail template details could not be retrieved")
                return redirect(url_for("main.email_template_editing", i_email_id=i_email_id))
            # end of checking if record retrieved
        # end of checking if need to lookup existing template or if new one
        s_base = "base_bs.html" if Config.BOOTSTRAP else "base.html"
        s_url = url_for("main.email_template_editing", i_email_id=i_email_id)#, _external=True)
        return render_template("email_template_editing.html", js=True, base=s_base, url=s_url, form=form, tags=l_tags, email_id=i_email_id)
    except Exception as exc:
        return render_template_string(end_user_debugging("e-mail template editing page"))
    # end of surrounding try-except
# end of email_templates view function for route /campaigns


@bp.route("/email_template_details/<int:i_email_id>/", methods=["GET"])
@login_required
def email_template_details(i_email_id:int = 0):
    """email template details"""
    try:
        d_out = {}
        o_email = db.session.get(tbl_emails, i_email_id)
        if o_email is not None:
            if o_email.i_company_id==current_user.i_company_id:
                d_out = dict_instance(o_email)
            # end of company match check
        # end of checking if record retrieved
        return make_response(jsonify(d_out), 200)
    except Exception as exc:
        return render_template_string(end_user_debugging("email template details"))
    # end of surrounding try-except
# end of email_template_details view function for route /email_template_details/<int:i_template_id>


@bp.route("/email_template_html/<int:i_email_id>/", methods=["GET"])
@login_required
def email_template_html(i_email_id:int = 0):
    """email template html"""
    try:
        s_out = ""
        o_email = db.session.get(tbl_emails, i_email_id)
        if o_email is not None:
            if o_email.i_company_id==current_user.i_company_id:
                d_out = dict_instance(o_email)
                s_out = d_out["t_body"]
            # end of company match check
        # end of checking if record retrieved
        return make_response(s_out, 200)
    except Exception as exc:
        return render_template_string(end_user_debugging("email template html"))
    # end of surrounding try-except
# end of email_template_html view function for route /email_template_html/<int:i_template_id>


def replace_click_throughs(s_html:str = "", s_base_url:str = "https://dev.blindza.com/bulk_mail/reroute/") -> dict:
    """remove title attribute and replace href attribute value with flask route to handle redirection later on, including UUID specific to this queued email - will have customer ID appended during sending"""
    d_out = {"html": s_html, "uuids": {}}
    if s_html.count("||##redirect##||")>0:
        bsh = bs(s_html, "html.parser")
        l_hrefs = bsh.find_all("a", title="||##redirect##||")
        for ix, a in enumerate(l_hrefs):
               del a["title"]
               s_uuid = str(uuid.uuid4())
               d_out["uuids"][s_uuid] = a["href"]
               a["href"] = s_base_url + s_uuid
        # end of looping through all href items
        d_out["html"] = str(bsh)
    # end of checking if contains title|placeholder marking string
    return d_out
# end of replace_click_throughs function


@bp.route("/campaign_sending/<int:i_campaign_id>/", methods=["GET", "POST"])
@login_required
def campaign_sending(i_campaign_id: int):
    """campaign sending details page"""
    try:
        o_campaign = db.session.get(tbl_campaigns, i_campaign_id)
        if o_campaign is None: return redirect(url_for("main.campaigns"))
        if o_campaign.i_company_id!=current_user.i_company_id: return redirect(url_for("main.campaigns"))
        upload_form = CampaignAttachmentUploadForm()
        remove_form = RemoveCampaignAttachmentForm()
        queue_form = QueueCampaignSendingForm()
        if upload_form.validate_on_submit() and request.form.get("btn_upload_attachment", None) is not None:
            fil_upload = request.files.get("fil_upload")
            if fil_upload is not None and fil_upload.filename!="":
                s_ext = os.path.splitext(fil_upload.filename)[1]
                if s_ext not in [".jpg", ".png", ".pdf", ".doc", ".docx"]:
                    abort(400)
                # end of double-checking file extension
                s_filename= fil_upload.filename
                s_mime_type = fil_upload.mimetype
                try:
                    o_attachment = tbl_attachments(i_campaign_id=i_campaign_id, v_file_name=s_filename, v_mime_type=s_mime_type, b_file=fil_upload.read())
                    db.session.add(o_attachment)
                    db.session.commit()
                    flash("Attachment uploaded")
                except Exception as exc:
                    print(str(exc))
                # end of try-except around saving attachment record
            else:
                flash("Invalid attachment file uploaded")
            # end of making sure file was uploaded
        elif remove_form.validate_on_submit() and request.form.get("hid_remove_attachment_id", None) is not None:
            i_attachment_id = int(remove_form.hid_remove_attachment_id.data)
            o_attachment = db.session.get(tbl_attachments, i_attachment_id)
            if o_attachment is not None:
                db.session.delete(o_attachment)
                db.session.commit()
                flash("Attachment removed")
            # end of checking record existed
        elif queue_form.validate_on_submit() and request.form.get("hid_campaign_queueing_id", None) is not None:
            if int(queue_form.hid_campaign_queueing_id.data)==i_campaign_id:
                # tbl_queued_emails, tbl_queued_attachments, tbl_queued_customers, tbl_queued_click_throughs
                o_email = db.session.get(tbl_emails, o_campaign.i_email_id)
                if o_email is not None:
                    o_email_sending = db.session.get(tbl_company_email_addresses, o_campaign.i_company_email_address_id)
                    if o_email_sending is not None:
                        # v_user_id, v_password, v_server_name, i_port, bl_secure, bl_starttls
                        d_values = {"v_subject": o_email.v_subject, "t_body": o_email.t_body, "i_company_id": current_user.i_company_id, "i_campaign_id": i_campaign_id, "dt_target": o_campaign.dt_target, "v_email_from": o_campaign.v_email_from, "v_email_reply_to": o_campaign.v_email_reply_to, "v_reference_number": o_campaign.v_reference_number, "v_user_id": o_email_sending.v_user_id, "v_password": o_email_sending.v_password, "v_server_name": o_email_sending.v_server_name, "i_port": o_email_sending.i_port, "bl_secure": o_email_sending.bl_secure, "bl_starttls": o_email_sending.bl_starttls}
                        # check if click-throughs were included
                        d_click_throughs = {"html": d_values["t_body"], "uuids": {}}
                        if d_values["t_body"].count("||##redirect##||")>0:
                            s_html = d_values["t_body"]
                            s_base_url = url_for("main.click_through_reroute", s_uuid="####", i_customer_id=9999, _external=True).replace("%23%23%23%23/9999/", "")
                            d_click_throughs = replace_click_throughs(s_html, s_base_url)
                            d_values["t_body"] = d_click_throughs["html"]
                        # end of checking for redirect click-throughs
                        res = db.session.execute(insert(tbl_queued_emails).values(d_values).returning(tbl_queued_emails.id))
                        i_queued_email_id = res.one().id
                        q_insert_attachment = insert(tbl_queued_attachments)
                        for o_attachment in db.session.query(tbl_attachments).filter(tbl_attachments.i_campaign_id==i_campaign_id).all():
                            db.session.execute(q_insert_attachment.values({"i_queued_email_id": i_queued_email_id, "v_file_name": o_attachment.v_file_name, "v_mime_type": o_attachment.v_mime_type, "b_file": o_attachment.b_file}))
                        # end of looping through possible attachments
                        q_click_through = insert(tbl_queued_click_throughs)
                        for s_uuid, s_url in d_click_throughs["uuids"].items():
                            db.session.execute(q_click_through.values({"i_queued_email_id": i_queued_email_id, "v_destination_url": s_url, "u_identify": uuid.UUID(s_uuid)}))
                        # end of looping through and inserting click through items
                        # handle populating email recipient listing
                        q_customers = db.session.query(tbl_customers).join(tbl_customer_group_members, tbl_customer_group_members.i_customer_id==tbl_customers.id).join(tbl_customer_groups, tbl_customer_groups.id==tbl_customer_group_members.i_group_id).join(tbl_campaign_groups, tbl_campaign_groups.i_group_id==tbl_customer_groups.id).filter(tbl_campaign_groups.i_campaign_id==i_campaign_id)
                        q_insert_customer = insert(tbl_queued_customers)
                        for o_customer in q_customers.all():
                            db.session.execute(q_insert_customer.values({"i_queued_email_id": i_queued_email_id, "v_first_names": o_customer.v_first_names, "v_last_name": o_customer.v_last_name, "v_mobile_number": o_customer.v_mobile_number, "v_email": o_customer.v_email, "v_title": o_customer.v_title, "i_customer_id": o_customer.id}))
                        # end of looping through customer records
                        db.session.commit()
                        flash("E-mail sending queued")
                    # end of checking for sending email retrieval
                # end of checking for email retrieval
            # end of checking for matching campaign ID
        # end of checking for form submission
        upload_form.fil_upload.data = None
        remove_form.hid_remove_attachment_id.data = 0
        queue_form.hid_campaign_queueing_id.data = i_campaign_id
        d_campaign = dict_instance(o_campaign)
        i_total_recipients = 0
        q_sq_customers = db.session.query(tbl_customer_group_members.id, tbl_customer_group_members.i_group_id).subquery()
        # q_groups = db.session.query(tbl_customer_groups.id, tbl_customer_groups.v_group_name, func.count(q_sq_customers.c.id).label("i_customer_count")).join(q_sq_customers, q_sq_customers.c.i_group_id==tbl_customer_groups.id, isouter=True).filter(tbl_customer_groups.i_company_id==current_user.i_company_id).group_by(tbl_customer_groups.id, tbl_customer_groups.v_group_name).order_by(tbl_customer_groups.v_group_name)
        q_groups = db.session.query(tbl_customer_groups.id, tbl_customer_groups.v_group_name, func.count(q_sq_customers.c.id).label("i_customer_count")).join(q_sq_customers, q_sq_customers.c.i_group_id==tbl_customer_groups.id, isouter=True)
        q_groups = q_groups.filter(tbl_customer_groups.i_company_id==current_user.i_company_id).group_by(tbl_customer_groups.id, tbl_customer_groups.v_group_name).order_by(tbl_customer_groups.v_group_name)
        l_groups = list(map(dict_row, q_groups.all()))
        # check if groups already assigned to campaign
        l_assigned = list(map((lambda x : x[0]), map(tuple, db.session.query(tbl_campaign_groups.i_group_id).filter(tbl_campaign_groups.i_campaign_id==i_campaign_id).all())))
        for ix, dg in enumerate(l_groups):
            dg["bl_assigned"] = True if dg["id"] in l_assigned else False
            i_total_recipients += int(dg["i_customer_count"]) if dg["bl_assigned"] else 0
        # end of looping through groups to confirm assignment
        o_email = None
        if o_campaign.i_email_id>0:
            o_email = db.session.get(tbl_emails, o_campaign.i_email_id)
        # end of checking if email template assigned
        q_attachments = db.session.query(tbl_attachments.id, tbl_attachments.v_file_name).filter(tbl_attachments.i_campaign_id==i_campaign_id).order_by(tbl_attachments.v_file_name)
        l_attachments = list(map(dict_row, q_attachments.all()))
        s_base = "base_bs.html" if Config.BOOTSTRAP else "base.html"
        s_url = url_for("main.campaign_sending", i_campaign_id=i_campaign_id)#, _external=True)
        return render_template("campaign_sending.html", js=True, base=s_base, url=s_url, campaign=o_campaign, email=o_email, groups=l_groups, upload_form=upload_form, remove_form=remove_form, attachments=l_attachments, campaign_id=i_campaign_id, total_recipients=i_total_recipients, queue_form=queue_form)
    except Exception as exc:
        return render_template_string(end_user_debugging("campaign sending page"))
    # end of surrounding try-except
# end of campaign_sending view function for route /campaign_sending/<int:i_campaign_id>/


@bp.route("/download_campaign_attachment/<int:i_attachment_id>/", methods=["GET"])
@login_required
def download_campaign_attachment(i_attachment_id:int = 0):
    """download campaign attachment for review"""
    try:
        o_out = None
        o_attachment = db.session.get(tbl_attachments, i_attachment_id)
        if o_attachment is not None:
            i_campaign_id = o_attachment.i_campaign_id
            o_campaign = db.session.get(tbl_campaigns, i_campaign_id)
            if o_campaign is not None:
                if o_campaign.i_company_id==current_user.i_company_id:
                    o_out = io.BytesIO(o_attachment.b_file)
                    s_mimetype = o_attachment.v_mime_type
                    s_filename = o_attachment.v_file_name
                    s_mimetype = "application/msword" if s_filename.lower().endswith(".doc") else "application/vnd.openxmlformats-officedocument.wordprocessingml.document" if s_filename.lower().endswith(".docx") else s_mimetype
                    resp = send_file(o_out, mimetype=s_mimetype, as_attachment=True, download_name=s_filename)
                    return resp
                else:
                    return make_response("Attachment not linked to valid campaign", 500)
                # end of making sure attachment campaign is linked to current_user company
            # end of making sure matching campaign could be retrieved
        else:
            return make_response("No attachment retrieved", 500)
        # end of None check for record
    except Exception as exc:
        return render_template_string(end_user_debugging("download campaign attachment"))
    # end of surrounding try-except
# end of download_campaign_attachment view function for route /download_campaign_attachment/<int:i_attachment_id>/


@bp.route("/toggle_campaign_group/<int:i_campaign_id>/<int:i_group_id>/<bl_assigned>/", methods=["GET"])
@login_required
def toggle_campaign_group(i_campaign_id:int = 0, i_group_id:int = 0, bl_assigned:bool = False):
    """toggle campaign group assignment"""
    try:
        bl_assigned = False if str(bl_assigned).lower()=="false" else True
        # print([i_campaign_id, i_group_id, bl_assigned]);
        o_campaign = db.session.get(tbl_campaigns, i_campaign_id)
        if o_campaign is not None:
            if o_campaign.i_company_id==current_user.i_company_id:
                o_group = db.session.get(tbl_customer_groups, i_group_id)
                if o_group is not None:
                    if o_group.i_company_id==current_user.i_company_id:
                        i_assigned = db.session.query(tbl_campaign_groups).filter(tbl_campaign_groups.i_group_id==i_group_id, tbl_campaign_groups.i_campaign_id==i_campaign_id).count()
                        if bl_assigned and i_assigned<1:
                            db.session.execute(insert(tbl_campaign_groups).values({"i_group_id": i_group_id, "i_campaign_id": i_campaign_id}))
                            db.session.commit()
                            return make_response("Group assigned to campaign", 200)
                        elif not bl_assigned and i_assigned>0:
                            db.session.execute(delete(tbl_campaign_groups).where(tbl_campaign_groups.i_group_id==i_group_id and tbl_campaign_groups.i_campaign_id==i_campaign_id))
                            db.session.commit()
                            return make_response("Group assignment to campaign removed", 200)
                        else:
                            return make_response(f"bl_assigned = {bl_assigned} and i_assigned was {i_assigned}", 200)
                        # end of determining if need to toggle assignation on or off
                    else:
                        return make_response("Invalid customer group", 500)
                    # end of making sure group company also matches current_user.i_company_id
                else:
                    return make_response("Invalid customer group", 500)
                # end of making sure group record could be retrieved
            else:
                return make_response("Invalid campaign", 500)
            # end of checking if campaign company matches current_user company
        else:
            return make_response("Invalid campaign", 500)
        # end of making sure campaign could be retrieved
    except Exception as exc:
        return render_template_string(end_user_debugging("toggle campaign group"))
    # end of surrounding try-except
# end of toggle_campaign_group view function for route /toggle_campaign_group/<int:i_campaign_id>/<int:i_group_id>/<bl_assigned>/


@bp.route("/queued_emails", methods=["GET", "POST"])
@login_required
def queued_emails():
    """queued e-mails page"""
    try:
        bl_processed = True if request.form.get("chk_filter_processed", None) is not None else False
        q_emails = db.session.query(tbl_queued_emails.id, tbl_queued_emails.v_subject, tbl_queued_emails.dt_target, tbl_queued_emails.bl_active, tbl_queued_emails.bl_done).filter(tbl_queued_emails.i_company_id==current_user.i_company_id, tbl_queued_emails.bl_done==bl_processed).order_by(tbl_queued_emails.dt_target, tbl_queued_emails.v_subject)
        i_page = request.form.get("hid_page", 1, type=int)
        pagination = q_emails.paginate(page=i_page, per_page=20)
        l_emails = list(map(dict_row, pagination.items))
        s_base = "base_bs.html" if Config.BOOTSTRAP else "base.html"
        s_url = url_for("main.queued_emails")#, _external=True)
        return render_template("queued.html", js=True, base=s_base, url=s_url, page=i_page, paging=pagination, emails=l_emails, processed=bl_processed)
    except Exception as exc:
        return render_template_string(end_user_debugging("queued e-mails page"))
    # end of surrounding try-except
# end of queued_emails view function for route /queued_emails


@bp.route("/queued_details/<int:i_queued_id>/", methods=["GET"])
@login_required
def queued_details(i_queued_id:int = 0):
    """queued e-mail details"""
    try:
        d_out = {}
        o_queued = db.session.get(tbl_queued_emails, i_queued_id)
        if o_queued is not None:
            if o_queued.i_company_id==current_user.i_company_id:
                d_out = dict_instance(o_queued)
                d_out["dt_target"] = d_out["dt_target"] if isinstance(d_out["dt_target"], datetime) else datetime.now()# .strftime("%Y-%m-%dT%H:%M:00") if isinstance(d_out["dt_target"], datetime) else None
                d_out["d_target"] = d_out["dt_target"].strftime("%Y-%m-%d")
                d_out["t_target"] = d_out["dt_target"].strftime("%H:%M")
                l_attachments = list(map(tuple, db.session.query(tbl_queued_attachments.v_file_name).filter(tbl_queued_attachments.i_queued_email_id==o_queued.id).order_by(tbl_queued_attachments.v_file_name).all()))
                l_attachments = list(map((lambda x : x[0]), l_attachments)) if len(l_attachments)>0 else []
                i_customers = db.session.query(tbl_queued_customers.id).filter(tbl_queued_customers.i_queued_email_id==o_queued.id).count()
                d_out["attachments"], d_out["customer_count"] = (l_attachments, i_customers)
            # end of company match check
        # end of checking if record retrieved
        return make_response(jsonify(d_out), 200)
    except Exception as exc:
        return render_template_string(end_user_debugging("queued e-mail details"))
    # end of surrounding try-except
# end of queued_details view function for route /queued_details/<int:i_queued_id>


@bp.route("/toggle_queued_active/<int:i_queued_id>/<bl_active>/", methods=["GET"])
@login_required
def toggle_queued_active(i_queued_id:int = 0, bl_active:bool = True):
    """toggle queued email active state"""
    try:
        bl_active = False if str(bl_active).lower()=="false" else True
        # print([i_campaign_id, i_group_id, bl_assigned]);
        o_queued = db.session.get(tbl_queued_emails, i_queued_id)
        if o_queued is not None:
            if o_queued.i_company_id==current_user.i_company_id:
                if o_queued.bl_active!=bl_active:
                    o_queued.bl_active=bl_active
                    db.session.add(o_queued)
                    db.session.commit()
                    return make_response("Active state changed", 200)
                # end of making sure state change was requested
            else:
                return make_response("Invalid queued e-mail", 500)
            # end of checking if queued e-mail company matches current_user company
        else:
            return make_response("Invalid queued e-mail", 500)
        # end of making sure queued e-mail could be retrieved
    except Exception as exc:
        return render_template_string(end_user_debugging("toggle queued e-mail active state"))
    # end of surrounding try-except
# end of toggle_queued_active view function for route /toggle_queued_active/<int:i_queued_id>/<int:i_group_id>/<bl_assigned>/


@bp.route("/company_email_addresses", methods=["GET", "POST"])
@login_required
def company_email_addresses():
    """company e-mail addresses page"""
    try:
        form = CompanyEmailAddressForm()
        remove_form = RemoveCompanyEmailAddressForm()
        if form.validate_on_submit() and request.form.get("btn_save_email", None) is not None:
            i_email_id, s_email_address, s_reply_to_address, s_user_id, s_password, s_server_name, i_port, bl_secure, bl_starttls = (int(form.hid_email_id.data), str(form.txt_email_address.data), str(form.txt_reply_to_address.data), str(form.txt_user_id.data), str(form.txt_password.data), str(form.txt_server_name.data), int(form.txt_port.data), bool(form.chk_secure.data), bool(form.chk_starttls.data))
            q_action = None
            s_activity = "inserted"
            d_values = {"v_email_address": s_email_address, "v_reply_to_address": s_reply_to_address, "v_user_id": s_user_id, "v_password": s_password, "v_server_name": s_server_name, "i_port": i_port, "bl_secure": bl_secure, "bl_starttls": bl_starttls}
            if i_email_id>0:
                o_email = db.session.get(tbl_company_email_addresses, i_email_id)
                if o_email is not None:
                    if db.session.query(tbl_company_email_addresses).filter(tbl_company_email_addresses.id!=i_email_id, tbl_company_email_addresses.i_company_id==current_user.i_company_id, tbl_company_email_addresses.v_email_address==s_email_address, tbl_company_email_addresses.v_server_name==s_server_name).count()<1:
                        q_action = update(tbl_company_email_addresses).where(tbl_company_email_addresses.id==i_email_id)
                        s_activity = "updated"
                    else:
                        flash("There is another outgoing e-mail address with same values for both e-mail address and server name")
                      # end of making sure will not clash with another existing campaign
                # end of checking for record retrieval
            else:
                if db.session.query(tbl_company_email_addresses).filter(tbl_company_email_addresses.i_company_id==current_user.i_company_id, tbl_company_email_addresses.v_email_address==s_email_address, tbl_company_email_addresses.v_server_name==s_server_name).count()<1:
                    q_action = insert(tbl_company_email_addresses)
                    d_values["i_company_id"] = current_user.i_company_id
                else:
                    flash("There is another outgoing e-mail address with same value")
                # end of checking for another existing campaign with same reference number or title
            # end of checking if new or existing
            if q_action is not None:
                res = db.session.execute(q_action.values(d_values))
                db.session.commit()
                if res.rowcount>0:
                    flash(f"Outgoing e-mail address record {s_activity}")
                # end of checking for execution result
            # end of checking if need to execute statement
        elif remove_form.validate_on_submit() and request.form.get("hid_remove_email_id", None) is not None:
            i_email_id = int(remove_form.hid_remove_email_id.data)
            o_email = db.session.get(tbl_company_email_addresses, i_email_id)
            if o_email is not None:
                if o_email.i_company_id==current_user.i_company_id:
                    db.session.delete(o_email)
                    db.session.commit()
                    flash("Outgoing e-mail address removed")
                # end of checking company match
            # end of checking for retrieval
        # end of checking for formr submission
        form.hid_email_id.data, form.txt_email_address.data, form.txt_reply_to_address.data, form.txt_user_id.data, form.txt_password.data, form.txt_server_name.data, form.txt_port.data, form.chk_secure.data, form.chk_starttls.data = (0, "", "", "", "", "", 587, True, True)
        remove_form.hid_remove_email_id.data = 0
        i_page = request.form.get("hid_page", 1, type=int)
        q_emails = db.session.query(tbl_company_email_addresses.id, tbl_company_email_addresses.v_email_address, tbl_company_email_addresses.v_server_name).filter(tbl_company_email_addresses.i_company_id==current_user.i_company_id).order_by(tbl_company_email_addresses.v_email_address, tbl_company_email_addresses.v_server_name)
        pagination = q_emails.paginate(page=i_page, per_page=20)
        l_emails = list(map(dict_row, pagination.items))
        s_base = "base_bs.html" if Config.BOOTSTRAP else "base.html"
        s_url = url_for("main.company_email_addresses")#, _external=True)
        return render_template("company_email_addresses.html", js=True, base=s_base, url=s_url, form=form, page=i_page, paging=pagination, emails=l_emails, remove_form=remove_form)
    except Exception as exc:
        return render_template_string(end_user_debugging("company e-mail addresses page"))
    # end of surrounding try-except
# end of company_email_addresses view function for route /company_email_addresses


@bp.route("/company_email_address_details/<int:i_email_id>/", methods=["GET"])
@login_required
def company_email_address_details(i_email_id:int = 0):
    """company e-mail address details"""
    try:
        d_out = {}
        o_email = db.session.get(tbl_company_email_addresses, i_email_id)
        if o_email is not None:
            if o_email.i_company_id==current_user.i_company_id:
                d_out = dict_instance(o_email)
            # end of company match check
        # end of checking if record retrieved
        return make_response(jsonify(d_out), 200)
    except Exception as exc:
        return render_template_string(end_user_debugging("company e-mail address details"))
    # end of surrounding try-except
# end of company_email_address_details view function for route /company_email_address_details/<int:i_email_id>


@bp.route("/campaign_reports/<int:i_campaign_id>/", methods=["GET"])
@bp.route("/campaign_reports/", defaults={"i_campaign_id": 0}, methods=["GET", "POST"])
@login_required
def campaign_reports(i_campaign_id:int = 0):
    """campaign sending result reports"""
    try:
        i_page = request.form.get("hid_page", 1, type=int)
        filter_form = CampaignReportsFilterForm()
        s_campaign_id, d_start, d_end = ("", date(2025, 1, 1), date(datetime.now().year, 12, 31))
        if request.form.get("btn_clear_filter", None) is not None:
            s_campaign_id, d_start, d_end = ("", date(2025, 1, 1), date(datetime.now().year, 12, 31))
        elif filter_form.validate_on_submit() and request.form.get("btn_filter", None) is not None:
            s_campaign_id = str(filter_form.txt_campaign_id.data)
            d_start = filter_form.d_start.data
            d_end = filter_form.d_end.data
        # end of checking for form submission
        filter_form.hid_page.data, filter_form.txt_campaign_id.data, filter_form.d_start.data, filter_form.d_end.data = (i_page, s_campaign_id, d_start, d_end)
        dt_start = datetime(d_start.year, d_start.month, d_start.day, 0, 0, 0)
        dt_end = datetime(d_end.year, d_end.month, d_end.day, 23, 59, 0)
        s_start = d_start.strftime("%Y-%m-%d")
        s_end = d_end.strftime("%Y-%m-%d")
        q_campaigns = db.session.query(tbl_campaigns.id, tbl_campaigns.v_campaign_title, tbl_campaigns.v_reference_number, tbl_queued_emails.id.label("i_queued_email_id"), tbl_queued_emails.v_email_from, tbl_queued_emails.dt_target, tbl_queued_emails.bl_done, tbl_queued_emails.dt_started, tbl_queued_emails.dt_processed, tbl_queued_emails.v_result)\
            .join(tbl_queued_emails, tbl_queued_emails.i_campaign_id==tbl_campaigns.id, isouter=False)
        q_campaigns = q_campaigns.filter(tbl_campaigns.i_company_id==current_user.i_company_id, tbl_queued_emails.bl_done==True)
        q_campaigns = q_campaigns.filter(tbl_queued_emails.dt_target>dt_start).filter(tbl_queued_emails.dt_target<dt_end)
        q_campaigns = q_campaigns.order_by(tbl_queued_emails.dt_processed.desc())
        pagination = q_campaigns.paginate(page=i_page, per_page=20)
        l_campaigns = list(map(dict_row, pagination.items))
        # attachment count and success and failure figures
        for ix, d_campaign in enumerate(l_campaigns):
            i_total = db.session.query(tbl_queued_customers.id).filter(tbl_queued_customers.i_queued_email_id==d_campaign["i_queued_email_id"]).count()
            i_success = db.session.query(tbl_queued_customers.id).filter(tbl_queued_customers.i_queued_email_id==d_campaign["i_queued_email_id"], tbl_queued_customers.bl_success==True).count()
            i_failure = db.session.query(tbl_queued_customers.id).filter(tbl_queued_customers.i_queued_email_id==d_campaign["i_queued_email_id"], tbl_queued_customers.bl_success==False).count()
            s_success = "{0:.2f}%".format(float(i_success)/i_total*100)
            s_failure = "{0:.2f}%".format(float(i_failure)/i_total*100)
            d_campaign["i_total"], d_campaign["i_success"], d_campaign["i_failure"], d_campaign["s_success"], d_campaign["s_failure"] = (i_total, i_success, i_failure, s_success, s_failure)
            i_attachment_count = db.session.query(tbl_queued_attachments.id).filter(tbl_queued_attachments.i_queued_email_id==d_campaign["i_queued_email_id"]).count()
            d_campaign["i_attachments"] = i_attachment_count
            # click-through totals
            i_clicks = db.session.query(tbl_queued_click_through_records.id).join(tbl_queued_click_throughs, tbl_queued_click_throughs.id==tbl_queued_click_through_records.i_queued_click_through_id).filter(tbl_queued_click_throughs.i_queued_email_id==d_campaign["i_queued_email_id"]).count()
            d_campaign["i_clicks"] = i_clicks
        # end of looping through page records
        s_base = "base_bs.html" if Config.BOOTSTRAP else "base.html"
        s_url = url_for("main.campaign_reports", i_campaign_id=i_campaign_id)#, _external=True)
        return render_template("campaign_reports.html", js=True, base=s_base, url=s_url, page=i_page, paging=pagination, filter_form=filter_form, campaigns=l_campaigns, campaign_id=i_campaign_id, start=s_start, end=s_end)
    except Exception as exc:
        return render_template_string(end_user_debugging("campaign reports page"))
    # end of surrounding try-except
# end of campaign_reports view function for route /campaign_report/<int:i_campaign_id>/


@bp.route("/queued_details_after/<int:i_queued_id>/", methods=["GET"])
@login_required
def queued_details_after(i_queued_id:int = 0):
    """queued e-mail details after sending"""
    try:
        d_out = {}
        o_queued = db.session.get(tbl_queued_emails, i_queued_id)
        if o_queued is not None:
            if o_queued.i_company_id==current_user.i_company_id:
                d_out = dict_instance(o_queued)
                d_out["dt_target"] = d_out["dt_target"].strftime("%Y-%m-%dT%H:%M:00") if isinstance(d_out["dt_target"], datetime) else ""
                d_out["dt_processed"] = d_out["dt_processed"].strftime("%Y-%m-%dT%H:%M:00") if isinstance(d_out["dt_processed"], datetime) else ""
                l_attachments = list(map(tuple, db.session.query(tbl_queued_attachments.v_file_name).filter(tbl_queued_attachments.i_queued_email_id==o_queued.id).order_by(tbl_queued_attachments.v_file_name).all()))
                l_attachments = list(map((lambda x : x[0]), l_attachments)) if len(l_attachments)>0 else []
                i_customers = db.session.query(tbl_queued_customers.id).filter(tbl_queued_customers.i_queued_email_id==o_queued.id).count()
                d_out["attachments"], d_out["customer_count"] = (l_attachments, i_customers)
            # end of company match check
        # end of checking if record retrieved
        return make_response(jsonify(d_out), 200)
    except Exception as exc:
        return render_template_string(end_user_debugging("queued e-mail details after sending"))
    # end of surrounding try-except
# end of queued_details_after view function for route /queued_details/<int:i_queued_id>


s_not = """
Per customer/recipient details report on a campaign sending basis - Sortable table with exportable logs.:
1. Recipient details (name, email/phone).
2. Timestamp of send/receipt.
3. Delivery status (delivered, failed, invalid).
4. Reply/click-through details (content, timestamp).
"""

@bp.route("/queued_email_recipients/<int:i_email_id>/", methods=["GET", "POST"])
@login_required
def queued_email_recipients(i_email_id:int = 0):
    """reporting on lists of customers e-mails were sent to"""
    try:
        export_form = RecipientsExportForm()
        o_email = db.session.get(tbl_queued_emails, i_email_id)
        if o_email is not None:
            if o_email.i_company_id==current_user.i_company_id and o_email.bl_done==True:
                export_form.hid_export_email_id.data = o_email.id
                dt_processed = o_email.dt_processed
                i_page = request.form.get("hid_page", 1, type=int)
                s_status = request.form.get("sel_status", "all")
                # ["all", "success", "failed"]
                s_sort_field = request.args.get("sort", "v_last_name")
                s_sort_dir = request.args.get("sort_dir", "asc")
                d_order = {"v_last_name": {"asc": tbl_queued_customers.v_last_name, "desc": tbl_queued_customers.v_last_name.desc()}, "v_first_names": {"asc": tbl_queued_customers.v_first_names, "desc": tbl_queued_customers.v_first_names.desc()}, "v_email": {"asc": tbl_queued_customers.v_email, "desc": tbl_queued_customers.v_email.desc()}, "dt_processed": {"asc": tbl_queued_customers.dt_processed, "desc": tbl_queued_customers.dt_processed.desc()}}
                l_clicks = list(map((lambda x : x[0]), list(map(tuple, db.session.query(tbl_queued_click_through_records.id).join(tbl_queued_click_throughs, tbl_queued_click_throughs.id==tbl_queued_click_through_records.i_queued_click_through_id, isouter=False).filter(tbl_queued_click_throughs.i_queued_email_id==i_email_id).all()))))
                # sq_clicks = db.session.query(tbl_queued_click_throughs.i_queued_email_id, tbl_queued_click_through_records.i_queued_customer_id, func.sum(tbl_queued_click_through_records.si_count).label("si_count"), func.max(tbl_queued_click_through_records.dt_last).label("dt_last")).join(tbl_queued_click_through_records, tbl_queued_click_through_records.i_queued_click_through_id==tbl_queued_click_throughs.id).group_by(tbl_queued_click_throughs.i_queued_email_id, tbl_queued_click_through_records.i_queued_customer_id).subquery()
                # sq_clicks = db.session.query(tbl_queued_click_through_records.i_queued_customer_id, tbl_queued_click_through_records.si_count, tbl_queued_click_through_records.dt_last).filter(tbl_queued_click_through_records.i_queued_click_through_id.in_(l_clicks)).subquery()
                q_customers = db.session.query(tbl_queued_customers.id, tbl_queued_customers.v_last_name, tbl_queued_customers.v_first_names, tbl_queued_customers.v_email, tbl_queued_customers.bl_success, tbl_queued_customers.v_reason, tbl_queued_customers.dt_processed).filter(tbl_queued_customers.i_queued_email_id==i_email_id)
                if s_status!="all":
                    q_customers = q_customers.filter(tbl_queued_customers.bl_success==True) if s_status=="success" else q_customers.filter(tbl_queued_customers.bl_success==False)
                # end of checking for status filtering
                q_customers = q_customers.order_by(d_order[s_sort_field][s_sort_dir])
                pagination = q_customers.paginate(page=i_page, per_page=10)
                l_customers = list(map(dict_row, pagination.items))
                # click-through totals, etc.
                for ix, d_customer in enumerate(l_customers):
                    l_customer_clicks = list(map(dict_row, db.session.query(tbl_queued_click_through_records.si_count, tbl_queued_click_through_records.dt_last).filter(tbl_queued_click_through_records.i_queued_click_through_id.in_(l_clicks), tbl_queued_click_through_records.i_queued_customer_id==d_customer["id"]).all()))
                    i_clicks = 0
                    dt_last = datetime(1970, 1, 1, 0, 0)
                    for d in l_customer_clicks:
                        i_clicks += d["si_count"]
                        dt_last = d["dt_last"] if d["dt_last"]>dt_last else dt_last
                    # end of looping through click records
                    l_customers[ix]["i_clicks"] = i_clicks
                    l_customers[ix]["dt_last_click"] = None if i_clicks==0 else dt_last
                    l_customers[ix]["click_summary"] = str(i_clicks) + " - last activity = " + dt_last.strftime("%Y-%m-%d %H:%M:%S") if i_clicks>0 else "0"
                    # prettify dt_processed
                    l_customers[ix]["dt_processed"] = d_customer["dt_processed"].strftime("%Y-%m-%d %H:%M:%S")
                # end of looping through customers
                s_base = "base_bs.html" if Config.BOOTSTRAP else "base.html"
                s_url = url_for("main.queued_email_recipients", i_email_id=i_email_id)#, _external=True)
                return render_template("queued_recipients.html", js=True, base=s_base, url=s_url, page=i_page, paging=pagination, email_id=i_email_id, customers=l_customers, sort_field=s_sort_field, sort_dir=s_sort_dir, sent_status=s_status, export_form=export_form)
            else:
                flash("Invalid E-Mail Results request")
                return redirect(url_for("main.campaign_reports", i_campaign_id=0))
            # end of checking for matching company
        else:
            flash("Invalid E-Mail Results request")
            return redirect(url_for("main.campaign_reports", i_campaign_id=0))
        # end of making sure record could be retrieved
    except Exception as exc:
        return render_template_string(end_user_debugging("queued e-mail recipients listing page"))
    # end of surrounding try-except
# end of queued_email_recipients view function for route /queued_email_recipients/<int:i_email_id>/


@bp.route("/reroute/<s_uuid>/<int:i_customer_id>/", methods=["GET"])
def click_through_reroute(s_uuid:str, i_customer_id:int):
    """receive and process/record click-throughs from e-mail body contents"""
    try:
        s_url = "https://alteram.co.za/"
        # tbl_queued_click_through_records
        s_uuid = str(s_uuid).strip()
        i_customer_id = int(i_customer_id)
        u_uuid = uuid.UUID(s_uuid)
        q_click = db.session.query(tbl_queued_click_throughs).filter(tbl_queued_click_throughs.u_identify==u_uuid)
        if q_click.count()>0:
            o_click = q_click.first()
            i_queued_email_id = o_click.i_queued_email_id
            i_queued_click_through_id = o_click.id
            s_url = o_click.v_destination_url
            # double-check that customer id was linked to email
            if db.session.query(tbl_queued_customers.id).filter(tbl_queued_customers.i_queued_email_id==i_queued_email_id, tbl_queued_customers.id==i_customer_id).count()>0:
                dt_now = datetime.now().astimezone(timezone(timedelta(hours=2)))
                # prior record?
                q_prior = db.session.query(tbl_queued_click_through_records).filter(tbl_queued_click_through_records.i_queued_click_through_id==i_queued_click_through_id, tbl_queued_click_through_records.i_queued_customer_id==i_customer_id)
                if q_prior.count()>0:
                    o_prior = q_prior.first()
                    o_prior.si_count += 1
                    o_prior.dt_last = dt_now
                    db.session.add(o_prior)
                    db.session.commit()
                else:
                    q_action = insert(tbl_queued_click_through_records).values({"i_queued_click_through_id": i_queued_click_through_id, "i_queued_customer_id": i_customer_id, "si_count": 1, "dt_last": dt_now})
                    db.session.execute(q_action)
                    db.session.commit()
                # end of checking if first record
            # end of checking for match against queued customers
        # end of checking for uuid match
        return redirect(s_url)
    except Exception as exc:
        return render_template_string(end_user_debugging("click handling"))
    # end of surrounding try-except
# end of click_through_reroute view function for route /click_through_handle


@bp.route("/export_email_recipients", methods=["POST"])
@login_required
def export_email_recipients():
    """export reporting data of lists of customers e-mails were sent to"""
    try:
        from tempfile import NamedTemporaryFile
        export_form = RecipientsExportForm()
        if export_form.validate_on_submit() and request.form.get("hid_export_email_id", None) is not None:
            i_email_id = request.form.get("hid_export_email_id", type=int)
            o_email = db.session.get(tbl_queued_emails, i_email_id)
            if o_email is not None:
                if o_email.i_company_id==current_user.i_company_id and o_email.bl_done==True:
                    s_status = request.form.get("sel_export_status", "all")
                    s_format = request.form.get("sel_export_format", "csv")
                    s_sort_field = request.args.get("sort", "v_last_name")
                    s_sort_dir = request.args.get("sort_dir", "asc")
                    d_order = {"v_last_name": {"asc": tbl_queued_customers.v_last_name, "desc": tbl_queued_customers.v_last_name.desc()}, "v_first_names": {"asc": tbl_queued_customers.v_first_names, "desc": tbl_queued_customers.v_first_names.desc()}, "v_email": {"asc": tbl_queued_customers.v_email, "desc": tbl_queued_customers.v_email.desc()}, "dt_processed": {"asc": tbl_queued_customers.dt_processed, "desc": tbl_queued_customers.dt_processed.desc()}}
                    l_clicks = list(map((lambda x : x[0]), list(map(tuple, db.session.query(tbl_queued_click_through_records.id).join(tbl_queued_click_throughs, tbl_queued_click_throughs.id==tbl_queued_click_through_records.i_queued_click_through_id, isouter=False).filter(tbl_queued_click_throughs.i_queued_email_id==i_email_id).all()))))
                    # sq_clicks = db.session.query(tbl_queued_click_throughs.i_queued_email_id, tbl_queued_click_through_records.i_queued_customer_id, func.sum(tbl_queued_click_through_records.si_count).label("si_count"), func.max(tbl_queued_click_through_records.dt_last).label("dt_last")).join(tbl_queued_click_through_records, tbl_queued_click_through_records.i_queued_click_through_id==tbl_queued_click_throughs.id).group_by(tbl_queued_click_throughs.i_queued_email_id, tbl_queued_click_through_records.i_queued_customer_id).subquery()
                    # sq_clicks = db.session.query(tbl_queued_click_through_records.i_queued_customer_id, tbl_queued_click_through_records.si_count, tbl_queued_click_through_records.dt_last).filter(tbl_queued_click_through_records.i_queued_click_through_id.in_(l_clicks)).subquery()
                    q_customers = db.session.query(tbl_queued_customers.id, tbl_queued_customers.v_last_name, tbl_queued_customers.v_first_names, tbl_queued_customers.v_email, tbl_queued_customers.bl_success, tbl_queued_customers.v_reason, tbl_queued_customers.dt_processed).filter(tbl_queued_customers.i_queued_email_id==i_email_id)
                    if s_status!="all":
                        q_customers = q_customers.filter(tbl_queued_customers.bl_success==True) if s_status=="success" else q_customers.filter(tbl_queued_customers.bl_success==False)
                    # end of checking for status filtering
                    q_customers = q_customers.order_by(d_order[s_sort_field][s_sort_dir])
                    l_customers = list(map(dict_row, q_customers.all()))
                    # click-through totals, etc.
                    for ix, d_customer in enumerate(l_customers):
                        l_customer_clicks = list(map(dict_row, db.session.query(tbl_queued_click_through_records.si_count, tbl_queued_click_through_records.dt_last).filter(tbl_queued_click_through_records.i_queued_click_through_id.in_(l_clicks), tbl_queued_click_through_records.i_queued_customer_id==d_customer["id"]).all()))
                        i_clicks = 0
                        dt_last = datetime(1970, 1, 1, 0, 0)
                        for d in l_customer_clicks:
                            i_clicks += d["si_count"]
                            dt_last = d["dt_last"] if d["dt_last"]>dt_last else dt_last
                        # end of looping through click records
                        l_customers[ix]["i_clicks"] = i_clicks
                        l_customers[ix]["dt_last_click"] = "" if i_clicks==0 else dt_last.strftime("%Y-%m-%d %H:%M:%S")
                        l_customers[ix]["click_summary"] = str(i_clicks) + " - last activity = " + dt_last.strftime("%Y-%m-%d %H:%M:%S") if i_clicks>0 else "0"
                        # prettify dt_processed
                        l_customers[ix]["dt_processed"] = d_customer["dt_processed"].strftime("%Y-%m-%d %H:%M:%S")
                        del l_customers[ix]["id"]
                    # end of looping through customers
                    output = l_customers
                    if True:# match s_format:
                        if s_format=="xlsx":
                            from openpyxl import Workbook
                            # from openpyxl.writer.excel import save_virtual_workbook
                            from openpyxl.styles import Font
                            l_letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
                            wb = Workbook()
                            ws1 = wb.active
                            ws1.title = "E-Mail Recipients"
                            l_headers = list(l_customers[0].keys())
                            for ix in range(0, len(l_headers)):
                                s_letter = l_letters[ix]
                                ws1[f"{s_letter}1"] = l_headers[ix]
                                ws1[f"{s_letter}1"].font = Font(bold=True)
                            # end of populating headers
                            for ir, d_data in enumerate(l_customers):
                                i_row = ir+2
                                l_values = list(d_data.values())
                                for ix in range(0, len(l_values)):
                                    s_letter = l_letters[ix]
                                    ws1[f"{s_letter}{i_row}"] = l_values[ix]
                                # end of looping through values
                            # end of populating data
                            with NamedTemporaryFile() as tmp:
                                tmp.close() # with statement opened tmp, close it so wb.save can open it
                                wb.save(tmp.name)
                                with open(tmp.name, 'rb') as f:
                                    f.seek(0) # probably not needed anymore
                                    new_file_object = f.read()
                                    response = make_response(new_file_object)
                                    response.mimetype = "application/ms-excel"
                                    response.headers["Content-Disposition"] = f"attachment; filename=email_recipients.xlsx"
                                    return response
                                # end of second with
                            # end of first with
                            # return Response(save_virtual_workbook(wb), headers={'Content-Disposition': 'attachment; filename=email_recipients.xslx', 'Content-type': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'})
                        elif s_format=="pdf":
                            path_wkhtmltopdf = Config.WKHTML
                            config = pdfkit.configuration(wkhtmltopdf=path_wkhtmltopdf)
                            options = {'page-size': 'Letter', 'orientation': 'Landscape', 'margin-top': '0.75in', 'margin-right': '0.75in', 'margin-bottom': '0.75in', 'margin-left': '0.75in', 'encoding': "UTF-8", 'custom-header': [('Accept-Encoding', 'gzip')], 'no-outline': None, 'disable-smart-shrinking': None}
                            s_html = open(os.path.realpath(__file__.replace("routes.py", "z_recipients.html")), "r").read()
                            l_headers = list(l_customers[0].keys())
                            s_table = "<table>\n<thead>\n<tr>\n<th>" + "</th><th>".join(l_headers).upper() + "</th>\n"
                            s_table += "</tr>\n</thead>\n<tbody>\n"
                            for ir, d_data in enumerate(l_customers):
                                l_values = list(map(str, d_data.values()))
                                s_table += "<tr>\n<td>" + "</td><td>".join(l_values) + "</td>\n</tr>\n"
                            # end of looping through l_customers
                            s_table += "</tbody>\n</table>"
                            s_html = s_html.replace("<!-- recipients -->", s_table)
                            with NamedTemporaryFile() as tmp:
                                tmp.close() # with statement opened tmp, close it so wb.save can open it
                                pdfkit.from_string(s_html, tmp.name, configuration=config, options=options)
                                with open(tmp.name, 'rb') as f:
                                    f.seek(0) # probably not needed anymore
                                    new_file_object = f.read()
                                    response = make_response(new_file_object)
                                    response.mimetype = "application/pdf"
                                    response.headers["Content-Disposition"] = f"attachment; filename=email_recipients.pdf"
                                    return response
                                # end of second with
                            # end of first with
                            # response = send_file(pdf, mimetype="application/pdf", as_attachment=True, download_name="email_recipients.pdf")
                            # return response
                        else: # .csv data output
                            l_headers = list(l_customers[0].keys())
                            s_csv_data = ",".join(l_headers).upper() + "\n"
                            for ir, d_data in enumerate(l_customers):
                                l_values = list(map(str, d_data.values()))
                                s_csv_data += ",".join(l_values) + "\n"
                            # end of looping through l_customers
                            response = make_response(s_csv_data)
                            response.headers["Content-Disposition"] = "attachment; filename=exported_recipients.csv"
                            response.mimetype = "text/csv"
                            return response
                        # end of _ match
                    # end of fake if statement # end of match against s_format
                    return make_response(jsonify(l_customers), 200)
                else:
                    return make_response("Invalid E-Mail Results export request", 404)
                # end of checking for matching company
            else:
                return make_response("Invalid E-Mail Results export request", 404)
            # end of making sure record could be retrieved
        # end of checking for export form submission
    except Exception as exc:
        return render_template_string(end_user_debugging("queued e-mail recipients export page"))
    # end of surrounding try-except
# end of export_email_recipients view function for route /export_email_recipients/
