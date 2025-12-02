#!/bin/bash
set -e

# Load environment variables from .env file (assuming python-dotenv is used at runtime)
# For the database check, we'll use the hardcoded values or a custom variable.

DB_HOST="db_bulk_mail" # The name of the PostgreSQL container/service
DB_NAME="bulk_mail"
DB_USER="bulkmail_user"

# Wait for the PostgreSQL container to start and accept connections
echo "Waiting for PostgreSQL..."
until PGPASSWORD="bUlK-123" psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up and running. Initializing database schema..."

# Initialize the database schema from the SQL file
PGPASSWORD="bUlK-123" psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -f /usr/local/bulk_mail_data/bulk_mail.sql

>&2 echo "Database schema initialized. Starting Gunicorn."

# populate cron job for mail sending
# exec crontab /usr/local/bin/cronfile.cronjob

# Start Gunicorn
# Adjust the worker count (-w) based on your server's cores (2x cores + 1 is a common starting point)
# change CWD to relevant path
cd /usr/src/app
echo $(pwd)
# Run Gunicorn. The PYTHONPATH in the Containerfile will ensure Flask is found.
exec gunicorn -w 4 -b 0.0.0.0:5000 --reload --access-logfile - --error-logfile - 'wsgi:app'