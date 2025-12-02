#!/usr/bin/python3
from sqlalchemy import Column, Integer, String
from sqlalchemy import update, insert
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import create_engine, MetaData, text
from sqlalchemy.orm import sessionmaker
from models.combined import *

def connect_db(s_uri:str = "") -> tuple:
    # create an engine
    db = create_engine("postgresql://bulkmail_user:bUlK-123@localhost:5432/bulk_mail")
    # create a configured "Session" class
    Session = sessionmaker(bind=db)
    # create a Session
    session = Session()
    return (db, session)
# end of connect_db function


def db_end_it():
    global session, db
    session.close()
    db.dispose()
    print("db session and engine cleared")
    return True
#end of db_end_it


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


__all__=["connect_db", "dict_instance", "dict_row", "tbl_queued_emails", "update", "insert"]
