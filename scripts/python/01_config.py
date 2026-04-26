import os

# --- GLOBAL CONFIGURATION ---
# SECURE CONFIGURATION: Uses environment variable, defaults to placeholder for GitHub
PROJECT_ID = os.getenv('GCP_PROJECT_ID', '<YOUR_PROJECT_ID>') 
DATA_LOCATION = 'US' 

# Operational Risk: Query scan limit (50MB) to prevent billing spikes
MAX_BYTES = 50 * 1024 * 1024
