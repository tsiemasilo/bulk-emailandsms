import app, sys
from app.extensions import db
import bcrypt
import datetime, jwt
from flask_login import UserMixin
from sqlalchemy import text
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
metadata = Base.metadata


class tbl_users(UserMixin, db.Model):
    __tablename__ = 'tbl_users'
    __table_args__ = {'schema': 'authentication'}

    id = db.Column(db.Integer, primary_key=True, server_default=text("nextval('authentication.tbl_users_id_seq'::regclass)"))
    v_user_id = db.Column(db.String(64), nullable=False, server_default=text("''::character varying"))
    v_password = db.Column(db.String(255), nullable=False, server_default=text("''::character varying"))
    i_company_id = db.Column(db.Integer, nullable=False, server_default=text("0"))
    bl_admin = db.Column(db.Boolean, nullable=False, server_default=text("false"))
    
    def __init__(self, v_user_id, v_password, i_company_id=0, bl_admin=False):
        self.v_user_id = v_user_id
        self.v_password = bcrypt.hashpw(str(v_password).encode("utf-8"), bcrypt.gensalt()).decode()
        self.i_company_id = i_company_id
        self.bl_admin = bl_admin
    # end of __init__ function

    def __repr__(self):
        return f'<User "{self.v_user_id}">'
    # end of __repr__ function
    
    def set_password(self, s_password):
        self.v_password = bcrypt.hashpw(str(s_password).encode("utf-8"), bcrypt.gensalt()).decode()
    # end of set_password function
    
    def check_password(self, s_password):
        return bcrypt.checkpw(str(s_password).encode("utf-8"), str(self.v_password).encode("utf-8"))
    # end of check_password function
    
    def encode_auth_token(self):
        """
        Generates the Auth Token
        :return: string
        """
        try:
            payload = {
                'exp': datetime.datetime.utcnow() + datetime.timedelta(weeks=52, days=0, seconds=0),
                'iat': datetime.datetime.utcnow(),
                'sub': self.id
            }
            return jwt.encode(payload , app.Config.SECRET_KEY, algorithm='HS256')
        except Exception as e:
            return e
        # end of try-except
    # end of internal encode_auth_token function
    
    @staticmethod
    def decode_auth_token(auth_token):
        """
        Decodes the auth token
        :param auth_token:
        :return: integer|string
        """
        try:
            payload = jwt.decode(auth_token, app.Config.SECRET_KEY, algorithms="HS256")
            return payload['sub']
        except jwt.ExpiredSignatureError:
            return 'Signature expired. Please log in again.'
        except jwt.InvalidTokenError:
            return 'Invalid token. Please log in again.'
    # end of internal static decode_auth_token function
    
# end of tbl_users ORM model class
