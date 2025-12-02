from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, TextAreaField, IntegerField, BooleanField, RadioField, HiddenField, SelectField, TimeField, \
    EmailField, DateField, DateTimeLocalField
from flask_wtf.file import FileField, FileRequired, FileAllowed
from wtforms.validators import InputRequired, Length, NumberRange, Email
from datetime import time, date, datetime


class CompanyForm(FlaskForm):
    hid_company_id = HiddenField(id="hid_company_id", default=0)
    sel_id_type = SelectField(id="sel_id_type", label="Registration Type", default=0, choices = [(0, "---not registered---")])
    txt_registration_number = StringField(id="txt_registration_number", label="Registration Number", validators=[Length(max=128)])
    txt_organisation_name = StringField(id="txt_organisation_name", label="Organisation Name", validators=[InputRequired(), Length(max=128)])
    txt_trading_name = StringField(id="txt_trading_name", label="Trading Name", validators=[Length(max=128)])
    d_registration_date = DateField(id="d_registration_date", label="Registration Date", default=None, format="%Y-%m-%d")
    txt_contact_person = StringField(id="txt_contact_person", label="Contact Person", validators=[InputRequired(), Length(max=128)])
    txt_contact_person_alternate = StringField(id="txt_contact_person_alternate", label="Contact Person Alternate", validators=[Length(max=128)])
    txt_email = EmailField(id="txt_email", label="Email", validators=[InputRequired(), Length(max=128)])
    txt_email_alternate = EmailField(id="txt_email_alternate", label="Email Alternate", validators=[Length(max=128)])
    txt_mobile_number = StringField(id="txt_mobile_number", label="Mobile Number", validators=[InputRequired(), Length(max=32)])
    txt_mobile_number_alternate = StringField(id="txt_mobile_number_alternate", label="Mobile Number Alternate", validators=[Length(max=32)])
    txt_landline_number = StringField(id="txt_landline_number", label="Landline Number", validators=[InputRequired(), Length(max=32)])
    txt_landline_number_alternate = StringField(id="txt_landline_number_alternate", label="Landline Number Alternate", validators=[Length(max=32)])
    txt_additional_address = StringField(id="txt_additional_address", label="Additional Address", validators=[Length(max=128)])
    txt_building_number_name = StringField(id="txt_building_number_name", label="Building Number|Name", validators=[InputRequired(), Length(max=128)])
    txt_street_name = StringField(id="txt_street_name", label="Street Name", validators=[InputRequired(), Length(max=128)])
    txt_suburb = StringField(id="txt_suburb", label="Suburb", validators=[InputRequired(), Length(max=128)])
    txt_city = StringField(id="txt_city", label="City", validators=[InputRequired(), Length(max=128)])
    txt_province = StringField(id="txt_province", label="Province", validators=[InputRequired(), Length(max=128)])
    txt_municipality = StringField(id="txt_municipality", label="Municipality", validators=[InputRequired(), Length(max=128)])
    sel_country = SelectField(id="sel_country", label="Country", choices=[(0, "---select country---")], default=0)
    txt_code = StringField(id="txt_code", label="Code", validators=[InputRequired(), Length(max=16)])
# end of CompanyForm class

class RemoveCompanyForm(FlaskForm):
    hid_remove_company_id = HiddenField(id="hid_remove_company_id", default=0)
# end of RemoveCompanyForm class


class CustomerForm(FlaskForm):
    hid_customer_id = HiddenField(id="hid_customer_id", default=0)
    sel_id_type = SelectField(id="sel_id_type", label="I.D. Document Type", default=0, choices = [(0, "---n/a---")])
    txt_id_number = StringField(id="txt_id_number", label="I.D. Number", validators=[Length(max=128)])
    txt_title = StringField(id="txt_title", label="Title", validators=[InputRequired(), Length(max=32)])
    txt_first_names = StringField(id="txt_first_names", label="First Name(s)", validators=[InputRequired(), Length(max=128)])
    txt_last_name = StringField(id="txt_last_name", label="Last Name", validators=[InputRequired(), Length(max=128)])
    sel_gender = SelectField(id="sel_gender", label="Gender", choices=[("", "---not selected---"), ("F", "Female"), ("M", "Male")], default="")
    sel_nationality = SelectField(id="sel_nationality", label="Nationality", choices=[(0, "---select nationality---")], default=0)
    txt_mobile_number = StringField(id="txt_mobile_number", label="Mobile Number", validators=[Length(max=64)])
    txt_mobile_number_alternate = StringField(id="txt_mobile_number_alternate", label="Mobile Number alternate", validators=[Length(max=64)])
    txt_landline_number = StringField(id="txt_landline_number", label="Landline Number", validators=[Length(max=64)])
    txt_landline_number_alternate = StringField(id="txt_landline_number_alternate", label="Landline Number alternate", validators=[Length(max=64)])
    txt_email = EmailField(id="txt_email", label="Email", validators=[InputRequired(), Length(max=128)])
    txt_email_alternate = EmailField(id="txt_email_alternate", label="Email Alternate", validators=[Length(max=128)])
    txt_address = StringField(id="txt_address", label="Address", validators=[Length(max=64)])
    txt_street_name = StringField(id="txt_street_name", label="Street Name", validators=[Length(max=64)])
    txt_suburb = StringField(id="txt_suburb", label="Suburb", validators=[InputRequired(), Length(max=64)])
    txt_city = StringField(id="txt_city", label="City", validators=[InputRequired(), Length(max=64)])
    txt_province = StringField(id="txt_province", label="Province", validators=[InputRequired(), Length(max=64)])
    txt_code = StringField(id="txt_code", label="Code", validators=[Length(max=32)])
    txt_postal_address = TextAreaField(id="txt_postal_address", label="Postal Address", validators=[Length(max=128)], render_kw={"wrap": "hard", "rows": "3", "cols": "50"})
