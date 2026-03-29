# bank-customer-risk-segmentation
SQL project analyzing customer risk and loan default exposure

## Business Problem
The goal of this project is to segment bank customers based on credit risk and estimate expected loss per segment.

## Dataset
Bank customer dataset containing:
* Customer ID
* Credit Score
* Loan Amount
* Default Status
* Income

## SQL Analysis
The following analysis was performed:
* Customer segmentation by credit score
* Default rate per segment
* Average loan exposure
* High-risk customer identification

## Risk Insights
Customers with low credit scores have higher default rates and higher expected losses.

## Actuarial Interpretation
Expected Loss = Probability of Default × Loan Exposure

This model can help banks price loans and manage credit risk.

## How to Use: "Run queries.sql on the provided data.csv to reproduce these segments".

Step 1: Segment customers into Risk Tiers (Low, Medium, High) using a CASE statement on credit history or income.
Step 2: Calculate the Average Default Rate for each tier.
Step 3: Apply the Expected Loss formula ( Probability of Default * Loan Amount ) for each segment.
Step 4: Recommend which segments the bank should target for higher interest rates or stricter approval.
