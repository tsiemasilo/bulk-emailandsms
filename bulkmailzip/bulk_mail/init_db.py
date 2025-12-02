import os
from sqlalchemy import text

def init_database(app, db):
    with app.app_context():
        try:
            result = db.session.execute(text("SELECT 1 FROM authentication.tbl_users LIMIT 1"))
            print("Database already initialized.")
            return True
        except Exception as e:
            print(f"Database not initialized, setting up: {e}")
        
        sql_file_path = os.path.join(os.path.dirname(__file__), 'bulk_mail.sql')
        
        if not os.path.exists(sql_file_path):
            print(f"SQL file not found at: {sql_file_path}")
            return False
        
        try:
            with open(sql_file_path, 'r') as f:
                sql_content = f.read()
            
            statements = []
            current_statement = []
            in_function = False
            
            for line in sql_content.split('\n'):
                stripped = line.strip()
                
                if stripped.startswith('--') or stripped == '':
                    continue
                
                if 'CREATE FUNCTION' in line.upper() or 'CREATE OR REPLACE FUNCTION' in line.upper():
                    in_function = True
                
                current_statement.append(line)
                
                if in_function:
                    if stripped.endswith('$$;') or (stripped == '$$' and current_statement):
                        statements.append('\n'.join(current_statement))
                        current_statement = []
                        in_function = False
                elif stripped.endswith(';'):
                    statements.append('\n'.join(current_statement))
                    current_statement = []
            
            skip_patterns = [
                'ALTER TABLE', 'DROP', 'OWNER TO', 'GRANT', 'REVOKE',
                'pg_catalog', 'COMMENT ON'
            ]
            
            create_schema_statements = []
            create_extension_statements = []
            create_sequence_statements = []
            create_table_statements = []
            alter_sequence_statements = []
            insert_statements = []
            other_statements = []
            
            for stmt in statements:
                stmt_upper = stmt.upper().strip()
                
                should_skip = False
                for pattern in skip_patterns:
                    if pattern in stmt_upper:
                        should_skip = True
                        break
                
                if should_skip:
                    continue
                
                if stmt_upper.startswith('CREATE SCHEMA'):
                    stmt = stmt.replace('IF NOT EXISTS', '').strip()
                    if 'IF NOT EXISTS' not in stmt:
                        stmt = stmt.replace('CREATE SCHEMA', 'CREATE SCHEMA IF NOT EXISTS')
                    create_schema_statements.append(stmt)
                elif stmt_upper.startswith('CREATE EXTENSION'):
                    create_extension_statements.append(stmt)
                elif stmt_upper.startswith('CREATE SEQUENCE'):
                    create_sequence_statements.append(stmt)
                elif stmt_upper.startswith('CREATE TABLE'):
                    create_table_statements.append(stmt)
                elif 'ALTER SEQUENCE' in stmt_upper and 'OWNED BY' in stmt_upper:
                    alter_sequence_statements.append(stmt)
                elif stmt_upper.startswith('INSERT'):
                    insert_statements.append(stmt)
                elif stmt_upper.startswith('SELECT') or stmt_upper.startswith('SET'):
                    pass
                else:
                    other_statements.append(stmt)
            
            all_ordered = (
                create_schema_statements +
                create_extension_statements +
                create_sequence_statements +
                create_table_statements +
                alter_sequence_statements +
                insert_statements
            )
            
            success_count = 0
            error_count = 0
            
            for stmt in all_ordered:
                try:
                    if stmt.strip():
                        db.session.execute(text(stmt))
                        db.session.commit()
                        success_count += 1
                except Exception as e:
                    db.session.rollback()
                    error_msg = str(e).lower()
                    if 'already exists' not in error_msg and 'duplicate' not in error_msg:
                        error_count += 1
                        print(f"SQL Error: {str(e)[:100]}")
            
            print(f"Database initialization complete. Success: {success_count}, Errors: {error_count}")
            return True
            
        except Exception as e:
            print(f"Error initializing database: {e}")
            return False
