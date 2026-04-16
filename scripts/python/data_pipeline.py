# scripts/python/data_pipeline.py
from utils import execute_safe_query
from config import PROJECT_ID

def run_integrity_audit(client):
    """
    Automated Governance Check: Reconciles Raw vs Hardened counts 
    and validates Data Integrity (Stress Test).
    """
    print("🚀 Starting Governance Audit...")
    
    # Audit Query
    audit_sql = f"""
    SELECT 'Raw_Source' AS source, COUNT(*) AS total_rows FROM `{PROJECT_ID}.risk_analysis.loan_data`
    UNION ALL
    SELECT 'Hardened_View' AS source, COUNT(*) AS total_rows FROM `{PROJECT_ID}.risk_analysis.v_hardened_loans`
    """
    
    df = client.query(audit_sql).to_dataframe()
    # Logic to compare rows... (add your print statements here)
    print(df)
