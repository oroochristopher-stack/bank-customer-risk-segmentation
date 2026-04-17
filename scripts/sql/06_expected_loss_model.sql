/* 
    STAGE: 05 - Expected Loss (EL) Provisioning Report
    GOAL: Calculate capital reserves using Basel III LGD=0.70 standards.
*/
WITH Segment_Risk AS (
    SELECT 
        risk_tier,
        COUNT(*) AS customer_count,
        SUM(loan_amnt) AS exposure_ead,
        AVG(loan_status) AS segment_pd
    FROM `<YOUR_PROJECT_ID>.risk_analysis.v_hardened_loans`
    GROUP BY 1
)
SELECT 
    risk_tier,
    exposure_ead,
    ROUND(segment_pd * exposure_ead * 0.70, 0) AS capital_provision_needed,
    ROUND((segment_pd * exposure_ead * 0.70) / exposure_ead, 3) AS loss_intensity
FROM Segment_Risk
ORDER BY loss_intensity DESC;
