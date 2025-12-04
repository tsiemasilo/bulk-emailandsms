# Overview

This is a bulk email and SMS campaign management system built with Flask. The application allows organizations to manage email campaigns, customer databases, and send bulk emails through configurable SMTP servers. It includes features for user authentication, company management, customer management, email template creation, campaign scheduling, and email delivery tracking.

The system is designed to run in a containerized environment using Podman, with PostgreSQL as the database backend. It supports multi-company operations where each company can manage their own campaigns, customers, and email templates.

# User Preferences

Preferred communication style: Simple, everyday language.

# System Architecture

## Application Framework
- **Flask Application Factory Pattern**: The application uses Flask's application factory pattern (`create_app()`) to create modular, testable Flask instances
- **Blueprint Architecture**: The application is organized into logical blueprints:
  - `auth` blueprint: Handles user authentication and login
  - `main` blueprint: Core application features (campaigns, customers, companies, etc.)
- **Database ORM**: SQLAlchemy is used for database interactions with declarative models
- **Session Management**: Flask-Login manages user sessions and authentication state

## Database Design
- **PostgreSQL Database**: Uses PostgreSQL 16 with multiple schemas for logical separation:
  - `authentication` schema: User accounts and credentials
  - `companies` schema: Company information, addresses, and metadata
  - `customers` schema: Customer records and groups
  - `emails` schema: Email templates, campaigns, and attachments
  - `queueing` schema: Email queue for asynchronous sending
- **Password Security**: User passwords are hashed using bcrypt before storage
- **Foreign Key Relationships**: Proper relational design with foreign keys between tables

## Authentication & Authorization
- **User Authentication**: Flask-Login provides session-based authentication
- **Password Hashing**: bcrypt library handles secure password hashing and verification
- **Admin Decorator**: Custom `check_admin` decorator restricts certain routes to admin users
- **Company Isolation**: Users are associated with companies to enforce data isolation

## Email Sending Architecture
- **Asynchronous Email Sending**: Uses `aiosmtplib` for asynchronous SMTP communication
- **Batch Processing**: Emails are sent in configurable batches to avoid overwhelming SMTP servers
- **Queue System**: Campaigns are queued in the database before being processed
- **Click-Through Tracking**: URLs in email bodies can be replaced with tracking URLs using UUIDs
- **Attachment Support**: Binary file attachments are stored in the database and attached to emails

## Form Handling
- **WTForms Integration**: Flask-WTF provides form validation and CSRF protection
- **Custom Validators**: Email validation using `email_validator` library
- **File Upload Support**: Flask-WTF file upload handling for attachments and bulk imports

## Containerization Strategy
- **Podman Pod Architecture**: Application runs in a Podman pod with two containers:
  - PostgreSQL database container (`db_bulk_mail`)
  - Flask application container (`app_bulk_mail`)
- **Networking**: Containers communicate through a custom network (`bulk_mail_net`)
- **Port Mapping**: Flask app exposed on port 5002, PostgreSQL on port 5434
- **Volume Persistence**: Database data persists in a named volume (`bulk_mail_db_data`)

# External Dependencies

## Third-Party Services
- **SMTP Servers**: Configurable SMTP servers for email delivery (defaults to Mailcow at dev.blindza.com)
- **Render.com**: Application is deployed on Render.com hosting platform (URL: bulk-mail-app-7rx4.onrender.com)

## Database
- **PostgreSQL 16**: Primary database using Alpine Linux variant
- **Connection Details**: 
  - Default host: `db_bulk_mail` (container hostname)
  - Default credentials: `bulkmail_user` / `bUlK-123`
  - Default database: `bulk_mail`

## Python Libraries
- **Core Framework**: Flask 3.0.3, Werkzeug, Jinja2
- **Database**: SQLAlchemy 2.0.30, psycopg2-binary 2.9.9
- **Authentication**: Flask-Login 0.6.3, Flask-Bcrypt 1.0.1, PyJWT 2.8.0
- **Forms**: Flask-WTF 1.2.1, WTForms 3.1.2, email-validator 2.2.0
- **Email**: aiosmtplib (async), aiohttp 3.9.5
- **HTML Processing**: BeautifulSoup4 4.13.4, pdfkit 1.0.0
- **Excel/Data**: openpyxl 3.1.5 (for bulk customer imports)
- **Server**: Gunicorn 21.2.0 (WSGI server)
- **Environment**: python-dotenv 1.0.1 for configuration management

## Static Assets
- **JavaScript**: jQuery for client-side interactions
- **CSS**: Custom Alteram theme with custom fonts (CaviarDreams)
- **Menu System**: SlimMenu jQuery plugin for responsive navigation

# Recent Changes

## UI/UX Styling Standardization (December 2024)
- Implemented consistent unified table styling across all pages matching the Customers page design pattern
- Added unified table styles to `combined_styles.css` for global use:
  - `.table-unified` - Container with rounded corners and shadow
  - `.table-header-row-unified` - Dark blue header row with action buttons
  - `.table-header-content` - Flexbox layout for title and buttons
  - `.table-header-actions` - White buttons with orange hover effect
  - `.btn-icon` - Icon-only action buttons in table rows
- Updated templates to use unified styling:
  - campaigns.html - Campaigns list with Add Campaign button
  - email_templates.html - Email templates with Add Template button
  - customer_groups.html - Customer groups with Add Group button
  - company_email_addresses.html - Email addresses with Add E-mail button
  - queued.html - Queued emails with filter toggle
  - campaign_reports.html - Campaign reports with filtering
- All row action buttons now use icon-only format with SVG icons
- Added JavaScript cleanup for SlimMenu dropdown menu styling in base.html
- Fixed navbar dropdown menu visibility and button text clipping issues