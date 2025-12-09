from flask import render_template, request, make_response, jsonify, redirect, url_for, flash, session
from flask.views import MethodView
import bcrypt
from app.auth import bp
from app.extensions import db, write_log
from app.models.authentication import tbl_users
from .forms import LoginForm
from flask_login import login_user, login_required, logout_user

@bp.route('/login', methods=["GET", "POST"])
def login():
    # admin==admin-123
    s_out = ""
    s_user_id = request.cookies.get("cv_db_user", "")
    form = LoginForm()
    if form.validate_on_submit():
        s_user_id, s_password, bl_remember = (form.txt_user_id.data, form.txt_password.data, form.chk_remember.data)
        o_user = db.session.query(tbl_users).filter(tbl_users.v_user_id==s_user_id).first()
        if not o_user:
            flash("invalid user ID")
            return redirect(url_for("auth.login"))
        else:
            if o_user.check_password(s_password):
                login_user(o_user, remember=bl_remember)
                write_log(f"{s_user_id} logged in")
                flash("logged in")
                if o_user.bl_admin:
                    resp = redirect(url_for("main.index"))
                else:
                    resp = redirect(url_for("main.customers", i_company_id=o_user.i_company_id))
                if bl_remember:
                    resp.set_cookie("cv_db_user", s_user_id, max_age=604800) # expires after 7 days
                else:
                    resp.set_cookie("cv_db_user", "", max_age=0) # clear by setting it with max_age of 0
                # end of checking if remember me checkboxchecked
                session["user_id"] = s_user_id
                return resp
            else:
                flash("Invalid password")
            # end of validating password
        # end of checking if valid user ID entered
    # end of checking for form submission
    return render_template('auth/login.html', js=True, form=form, s_user_id=s_user_id)
# end of login view function for route /auth/login


@bp.route("/logout")
@login_required
def logout():
    logout_user()
    flash("logged out")
    return redirect(url_for("auth.login"))
# end of logout view function for route /auth/logout
