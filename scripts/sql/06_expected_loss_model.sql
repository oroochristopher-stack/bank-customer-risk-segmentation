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
    FROM `<YOUR_PROJECT_ID>.risk_analysis.v_hardened_loans`
    GROUP BY risk_tier
),
EL_Calculation AS (
    SELECT 
        *,
        (segment_pd * exposure_ead * 0.70) AS expected_loss_el
    FROM Segment_Risk
)
SELECT 
    risk_tier,
    customer_count,
    ROUND(segment_pd * 100, 2) AS pd_percentage,
    ROUND(expected_loss_el, 0) AS capital_provision,
    ROUND(avg_interest_rate, 2) AS avg_int_rate,
    ROUND((expected_loss_el / exposure_ead)*100, 2) AS loss_intensity
FROM EL_Calculation
ORDER BY pd_percentage ASC;
