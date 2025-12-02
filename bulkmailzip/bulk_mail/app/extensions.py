from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()
from datetime import datetime, timezone, timedelta

def dict_row(r_in):
    import sqlalchemy
    d_out = {}
    l_keys = []
    if type(r_in)==sqlalchemy.engine.row.Row:
        l_keys = list(r_in._fields)
    else:
        l_keys = list(r_in.__dict__.keys())
        r_in = r_in.__dict__
    # end of type check on r_in
    for I in range(len(l_keys)):
        sk = l_keys[I]
        d_out[sk] = r_in[I]
    return d_out
#end of dict_row function


def dict_instance(o_item):
    d_in = o_item.__dict__
    d_out = {}
    l_keys = list(d_in.keys())
    for s_key in l_keys:
        if not s_key.startswith("_"):
            d_out[s_key] = d_in[s_key] if d_in[s_key] is not None else ""
        # end of making sure does not start with _
    # end of looping through l_keys
    return d_out
# end of dict_instance function


def extract_exc(s_additional=""):
    import sys, traceback
    d_out = {"i_lineno": 0, "s_filename": "", "s_except": "", "s_tb": "", "s_additional": s_additional}
    exc_type, exc_obj, exc_tb = sys.exc_info()
    if exc_obj is not None and exc_tb is not None:
        s_exception = str(exc_obj)
        o_frame = exc_tb.tb_frame
        s_filename = o_frame.f_code.co_filename
        i_lineno = exc_tb.tb_lineno
        s_tb = traceback.format_exc()
        d_out["i_lineno"] = i_lineno
        d_out["s_filename"] = s_filename
        d_out["s_except"] = s_exception
        d_out["s_tb"] = s_tb
        # write_log
        s_logging = f"line no.: {d_out['i_lineno']}\nfilename: {d_out['s_filename']}\nexcept: {d_out['s_except']}\nadditional: {d_out['s_additional']}"
        write_log(s_logging)
        return d_out
    else:
        return False
    # end of making sure an exception has occurred
# end of extract_exc function


def check_date(s_input):
    """use dateutil.parser.parse to validate and return possible date values"""
    from dateutil import parser
    bl_out, dt_out = (False, datetime.now())
    try:
        dt_out = parser.parse(s_input)
        bl_out = True
    except:
        bl_out, dt_out = (False, datetime.now())
    # end of try-catch to check for possible valid date
    return (bl_out, dt_out)
# end of check_date function


def write_log(s_val):
    """trouble-shooting..."""
    import os, app
    from flask import request
    # if int(os.getenv("FLASK_DEBUG", "0"))!=1: return True
    s_url = request.url.replace(request.url_root, "")
    from datetime import datetime, timezone, timedelta
    s_path = app.__path__[0] + "/logging/bulkmail_log.txt"
    s_path = os.path.realpath(s_path)
    s_dt = datetime.now().astimezone(timezone(timedelta(hours=2))).strftime("%Y-%m-%d %H:%M:%S")
    with open(s_path, "a") as f:
        f.write(f"{s_dt} - {s_url}: {s_val}\n---\n")
        f.close()
    # end of with for file
    return True
# end of write_log function
