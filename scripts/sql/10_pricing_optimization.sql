/* 
    STAGE: 10 - Pricing Optimization & RAROC 
    GOAL: Identify negative-margin segments and calculate break-even + 2% target rates.
*/
WITH Segment_Profitability AS (
    SELECT 
        risk_tier,
        person_home_ownership,
        COUNT(*) AS loan_count,
        ROUND(AVG(int_rate_clean), 2) AS avg_rev_rate,
        ROUND(AVG(loan_status) * 0.70 * 100, 2) AS risk_cost_rate
    FROM `{PROJECT_ID}.risk_analysis.v_hardened_loans`
    GROUP BY 1, 2
)
SELECT 
    risk_tier,
    person_home_ownership,
    loan_count,
    avg_rev_rate AS current_rate,
    risk_cost_rate AS cost_of_risk,
    ROUND(avg_rev_rate - risk_cost_rate, 2) AS net_risk_margin,
    
  
    CASE 
        WHEN (avg_rev_rate - risk_cost_rate) >= 2.0 THEN avg_rev_rate 
        ELSE ROUND(risk_cost_rate + 2.0, 2)
    END AS final_recommended_rate
    
FROM Segment_Profitability
ORDER BY risk_tier, person_home_ownership
