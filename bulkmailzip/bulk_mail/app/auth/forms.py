from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, TextAreaField, IntegerField, BooleanField, RadioField
from wtforms.validators import InputRequired, Length

class LoginForm(FlaskForm):
    txt_user_id = StringField(label="User ID", validators=[InputRequired(), Length(min=1, max=128)])
    txt_password = PasswordField(label="Password", validators=[InputRequired(), Length(min=1, max=255)])
    chk_remember = BooleanField(label="Remember me")
# end of LoginForm class
