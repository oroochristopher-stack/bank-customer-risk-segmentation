from google.cloud import bigquery

def verify_table_exists(client, project_id, dataset_id, table_id):
    """
    Production Check: Verifies the raw table exists before the pipeline starts.
    Replaces human visual check with an automated boolean check.
    """
    full_table_ref = f"{project_id}.{dataset_id}.{table_id}"
    
    try:
        client.get_table(full_table_ref)
        print(f"✅ VERIFIED: Asset '{full_table_ref}' is online and ready.")
        return True
    except Exception as e:
        print(f"❌ CRITICAL FAILURE: Asset '{full_table_ref}' not found. Pipeline Halted.")
        print(f"Error details: {e}")
        return False
