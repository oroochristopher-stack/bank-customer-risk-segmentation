# 1. --- GLOBAL CONFIGURATION ---
PROJECT_ID = 'bank-risk-project'
DATA_LOCATION = 'US' 

# Creating the messenger client ONCE
client = bigquery.Client(project=PROJECT_ID, location=DATA_LOCATION)

# Setting a hard safety limit at 100MB (Calculated in bytes)
MAX_BYTES = 100 * 1024 * 1024 
# --- END CONFIGURATION ---
