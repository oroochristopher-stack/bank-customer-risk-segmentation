/* 
    STAGE: 04 - Data Integrity Audit
    GOAL: Reconcile row counts between the Raw Source and the Hardened View.
    NOTE: A delta of 0 is required for Data Governance compliance.
*/

-- Step A: Get Raw Count
SELECT 
    'Raw_Source' AS source, 
    COUNT(*) AS total_rows 
FROM `<YOUR_PROJECT_ID>.risk_analysis.loan_data`

UNION ALL

-- Step B: Get Hardened Count
SELECT 
    'Hardened_View' AS source, 
    COUNT(*) AS total_rows 
FROM `<YOUR_PROJECT_ID>.risk_analysis.v_hardened_loans`;
