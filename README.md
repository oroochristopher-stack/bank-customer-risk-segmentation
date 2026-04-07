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
## 7 Business Impact
Multi-Factor Risk Discovery: The Collateral-LTI Correlation
The "Death Zone": Identified a 100% correlation between High-LTI Renters and Default Events. This segment represents $12.5M in pure loss.
Collateral Mitigation: Homeownership (OWN/MORTGAGE) acts as a significant risk buffer, reducing defaults by ~75% even when LTI ratios are critically high.
Strategic Recommendation: Implement a Tiered LTI Cap:
Renters: Hard cap at 0.30 LTI.
Homeowners: Flexible cap up to 0.40 LTI, contingent on Credit Grade.

### 📈 Business Value & Strategic Recommendations:
1. Immediate LTI Ceiling for High-Risk Segments
The Insight: Tier 3 Renters (LTI > 0.40) exhibit a 100% historical default rate, representing $12.5M in guaranteed loss.
Recommendation: Implement a hard LTI cap of 0.30 for Renter applications. This "Approval Frontier" shift protects the bank's solvency by eliminating segments where loss intensity exceeds recovery potential.
2. Collateral-Adjusted Underwriting
The Insight: Homeownership acts as a powerful risk buffer; OWN/MORTGAGE borrowers are 75% more stable than Renters even at high debt levels.
Recommendation: Pivot the marketing and capital allocation toward Homeowners. The bank should offer preferential LTI limits (up to 0.45) for homeowners in the Prime/Standard tiers to capture high-quality, collateral-backed volume.
3. Operational Management of the "Back-Book" (Existing Loans)
The Insight: Tier 2 Renters have a 39.9% Default Rate with a massive $90M exposure. Since these interest rates are contractually fixed, the bank cannot "price out" the risk.
Recommendation:
High-Intensity Collections: Prioritize Tier 2 Renter accounts in the collections queue.
Proactive Restructuring: Offer term extensions to debt-stressed Tier 2 renters to lower monthly payments and prevent total default.
4. Capital Reserve Optimization (IFRS 9/CECL Standard)
The Insight: The current portfolio is over-concentrated in "Flight Capital" (Renters).
Recommendation: Increase the Expected Credit Loss (ECL) provisions for the Tier 2 Renter segment immediately. This ensures the bank has enough "Safety Cash" to survive the predicted 40% loss rate in this bucket.

### Model Failure: The Grade-LTI Mismatch
The Discovery: High-LTI ratios "override" high credit grades. Grade A borrowers with a Tier 3 LTI ratio exhibit a 66.3% PD, representing a critical mispricing of risk.
Systemic Weakness: The legacy Grading system fails to account for Debt Capacity. A borrower with a perfect history (Grade A) but excessive debt (Tier 3) is 18x riskier than a Grade A borrower with low debt.
The Recommendation: Implement a "Hard Stop" Override. Regardless of Credit Grade, any applicant with an LTI > 0.40 should be auto-rejected or manually audited.



## 8 How to Use: "Run queries.sql on the provided data.csv to reproduce these segments".

Step 1: Segment customers into Risk Tiers (Low, Medium, High) using a CASE statement on credit history or income.
Step 2: Calculate the Average Default Rate for each tier.
Step 3: Apply the Expected Loss formula ( Probability of Default * Loan Amount ) for each segment.
Step 4: Recommend which segments the bank should target for higher interest rates or stricter approval.
