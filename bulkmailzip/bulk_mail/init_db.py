import os
from sqlalchemy import text

def init_database(app, db):
    with app.app_context():
        try:
            result = db.session.execute(text("SELECT 1 FROM authentication.tbl_users LIMIT 1"))
            db.session.commit()
            print("Database already initialized - tables exist.")
            return True
        except Exception as e:
            db.session.rollback()
            print(f"Tables don't exist, initializing database...")
        
        try:
            db.session.execute(text("CREATE SCHEMA IF NOT EXISTS authentication"))
            db.session.commit()
            db.session.execute(text("CREATE SCHEMA IF NOT EXISTS companies"))
            db.session.commit()
            db.session.execute(text("CREATE SCHEMA IF NOT EXISTS customers"))
            db.session.commit()
            db.session.execute(text("CREATE SCHEMA IF NOT EXISTS emails"))
            db.session.commit()
            db.session.execute(text("CREATE SCHEMA IF NOT EXISTS queueing"))
            db.session.commit()
            print("Schemas created successfully")
        except Exception as e:
            db.session.rollback()
            print(f"Error creating schemas: {e}")
            return False
        
        sql_file_path = os.path.join(os.path.dirname(__file__), 'bulk_mail.sql')
        
        if not os.path.exists(sql_file_path):
            print(f"SQL file not found at: {sql_file_path}")
            try:
                db.session.execute(text("""
                    CREATE TABLE IF NOT EXISTS authentication.tbl_users (
                        id SERIAL PRIMARY KEY,
                        v_user_id VARCHAR(64) DEFAULT '' NOT NULL,
                        v_password VARCHAR(255) DEFAULT '' NOT NULL,
                        i_company_id INTEGER DEFAULT 0 NOT NULL,
                        bl_admin BOOLEAN DEFAULT false NOT NULL
                    )
                """))
                db.session.commit()
                print("Created basic users table")
            except Exception as e:
                db.session.rollback()
                print(f"Error creating users table: {e}")
            return False
        
        try:
            with open(sql_file_path, 'r') as f:
                sql_content = f.read()
            
            create_statements = []
            current_statement = []
            
            for line in sql_content.split('\n'):
                stripped = line.strip()
                
                if stripped.startswith('--') or stripped == '':
                    continue
                
                if any(skip in stripped.upper() for skip in ['ALTER TABLE', 'DROP', 'OWNER TO', 'GRANT', 'REVOKE', 'COMMENT ON', 'pg_catalog']):
                    continue
                
                current_statement.append(line)
                
                if stripped.endswith(';'):
                    full_stmt = '\n'.join(current_statement)
                    if full_stmt.strip().upper().startswith(('CREATE TABLE', 'CREATE SEQUENCE')):
                        create_statements.append(full_stmt)
                    elif full_stmt.strip().upper().startswith('INSERT'):
                        create_statements.append(full_stmt)
                    current_statement = []
            
            success_count = 0
            error_count = 0
            for stmt in create_statements:
                try:
                    if stmt.strip():
                        db.session.execute(text(stmt))
                        db.session.commit()
                        success_count += 1
                except Exception as e:
                    db.session.rollback()
                    error_count += 1
                    if 'already exists' not in str(e).lower():
                        pass
            
            print(f"Database initialization complete. Success: {success_count}, Errors: {error_count}")
            return True
            
        except Exception as e:
            db.session.rollback()
            print(f"Error initializing database: {e}")
            try:
                db.session.execute(text("""
                    CREATE TABLE IF NOT EXISTS authentication.tbl_users (
                        id SERIAL PRIMARY KEY,
                        v_user_id VARCHAR(64) DEFAULT '' NOT NULL,
                        v_password VARCHAR(255) DEFAULT '' NOT NULL,
                        i_company_id INTEGER DEFAULT 0 NOT NULL,
                        bl_admin BOOLEAN DEFAULT false NOT NULL
                    )
                """))
                db.session.commit()
                print("Created fallback users table")
            except Exception as e2:
                db.session.rollback()
                print(f"Fallback also failed: {e2}")
            return False
