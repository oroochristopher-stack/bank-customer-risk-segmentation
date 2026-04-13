# 2. --- THE AUTOMATION FUNCTION ---
def execute_safe_query(sql_query_string):
    # manual of the automation
    """Automated Dry Run + Safety Guardrail Execution"""
    
    # Configuring the Safety Cap
    safe_config = bigquery.QueryJobConfig(
        maximum_bytes_billed=MAX_BYTES,
        use_query_cache=False
    )
    
    # Step A: Automated Dry Run (Calculates the cost first)
    dry_config = bigquery.QueryJobConfig(dry_run=True)
    dry_job = client.query(sql_query_string, job_config=dry_config)
    mb_to_scan = dry_job.total_bytes_processed / (1024**2)
    
    print(f"COST AUDIT: This query will scan {mb_to_scan:.2f} MB of data.")
    
    # Step B: Automated Execution (Only runs if under budget)
    try:
        query_job = client.query(sql_query_string, job_config=safe_config)
        print(f" ✅ SUCCESS: Query completed within the {MAX_BYTES/(1024**2):.0f} MB safety limit.")
        return query_job.to_dataframe()
    except Exception as e:
        print(f"⚠️ SAFETY TRIGGERED: Query failed or exceeded your cost limit! Error: {e}")
        return None
# --- END AUTOMATION ---
