import os
from utils import execute_safe_query
from config import PROJECT_ID

def run_integrity_audit(client):
    """
    Automated Governance Check: Reads pure SQL from the sql/ folder,
    injects the secure Project ID, and executes the audit.
    """
    print(" Starting Governance Audit...")
    
    # 1. Define the path to your pure SQL file
    # (Assuming you run this from the root of your project)
    sql_file_path = os.path.join('scripts', 'sql', '03_etl_integrity_audit.sql')
    
    # 2. Read the SQL file
    try:
        with open(sql_file_path, 'r') as file:
            raw_sql = file.read()
    except FileNotFoundError:
        print(f"❌ ERROR: SQL file not found at {sql_file_path}")
        return

    # 3. Inject the secure Project ID into the placeholder
    executable_sql = raw_sql.replace('<YOUR_PROJECT_ID>', PROJECT_ID)
    
    # 4. Execution
    df_audit = execute_safe_query(client, executable_sql)

    # 5. Audit Logic
    if df_audit is not None:
        print(df_audit)
        
        # Extract values
        raw_count = df_audit.loc[df_audit['source'] == 'Raw_Source', 'total_rows'].values[0]
        view_count = df_audit.loc[df_audit['source'] == 'Hardened_View', 'total_rows'].values[0]
        
        if raw_count == view_count:
            print(f"\n✅ SUCCESS: Audit Passed. {view_count:,} rows processed with 100% Data Integrity.")
        else:
            print(f"\n⚠️ WARNING: Audit Failed. Data loss detected! Missing {raw_count - view_count} rows.")
