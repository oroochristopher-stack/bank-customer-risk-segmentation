# Bank-Customer-Risk-Segmentation
SQL project analyzing customer risk and loan default exposure
 * define the logic in banking behind it b4 getting technical*
## 1 Business Problem
The goal of this project is to segment bank customers based on credit risk and estimate expected loss per segment.

## 2 Dataset *
Bank customer dataset containing:
* Customer ID
* Credit Score
* Loan Amount
* Default Status
* Income

## 3 SQL Analysis *
The following analysis was performed:
* Customer segmentation by credit score
* Default rate per segment
* Average loan exposure
* High-risk customer identification

## 4 Risk Insights
Customers with low credit scores have higher default rates and higher expected losses.

## 5 Actuarial Interpretation
Expected Loss = Probability of Default × Loan Exposure

This model can help banks price loans and manage credit risk.

## 6  Data Engineering & Integrity
Analysis is performed in Google BigQuery to simulate a cloud-native environment. This is a single region project.

Secure Connection: Successfully architected a Python-to-BigQuery bridge using OAuth 2.0 tokenization. Implemented explicit project-scoping to ensure data governance and billing accuracy.

Data Residency: All processing is restricted to the 'US' multi-region to ensure alignment with project-specific cloud architecture.

Upon ingesting the raw CSV into Google BigQuery, I identified that the Auto-detect schema incorrectly flagged certain numerical columns (person_emp_length, loan_int_rate) as nulls due to source formatting.

My Solution: Instead of manually editing the source CSV, I built a SQL Cleaning Layer using SAFE_CAST and COALESCE. This ensures the analysis is reproducible and ready for production-scale data.

Analytical Methodology: Developed a multi-stage CTE pipeline to handle data imputation and risk-metric derivation, ensuring high auditability 
Developed a tri-tier risk segmentation model based on LTI (Loan-to-Income) ratios to enable Risk-Based Pricing and optimize capital reserve requirements.
Optimized the data lifecycle by moving from raw storage to a Governed View Layer, implementing automated imputation
Analyzed 3,116 imputed records against the original 29,465. Statistical parity in LTI (0.171 vs 0.170) and Default Rates (20.67% vs 21.94%) validates the use of Grade-level Median imputation as a non-biasing risk strategy in this context.

### Optimization & Data Governance
Boolean Normalization: During ingestion, I chose to maintain cb_person_default_on_file as a Native Boolean (TRUE/FALSE) rather than a String (Y/N).
Value: This choice optimizes storage efficiency in the BigQuery environment and enables high-performance filtering for multi-million row risk simulations.


## 7 How to Use: "Run queries.sql on the provided data.csv to reproduce these segments".

Step 1: Segment customers into Risk Tiers (Low, Medium, High) using a CASE statement on credit history or income.
Step 2: Calculate the Average Default Rate for each tier.
Step 3: Apply the Expected Loss formula ( Probability of Default * Loan Amount ) for each segment.
Step 4: Recommend which segments the bank should target for higher interest rates or stricter approval.
