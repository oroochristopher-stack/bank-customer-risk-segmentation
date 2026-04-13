# Constructing a reference to the dataset
dataset_ref = client.dataset("risk_analysis", project=PROJECT_ID)
dataset = client.get_dataset(dataset_ref)

# Fetching the list of tables from the dataset & printing
tables_pr = list(client.list_tables(dataset))
print(" Tables available in your dataset:")
for t in tables_pr: 
    print(f" - {t.table_id}")
