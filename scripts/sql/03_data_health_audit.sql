/* 
    STAGE: 03 - Data Integrity Audit
    GOAL: Quantify residual data gaps in interest rates and employment length.
*/
SELECT 
    COUNT(*) as total_loans,
    COUNTIF(loan_int_rate IS NULL) as null_interest_rows,
    COUNTIF(person_emp_length IS NULL) as null_emp_rows,
    ROUND(COUNTIF(loan_int_rate IS NULL) * 100 / COUNT(*), 2) as pct_interest_gap
FROM `<YOUR_PROJECT_ID>.risk_analysis.v_hardened_loans`;
