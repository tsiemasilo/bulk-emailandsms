from flask import Blueprint, make_response, redirect, url_for
from flask_login import login_required, current_user
from functools import wraps

bp = Blueprint('main', __name__)

from app.main import routes
