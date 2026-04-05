-- Bank Customer Risk Segmentation Analysis
-- Using CTE (Common Table Expressions) to create a modular data cleaning pipeline.
-- Architecture: Implemented a singleton-pattern Client initialization to ensure regional consistency across all analytical modules.
-- Explicitly setting job location to 'US' to align with the residency of the risk_analysis dataset.
-- if operating with tables from different regions, this innitial client should remain region agnostic i.e not directed to any location since it would operate as a global code location
STEP 3: Risk Tier Segmentation & Capital Exposure Analysis.
# --- CONFIGURATION ---
PROJECT_ID = 'bank-risk-project'
DATA_LOCATION = 'US' # Change once, update everywhere

from google.cloud import bigquery
# Creating the messenger. Here the location is inherited across all analytical modules to ensure regional consistency.
client = bigquery.Client(project=PROJECT_ID, location= DATA_LOCATION)
# --- END CONFIGURATION ---

# Contructing a reference to the dataset
dataset_ref = client.dataset("risk_analysis", project=PROJECT_ID)
# API request to fetch the dataset
dataset = client.get_dataset(dataset_ref)

# Fetch the list of tables from the dataset & prints
tables_pr = list(client.list_tables(dataset))
for t in tables_pr: 
    print(t.table_id)

