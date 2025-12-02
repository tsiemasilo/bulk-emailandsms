import os
import dotenv

dotenv.load_dotenv()

basedir = os.path.abspath(os.path.dirname(__file__))


class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY', "5!kmnNoL5ABCj8DmM93")
    SQLALCHEMY_DATABASE_URI = os.environ.get("DATABASE_URL") or os.environ.get("DATABASE_URI")\
    or "postgresql://bulkmail_user:bUlK-123@db_bulk_mail:5432/bulk_mail"
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    MAX_CONTENT_LENGTH = 1024 * 1024 * 10
    ADMIN_PWD = os.getenv("ADMIN_PWD", "admin-123")
    BOOTSTRAP=False
    WKHTML=os.path.realpath("/bin/wkhtmltopdf")