# end of CustomerForm class


class RemoveCustomerForm(FlaskForm):
    hid_remove_customer_id = HiddenField(id="hid_remove_customer_id", default=0)
# end of RemoveCustomerForm class


class CustomerIDTypeForm(FlaskForm):
    hid_customer_id_type_id = HiddenField(id="hid_customer_id_type_id", default=0)
    txt_customer_id_type_description = StringField(id="txt_customer_id_type_description", label="Description", validators=[InputRequired(), Length(max=64)])
# end of CustomerIDTypeForm class


class CompanyIDTypeForm(FlaskForm):
    hid_company_id_type_id = HiddenField(id="hid_company_id_type_id", default=0)
    txt_company_id_type_description = StringField(id="txt_company_id_type_description", label="Description", validators=[InputRequired(), Length(max=64)])
# end of CompanyIDTypeForm class


class RemoveCompanyIDTypeForm(FlaskForm):
    hid_remove_company_type_id = HiddenField(id="hid_remove_company_type_id", default=0)
# end of RemoveCompanyIDTypeForm class


class RemoveCustomerIDTypeForm(FlaskForm):
    hid_remove_customer_type_id = HiddenField(id="hid_remove_customer_type_id", default=0)
# end of RemoveCustomerIDTypeForm class


class CompanyUserForm(FlaskForm):
    hid_user_id = HiddenField(id="hid_user_id", default=0)
    txt_user_id = StringField(id="txt_user_id", label="User ID (e-mail address?)", validators=[InputRequired(), Length(max=64)])
    sel_company = SelectField(id="sel_company", label="Company", choices=[])
    txt_password = PasswordField(id="txt_password", label="New Password", default="")
    txt_password_confirm = PasswordField(id="txt_password_confirm", label="Confirm New Password", default="")
# end of CompanyUserForm class


class RemoveCompanyUserForm(FlaskForm):
    hid_remove_user_id = HiddenField(id="hid_remove_user_id", default=0)
# end of RemoveCompanyUserForm class


class CompanyCampaignForm(FlaskForm):
    hid_campaign_id = HiddenField(id="hid_campaign_id", default=0)
    txt_reference_number = StringField(id="txt_reference_number", label="Campaign Reference Number", validators=[InputRequired(), Length(min=5, max=64)])
    txt_campaign_title = StringField(id="txt_campaign_title", label="Campaign Title", validators=[InputRequired(), Length(min=5, max=128)])
    txt_description = TextAreaField(id="txt_description", label="Description", validators=[InputRequired(), Length(max=512)], render_kw={"wrap": "hard"})
    sel_email_id = SelectField(id="sel_email_id", label="E-mail", choices=[(0, "---select---")], default=0)
    d_target = DateField(id="d_target", label="Target Date", validators=[InputRequired()], default=datetime.now().date())
    t_target = TimeField(id="t_target", label="Target Time", validators=[InputRequired()], default=datetime.now().time())
    sel_company_email_address_id = SelectField(id="sel_company_email_address_id", label="Sending E-mail and Server", choices=[(0, "---select---")], validators=[NumberRange(min=1)], default=0, coerce=int)
    txt_email_from = EmailField(id="txt_email_from", label="E-mail From", validators=[InputRequired()], default="")
    txt_email_reply_to = EmailField(id="txt_email_reply_to", label="E-mail Reply-To", default="")
# end of CompanyCampaignForm class


class RemoveCompanyCampaignForm(FlaskForm):
    hid_remove_campaign_id = HiddenField(id="hid_remove_campaign_id", default=0)
# end of RemoveCompanyCampaignForm class


class CustomerGroupForm(FlaskForm):
    hid_group_id = HiddenField(id="hid_group_id", default=0)
    txt_group_name = StringField(id="txt_group_name", label="Group Name", validators=[InputRequired(), Length(max=64)])
    txt_group_description = TextAreaField(id="txt_group_description", label="Description", validators=[Length(max=128)], render_kw={"wrap": "hard"})
# end of CustomerGroupForm class


