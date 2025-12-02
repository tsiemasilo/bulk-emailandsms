from bs4 import BeautifulSoup as bs
import uuid

def replace_click_throughs(s_html:str = "", s_base_url:str = "https://dev.blindza.com/bulk_mail/reroute/") -> dict:
    """remove title attribute and replace href attribute value with flask route to handle redirection later on, including UUID specific to this queued email - will have customer ID appended during sending"""
    d_out = {"html": s_html, "uuids": {}}
    if s_html.count("||##redirect##||")>0:
        bsh = bs(s_html, "html.parser")
        l_hrefs = bsh.find_all("a", title="||##redirect##||")
        for ix, a in enumerate(l_hrefs):
               del a["title"]
               s_uuid = str(uuid.uuid4())
               d_out["uuids"][s_uuid] = a["href"]
               a["href"] = s_base_url + s_uuid
        # end of looping through all href items
        d_out["html"] = str(bsh)
    # end of checking if contains title|placeholder marking string
    return d_out
# end of replace_click_throughs function

if __name__=="__main__":
    s_html = open("z_html.html", "r").read()
    print(replace_click_throughs(s_html))
# end of __name__ check