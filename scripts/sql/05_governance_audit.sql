/* 
    STAGE: 05 - Governance Audit (Stress Test)
    GOAL: Detect Selection Bias (Missing Not At Random) in the 9.56% imputed interest rate gap.
*/
WITH Integrity_Split AS (
    SELECT 
        CASE 
            WHEN loan_int_rate IS NULL THEN 'Gap Group (Imputed)' 
            ELSE 'Clean Group (Original)' 
        END AS data_integrity_segment,
        loan_status,
        default_history_flag,
        lti_ratio,
        loan_amnt
    FROM `<YOUR_PROJECT_ID>.risk_analysis.v_hardened_loans`
)
SELECT 
    data_integrity_segment,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS current_default_rate_pct,
    ROUND(AVG(default_history_flag) * 100, 2) AS prev_default_history_pct,
    ROUND(AVG(lti_ratio), 3) AS avg_lti_ratio,
    ROUND(SUM(loan_amnt), 0) AS total_exposure_ead
FROM Integrity_Split
GROUP BY 1;
