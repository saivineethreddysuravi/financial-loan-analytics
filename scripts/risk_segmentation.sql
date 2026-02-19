-- Financial Loan Analytics: Risk Segmentation & LTV Calculations
-- Target: Snowflake / PostgreSQL

-- Create base features for risk modeling
WITH Loan_Stats AS (
    SELECT
        loan_id,
        customer_id,
        loan_amount,
        annual_income,
        credit_score,
        home_ownership,
        loan_purpose,
        -- Calculate Loan-to-Income Ratio
        ROUND((loan_amount / NULLIF(annual_income, 0)) * 100, 2) AS lti_ratio,
        
        -- Segment Customers by Credit Bracket
        CASE 
            WHEN credit_score >= 800 THEN 'Exceptional'
            WHEN credit_score >= 740 THEN 'Very Good'
            WHEN credit_score >= 670 THEN 'Good'
            WHEN credit_score >= 580 THEN 'Fair'
            Else 'Poor' 
        END AS credit_tier
    FROM raw_loan_data
),

Risk_Metrics AS (
    SELECT
        credit_tier,
        COUNT(*) AS total_applicants,
        AVG(lti_ratio) AS avg_lti,
        SUM(loan_amount) AS total_exposure,
        -- Percentile contribution of each tier using window functions
        ROUND(100.0 * SUM(loan_amount) OVER() / NULLIF(FIRST_VALUE(SUM(loan_amount)) OVER(ORDER BY SUM(loan_amount) DESC), 0), 2) AS pct_of_total_volume
    FROM Loan_Stats
    GROUP BY 1
)

SELECT * FROM Risk_Metrics 
ORDER BY avg_lti DESC;

-- Query for HIGH RISK flagging (Strategic Documentation Proxy)
SELECT * 
FROM Loan_Stats
WHERE credit_tier IN ('Fair', 'Poor')
AND lti_ratio > 40
AND home_ownership = 'RENT';