class RemoveCustomerGroupForm(FlaskForm):
    hid_remove_group_id = HiddenField(id="hid_remove_group_id", default=0)
# end of RemoveCustomerGroupForm class


class CustomerBulkUploadForm(FlaskForm):
    sel_group_id = SelectField(id="sel_group_id", label="Associated Group", choices=[(0, "---no group associated---")], default=0)
    fil_upload = FileField(id="fil_upload", label="Comma-separated file (.csv)", validators=[FileRequired(), FileAllowed(["csv"])], render_kw={"accept": ".csv"})
# end of CustomerBulkUploadForm class


class CustomerGroupMembersChangeForm(FlaskForm):
    hid_membership_change = HiddenField(id="hid_membership_change", default="submitted")
    hid_membership_add = HiddenField(id="hid_membership_add", default="")
    hid_membership_remove = HiddenField(id="hid_membership_remove", default="")
# end of CustomerGroupMembersChangeForm class


class EmailTemplateForm(FlaskForm):
    hid_email_id = HiddenField(id="hid_email_id", default=0)
    txt_title = StringField(id="txt_title", label="E-Mail Template Title", validators=[InputRequired(), Length(max=128)])
    txt_subject = StringField(id="txt_subject", label="Subject", validators=[InputRequired(), Length(max=128)])
    txt_body = TextAreaField(id="txt_body", label="Body", validators=[InputRequired()], render_kw={"wrap": "hard", "rows": "10", "cols": "50"})
# end of EmailTemplateForm class


class RemoveEmailTemplateForm(FlaskForm):
    hid_remove_email_id = HiddenField(id="hid_remove_email_id", default=0)
# end of RemoveEmailTemplateForm class


class CampaignAttachmentUploadForm(FlaskForm):
    fil_upload = FileField(id="fil_upload", label="E-mail Attachment (.jpg, .png, .pdf, .doc, .docx)", validators=[FileRequired(), FileAllowed(["jpg", "png", "pdf", "doc", "docx"])], render_kw={"accept": ".jpg,.png,.pdf,.doc,.docx"})
# end of CampaignAttachmentUploadForm class


class RemoveCampaignAttachmentForm(FlaskForm):
    hid_remove_attachment_id = HiddenField(id="hid_remove_attachment_id", default=0)
# end of RemoveCampaignAttachmentForm class


class QueueCampaignSendingForm(FlaskForm):
    hid_campaign_queueing_id = HiddenField(id="hid_campaign_queueing_id", default=0)
# end of QueueCampaignSendingForm class


class CompanyEmailAddressForm(FlaskForm):
    hid_email_id = HiddenField(id="hid_email_id", default=0)
    txt_email_address = EmailField(id="txt_email_address", label="Email Address", validators=[InputRequired(), Length(max=128), Email()])
    txt_reply_to_address = EmailField(id="txt_reply_to_address", label="Reply-to Email Address", validators=[Length(max=128)])
    txt_user_id = StringField(id="txt_user_id", label="User ID", validators=[InputRequired(), Length(max=128)])
    txt_password = StringField(id="txt_password", label="Password", validators=[InputRequired(), Length(max=128)])
    txt_server_name = StringField(id="txt_server_name", label="Server|Host name", validators=[InputRequired(), Length(max=128)])
    txt_port = IntegerField(id="txt_port", label="Port Number", validators=[InputRequired()], default=587)
    chk_secure = BooleanField(id="chk_secure", label="Secure Transmission", default=True)
    chk_starttls = BooleanField(id="chk_starttls", label="STARTTLS Transmission", default=True)
# end of CompanyEmailAddressForm class


class RemoveCompanyEmailAddressForm(FlaskForm):
    hid_remove_email_id = HiddenField(id="hid_remove_email_id", default=0)
# end of RemoveCompanyEmailAddressForm class


class CampaignReportsFilterForm(FlaskForm):
    hid_page = HiddenField(id="hid_filter_page", name="hid_page", default=1)
    txt_campaign_id = StringField(id="txt_filter_campaign_id", label="Campaign ID", default="")
    d_start = DateField(id="d_filter_start", label="Target Start Date", default=None, format="%Y-%m-%d")
    d_end = DateField(id="d_filter_end", label="Target End Date", default=None, format="%Y-%m-%d")
# end of CampaignReportsFilterForm class


class RecipientsExportForm(FlaskForm):
    hid_export_email_id = HiddenField(id="hid_export_email_id", name="hid_export_email_id", default=0)
    sel_export_format = SelectField(id="sel_export_format", label="Select Export Format", name="sel_export_format", choices=[("csv", ".CSV",), ("pdf", ".PDF"), ("xlsx", ".XLSX")], default="csv")
    sel_export_status = SelectField(id="sel_export_status", label="Select Delivery Status", name="sel_export_status", choices=[("all", "All"), ("success", "Success"), ("failure", "Failure")], default="all")
# end of RecipientsExportForm class
