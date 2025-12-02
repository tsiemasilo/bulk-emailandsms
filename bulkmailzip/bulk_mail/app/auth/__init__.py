from flask import Blueprint, flash, redirect, url_for, request

bp = Blueprint('auth', __name__)


from app.auth import routes
from flask_login import current_user
from functools import wraps

def check_admin(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if current_user.bl_admin!=True:
            flash("you must be logged in as an administrative user")
            return redirect(url_for('auth.login', next=request.url))
        else:
            return f(*args, **kwargs)
        # end of checking if super user
    # end of decorated function
    return decorated_function
# end of check_admin decorator
