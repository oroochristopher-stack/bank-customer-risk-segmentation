/* 
    STAGE: 07 - Grade vs. LTI Audit
    GOAL: Test the accuracy of legacy Credit Grades (A-G) against LTI debt ratios.
*/
SELECT 
    loan_grade,
    risk_tier, 
    COUNT(*) AS volume,
    ROUND(AVG(loan_status) * 100, 2) AS pd_pct
FROM `<YOUR_PROJECT_ID>.risk_analysis.v_hardened_loans`
GROUP BY 1, 2
ORDER BY 1, 2;
