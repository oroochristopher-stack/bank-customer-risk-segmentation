-- Bank Customer Risk Segmentation Analysis
-- Architecture: Implemented a singleton-pattern Client initialization to ensure regional consistency across all analytical modules.
-- Explicitly setting job location to 'US' to align with the residency of the risk_analysis dataset.
-- if operating with tables from different regions, this innitial client should remain region agnostic i.e not directed to any location since it would operate as a global code location
# --- CONFIGURATION ---
PROJECT_ID = 'bank-risk-project'
DATA_LOCATION = 'US' # Change once, update everywhere

client = bigquery.Client(project=PROJECT_ID, location=DATA_LOCATION)
# --- END CONFIGURATION ---
