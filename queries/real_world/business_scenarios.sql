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


-- Scenario 2: Inventory Cost Allocation
-- Calculates total inventory costs allocated to IT and Finance departments, tracking cost trends
-- -------------------------------------------------------------------

SELECT
    d.department_name,
    i.item_category,
    SUM(i.unit_cost * i.quantity) AS total_inventory_cost
FROM inventory i
JOIN departments d ON i.department_id = d.department_id
WHERE d.department_name IN ('IT', 'Finance')
GROUP BY d.department_name, i.item_category
ORDER BY d.department_name, total_inventory_cost DESC;

-- Explanation:
-- Summarizes inventory costs by category for IT and Finance.
-- Useful for budgeting and expense tracking related to inventory holdings.

-- Learning Notes:
-- Multiplying unit cost by quantity calculates total cost per item.
-- Filtering with WHERE limits to relevant departments.
-- Aggregating by department and category provides granular insight.
-- Sorting helps identify costly inventory categories quickly.




Scenario 3: Employee Training Impact on Payroll
-- =============================================
-- Scenario 3: Employee Training Impact on Payroll
-- Analyze if employees who attended training received salary increments or bonuses
-- ------------------------------------------------

WITH training_employees AS (
    SELECT DISTINCT employee_id
    FROM training_logs
),
salary_before_training AS (
    SELECT e.employee_id, p.salary AS salary_before
    FROM employees e
    JOIN payroll p ON e.employee_id = p.employee_id
    WHERE p.pay_period = '2025-06' -- before training period
),
salary_after_training AS (
    SELECT e.employee_id, p.salary AS salary_after
    FROM employees e
    JOIN payroll p ON e.employee_id = p.employee_id
    WHERE p.pay_period = '2025-09' -- after training period
)

SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    COALESCE(sbt.salary_before, 0) AS salary_before_training,
    COALESCE(sat.salary_after, 0) AS salary_after_training,
    COALESCE(sat.salary_after, 0) - COALESCE(sbt.salary_before, 0) AS salary_change,
    CASE WHEN t.employee_id IS NOT NULL THEN 'Trained' ELSE 'Not Trained' END AS training_status
FROM employees e
LEFT JOIN training_employees t ON e.employee_id = t.employee_id
LEFT JOIN salary_before_training sbt ON e.employee_id = sbt.employee_id
LEFT JOIN salary_after_training sat ON e.employee_id = sat.employee_id
ORDER BY salary_change DESC;

-- Explanation:
-- This query compares employees' salaries before and after a training period.
-- It highlights salary increments and correlates them with training attendance.
-- Useful for HR and Finance to assess training ROI.

-- Learning Notes:
-- Uses CTEs (WITH clause) for modular, readable query parts.
-- DISTINCT filters unique trained employees.
-- COALESCE handles missing salary data.
-- LEFT JOIN preserves all employees for comprehensive analysis.




Scenario 4: Budget Utilization Forecast
-- =============================================
-- Scenario 4: Budget Utilization Forecast
-- Forecast next quarter budget utilization based on current expense trends
-- ------------------------------------------------

WITH monthly_expenses AS (
    SELECT
        department_id,
        TO_CHAR(TO_DATE(pay_period, 'YYYY-MM'), 'YYYY-MM') AS month,
        SUM(salary) AS total_payroll_expense
    FROM payroll
    WHERE pay_period BETWEEN '2025-01' AND '2025-09'
    GROUP BY department_id, TO_CHAR(TO_DATE(pay_period, 'YYYY-MM'), 'YYYY-MM')
),
avg_monthly_expense AS (
    SELECT
        department_id,
        AVG(total_payroll_expense) AS avg_monthly_expense
    FROM monthly_expenses
    GROUP BY department_id
),
budget_alloc AS (
    SELECT department_id, amount_allocated AS quarterly_budget
    FROM budget
    WHERE fiscal_year = 2025
)

SELECT
    d.department_name,
    b.quarterly_budget,
    a.avg_monthly_expense,
    a.avg_monthly_expense * 3 AS forecasted_quarterly_expense,
    b.quarterly_budget - (a.avg_monthly_expense * 3) AS forecasted_variance
FROM avg_monthly_expense a
JOIN budget_alloc b ON a.department_id = b.department_id
JOIN departments d ON a.department_id = d.department_id
ORDER BY forecasted_variance;

-- Explanation:
-- Forecasts next quarter payroll spending by averaging past monthly expenses and multiplying by 3.
-- Compares forecasted spending to budget allocations for variance insights.
-- Helps finance anticipate budget overruns or savings.

-- Learning Notes:
-- Uses multiple CTEs for logical breakdown.
-- Aggregates monthly expenses and averages them.
-- Basic forecasting via trend extrapolation.




Scenario 5: System Downtime Impact on Payroll Processing
-- =============================================
-- Scenario 5: System Downtime Impact on Payroll Processing
-- Identifies payroll delays correlated with IT system downtime
-- ------------------------------------------------

SELECT
    p.pay_period,
    COUNT(p.employee_id) AS payroll_processed,
    COUNT(d.downtime_id) AS downtime_events,
    CASE
        WHEN COUNT(d.downtime_id) > 0 THEN 'Potential Impact'
        ELSE 'No Impact'
    END AS impact_status
FROM payroll p
LEFT JOIN downtime_logs d ON p.pay_period = d.affected_period
GROUP BY p.pay_period
ORDER BY p.pay_period;

-- Explanation:
-- Counts payroll processed vs. IT downtime events per pay period.
-- Highlights periods where downtime may have affected payroll processing.
-- Useful for IT and HR collaboration on system reliability.

-- Learning Notes:
-- LEFT JOIN captures pay periods even without downtime.
-- Conditional logic flags periods with possible impact.
-- Useful pattern for correlating events across departments.

