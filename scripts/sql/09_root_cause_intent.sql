/* 
    STAGE: 09 - Root Cause Analysis (Toxic Intent)
    GOAL: Determine if loan purpose affects the 100% default rate of Tier 3 Renters.
*/
SELECT 
    loan_intent,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct,
    ROUND(SUM(loan_amnt), 0) AS exposure_ead,
    ROUND(AVG(lti_ratio), 3) AS avg_lti,
    ROUND(AVG(int_rate_clean), 2) AS avg_int_rate
FROM `<YOUR_PROJECT_ID>.risk_analysis.v_hardened_loans`
WHERE risk_tier = 'Tier 3: High Risk (Subprime)' 
  AND person_home_ownership = 'RENT'
GROUP BY 1
ORDER BY exposure_ead DESC;
