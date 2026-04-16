/* 
    STAGE: 02 - Data Hardening (Silver View)
    GOAL: Automated imputation of NULL values and creation of LTI metrics/Risk Tiers.
*/
CREATE OR REPLACE VIEW `<YOUR_PROJECT_ID>.risk_analysis.v_hardened_loans` AS 
WITH Base_Data AS (
    SELECT * FROM `<YOUR_PROJECT_ID>.risk_analysis.loan_data`
),
Imputed_Values AS (
    SELECT 
        *,
        COALESCE(SAFE_CAST(person_emp_length AS FLOAT64), 0) AS emp_length_clean,
        COALESCE(
            SAFE_CAST(loan_int_rate AS FLOAT64), 
            ROUND(AVG(SAFE_CAST(loan_int_rate AS FLOAT64)) OVER(PARTITION BY loan_grade), 2)
        ) AS int_rate_clean
    FROM Base_Data
),
Risk_Metrics AS (
    SELECT 
        *,
        ROUND(SAFE_DIVIDE(loan_amnt, person_income), 3) AS lti_ratio,
        CASE WHEN cb_person_default_on_file IS TRUE THEN 1 ELSE 0 END AS default_history_flag
    FROM Imputed_Values
),
Tiered_Data AS (
    SELECT 
        *,
        CASE 
            WHEN lti_ratio <= 0.15 THEN 'Tier 1: Low Risk (Prime)'
            WHEN lti_ratio > 0.15 AND lti_ratio <= 0.40 THEN 'Tier 2: Medium Risk (Standard)'
            ELSE 'Tier 3: High Risk (Subprime)'
        END AS risk_tier
    FROM Risk_Metrics
)
SELECT * FROM Tiered_Data;
