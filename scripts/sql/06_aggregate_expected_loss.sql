/* 
    STAGE: 05 - Expected Loss (EL) & Pricing Report
    GOAL: Compare Interest Yield vs. Loss Intensity to identify under-priced risk.
*/
WITH Segment_Risk AS (
    SELECT 
        risk_tier,
        COUNT(*) AS customer_count,
        SUM(loan_amnt) AS exposure_ead,
        AVG(loan_status) AS segment_pd,
        AVG(int_rate_clean) AS avg_interest_rate
    FROM ``<YOUR_PROJECT_ID>.risk_analysis.v_hardened_loans`.risk_analysis.v_hardened_loans`
    GROUP BY risk_tier
),

EL_Calculation AS (
    SELECT 
        *,
        (segment_pd * exposure_ead) AS baseline_el,
        (segment_pd * exposure_ead * 0.70) AS capital_provision_needed
    FROM Segment_Risk
)
SELECT 
    risk_tier,
    customer_count,
    ROUND(exposure_ead, 0) AS total_exposure,
    ROUND(segment_pd * 100, 2) AS pd_pct,
    ROUND(baseline_el, 0) AS baseline_expected_loss,
    ROUND(capital_provision_needed, 0) AS required_reserves,
    ROUND(avg_interest_rate, 2) AS avg_yield_pct,
    ROUND((capital_provision_needed / exposure_ead)*100, 2) AS loss_intensity_pct
FROM EL_Calculation
ORDER BY pd_pct ASC
