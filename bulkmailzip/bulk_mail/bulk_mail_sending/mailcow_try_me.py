# https://pypi.org/project/python-mailcow/
# https://mailcow.docs.apiary.io/#reference/domains/get-domains
from mailcow import *
from random import randint
moo = MailCow()


def gen_password(i_len=10):
    s_lower = "abcdefghijklmnopqrstuvwxyz"
    s_upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    s_other = "-_!@#$%^&*()"
    s_out = ""
    i_len=int(i_len)-1
    if i_len<4: raise Exception("password must be at least 5 characters in length")
    for I in range(i_len+1):
        i_which = randint(1, 3)
        if i_which==1:
            s_out = s_out + s_lower[randint(0, len(s_lower)-1)]
        elif i_which==2:
            s_out = s_out + s_upper[randint(0, len(s_upper)-1)]
        else:
            s_out = s_out + s_other[randint(0, len(s_other)-1)]
        # end of deciding which type of character to add
    # end of looping to add random characters
    return s_out
# end of gen_password function


def add_mailbox(s_local_part, **kwargs):
    """add mailbox to mailcow server"""
    global moo
    bl_out, s_out = (False, "")
    try:
        if str(s_local_part).strip()=="": raise Exception("invalid local part for mailbox")
        s_local_part = str(s_local_part).strip()
        bl_active = kwargs.get("active", True)
        s_domain = kwargs.get("domain", "blindza.xyz")
        s_name = kwargs.get("name", f"{s_local_part}@{s_domain}")
        s_password = kwargs.get("password", gen_password(10))
        i_quota = kwargs.get("quota", 0)
        bl_force_pw_update = kwargs.get("force_pw_update", False)
        bl_tls_enforce_in = kwargs.get("tls_enforce_in", False)
        bl_tls_enforce_out = kwargs.get("tls_enforce_out", False)
        d_attributes = {"local_part": s_local_part, "active": bl_active, "domain": s_domain, "name": s_name, "password": s_password, "password2": s_password, "quota": i_quota, "force_pw_update": bl_force_pw_update, "tls_enforce_in": bl_tls_enforce_in, "tls_enforce_out": bl_tls_enforce_out}
        result = moo.addRequest("mailbox", d_attributes)
        return result
    except Exception as exc:
        s_out = str(exc)
        bl_out = False
    # end of try-except
    return (bl_out, s_out)
# end of add_mailbox function


def delete_mailbox(s_mailbox:str = ""):
    """will remove mailbox completely - be careful!"""
    global moo
    try:
        moo.deleteRequest("mailbox", [s_mailbox])
    except Exception as exc:
        return str(exc)
    # end of try-except
# end of delete_mailbox function

def get_mailbox(s_mailbox:str = ""):
    """retrieve mailbox details"""
    global moo
    try:
        return moo.getRequest(f"mailbox/{s_mailbox}")
    except Exception as exc:
        return str(exc)
    # end of try-except
# end of get_mailbox function

def change_password(s_mailbox, s_password):
    """reset mailbox password"""
    global moo
    try:
        return moo.editRequest("mailbox", [s_mailbox], {"password": s_password, "password2": s_password})
    except Exception as exc:
        return str(exc)
    # end of try-except
# end of change_password function

# moo.editRequest("mailbox", ["rogerwilco@blindza.xyz"], {"password": "Roger-123", "password2": "Roger-123"})
