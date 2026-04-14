from google.cloud import bigquery
# In the notebook, this is one cell; in GitHub, we keep it here for reusability.

def execute_safe_query(client, sql_query_string, max_bytes):
    """
    Automated Dry Run + Safety Guardrail Execution.
    Mimics Bank Production environment where cost-auditing is mandatory.
    """
    safe_config = bigquery.QueryJobConfig(
        maximum_bytes_billed=max_bytes,
        use_query_cache=False # Development mode: ensures fresh data fetch
    )
    
    # Step A: Dry Run (Calculates the cost first)
    dry_config = bigquery.QueryJobConfig(dry_run=True)
    dry_job = client.query(sql_query_string, job_config=dry_config)
    mb_to_scan = dry_job.total_bytes_processed / (1024**2)
    
    print(f"COST AUDIT: Query will scan {mb_to_scan:.2f} MB.")
    
    # Step B: Guardrail Execution
    try:
        return client.query(sql_query_string, job_config=safe_config).to_dataframe()
    except Exception as e:
        print(f"⚠️ SAFETY TRIGGERED: {e}")
        return None
