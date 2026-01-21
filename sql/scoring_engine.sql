-- ==============================================================================
-- Enterprise Credit Risk Scoring Engine
-- Business Logic: Automated Loan Risk Assessment
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- 1. RISK SCORE CALCULATION (Weighted Multi-Factor Model)
-- ------------------------------------------------------------------------------
-- Calculates a dynamic 'Internal Credit Score' (0-100) based on:
-- - Debt-to-Income (DTI)
-- - Employment Stability
-- - Historical Delinquency
-- - Loan Amount vs. Income

WITH ScoringBase AS (
    SELECT 
        loan_id,
        member_id,
        annual_inc,
        dti,
        emp_length_years,
        loan_amount,
        -- Weighted Component 1: DTI Factor (Lower is better)
        CASE 
            WHEN dti < 10 THEN 40
            WHEN dti < 20 THEN 30
            WHEN dti < 30 THEN 15
            ELSE 0 
        END AS dti_score,
        -- Weighted Component 2: Employment Factor (Stability)
        CASE 
            WHEN emp_length_years >= 10 THEN 20
            WHEN emp_length_years >= 5 THEN 15
            WHEN emp_length_years >= 2 THEN 10
            ELSE 5 
        END AS stability_score,
        -- Weighted Component 3: Income Coverage
        CASE 
            WHEN (annual_inc / NULLIF(loan_amount, 0)) > 5 THEN 40
            WHEN (annual_inc / NULLIF(loan_amount, 0)) > 3 THEN 25
            WHEN (annual_inc / NULLIF(loan_amount, 0)) > 1.5 THEN 10
            ELSE 0 
        END AS coverage_score
    FROM fact_loans
)
SELECT 
    loan_id,
    member_id,
    (dti_score + stability_score + coverage_score) AS calculated_risk_score,
    CASE 
        WHEN (dti_score + stability_score + coverage_score) >= 80 THEN 'Tier 1 (Prime)'
        WHEN (dti_score + stability_score + coverage_score) >= 50 THEN 'Tier 2 (Sub-Prime)'
        ELSE 'Tier 3 (High Risk)'
    END AS risk_classification
FROM ScoringBase;
