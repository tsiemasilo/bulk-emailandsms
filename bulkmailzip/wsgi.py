import sys
import os

base_dir = os.path.dirname(os.path.abspath(__file__))
bulk_mail_dir = os.path.join(base_dir, 'bulk_mail')

sys.path.insert(0, bulk_mail_dir)
os.chdir(bulk_mail_dir)

from app import create_app

app = create_app()

if __name__ == "__main__":
    app.run()
