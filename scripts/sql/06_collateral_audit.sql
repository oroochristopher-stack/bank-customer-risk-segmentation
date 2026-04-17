/* 
    STAGE: 06 - Collateral Audit (Multivariate Risk)
    GOAL: Measure the mitigating effect of Home Ownership on LTI-driven Default Rates.
*/
SELECT 
    risk_tier,
    person_home_ownership,
    COUNT(*) AS volume,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct,
    ROUND(SUM(loan_amnt), 2) AS exposure_at_risk
FROM `<YOUR_PROJECT_ID>.risk_analysis.v_hardened_loans`
GROUP BY 1, 2
ORDER BY 1 ASC, 4 DESC;
