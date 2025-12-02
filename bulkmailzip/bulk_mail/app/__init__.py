from flask import Flask, make_response, request, jsonify, render_template, flash
from config import Config
from app.extensions import db, extract_exc
from app.models.authentication import tbl_users
from flask_login import LoginManager
from datetime import datetime, timezone, timedelta

# flask app factory function/instantiator
def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)
    
    @app.context_processor
    def inject_url_values():
        return dict(static_prefix="bulk_mail/")
    # end of inject_url_values
    # Initialize Flask extensions here
    db.init_app(app)
    # Register blueprints here
    from app.main import bp as main_bp
    app.register_blueprint(main_bp, url_prefix="/bulk_mail")
    from app.auth import bp as auth_bp
    app.register_blueprint(auth_bp, url_prefix="/bulk_mail/auth")
    
    @app.route("/bulk_mail/test/")
    def test_page():
        return '<h1>Testing the Flask Application Factory Pattern</h1>'
    # end of test_page view function for route /bulk_mail/test/
    
    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'
    login_manager.init_app(app)

    @login_manager.user_loader
    def load_user(user_id):
        # since the user_id is just the primary key of our user table, use it in the query for the user
        return db.session.get(tbl_users, int(user_id))
    # end of load_user function
    
    @app.errorhandler(404)
    def page_not_found(e):
        s_path = str(request.path)
        return render_template("errors/404.html", js=True, s_alert="", path=s_path), 404
    # end of page_not_found function
    
    
    @app.errorhandler(Exception)
    def page_exception(e):
        d_exc = extract_exc()
        # ['i_lineno', 's_filename', 's_except', 's_tb', 's_additional']
        l_tb = str(d_exc["s_tb"]).strip().split("\n")
        l_tb.reverse()
        if len(l_tb)>2: l_tb = l_tb[:3]
        s_tb = " | ".join(l_tb)
        s_path = str(request.path)
        s_dt = datetime.now().astimezone(timezone(timedelta(hours=2))).strftime("%Y-%m-%d %H:%M:%S")
        s_logging = f"<ul><li>date-time: {s_dt}</li>\n<li>filename: {d_exc['s_filename']}</li>\n<li>line no.: {d_exc['i_lineno']}</li>\n<li>except: {d_exc['s_except']}</li>\n<li>additional: {d_exc['s_additional']}</li>\n</ul>" if isinstance(d_exc, dict) else f"date-time: {s_dt}\n{s_path}\n" + str(d_exc["s_except"])
        d_out = {"url": request.url.replace(request.url_root, ""), "file": d_exc["s_filename"], "line no.": d_exc["i_lineno"], "exception": d_exc["s_except"], "traceback": s_tb}
        d_exc["traceback"] = d_exc["s_tb"].split("|")
        return render_template("errors/500.html", js=True, s_alert="", exc=d_exc, html_content=s_logging), 500
    # end of page_exception function

    @app.template_filter("date_time_format")
    def my_dt_format(dt_date_time):
        return dt_date_time.strftime("%Y-%m-%d %H:%M")
    # end of my_dt_format filter function
    
    @app.template_filter("date_format")
    def my_d_format(dt_date_time):
        return dt_date_time.strftime("%Y-%m-%d")
    # end of my_d_format filter function

    return app
# end of create_app function
