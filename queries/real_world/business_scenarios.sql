-- =============================================
-- Real-World Business Scenarios Bundle
-- File: business_scenarios.sql
-- =============================================

-- Scenario 1: Payroll vs Budget Variance
-- Compares payroll expenses against allocated budget per department
-- -------------------------------------------------------------

SELECT
    d.department_name,
    b.fiscal_year,
    b.amount_allocated AS budget,
    NVL(SUM(p.salary), 0) AS payroll_expense,
    b.amount_allocated - NVL(SUM(p.salary), 0) AS variance,
    ROUND(
        CASE WHEN b.amount_allocated = 0 THEN 0
             ELSE (NVL(SUM(p.salary), 0) / b.amount_allocated) * 100
        END, 2) AS pct_utilized
FROM budget b
JOIN departments d ON b.department_id = d.department_id
LEFT JOIN payroll p ON d.department_id = p.department_id AND p.pay_period LIKE '2025-%'
GROUP BY d.department_name, b.fiscal_year, b.amount_allocated
ORDER BY variance;


-- Explanation:
-- This query aggregates payroll expenses per department and compares them to their budgets.
-- NVL ensures departments without payroll data are still shown.
-- Percentage utilization helps monitor budget spending.
-- Grouping and ordering make the report actionable for finance review.

-- Learning Notes:
-- LEFT JOIN keeps budget-only departments visible.
-- Aggregate functions and GROUP BY are critical for financial summaries.
-- Use CASE to avoid divide-by-zero errors in percentage calculations.

