--📦 Module 05: Aggregation & GROUP BY
--SQL File: queries/intermediate/aggregation_groupby.sql
--Tables Used: employees, departments, payroll, budget, expenses

--📁 queries/intermediate/aggregation_groupby.sql
-- =============================================
-- Module 05: Aggregation & GROUP BY
-- File: aggregation_groupby.sql
-- Tables Used: employees, departments, payroll, budget, expenses
-- =============================================

-- =============================================
-- 🎯 Learning Objectives:
-- 1. Understand aggregation functions: COUNT, SUM, AVG, MAX, MIN
-- 2. Group data using GROUP BY
-- 3. Filter grouped data with HAVING
-- 4. Write business queries that summarize payroll, budgets, and expenses
-- =============================================


-- 1. Count total employees per department
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS total_employees
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- 2. Sum total payroll per department for latest pay period
SELECT 
    d.department_name,
    SUM(p.salary) AS total_payroll
FROM payroll p
JOIN employees e ON p.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE p.pay_period = '2025-09'
GROUP BY d.department_name;

-- 3. Average salary per department
SELECT 
    d.department_name,
    AVG(p.salary) AS avg_salary
FROM payroll p
JOIN employees e ON p.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- 4. Maximum salary in each department
SELECT 
    d.department_name,
    MAX(p.salary) AS max_salary
FROM payroll p
JOIN employees e ON p.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- 5. Total budget vs total expenses per department (fiscal year 2025)
SELECT 
    d.department_name,
    b.amount_allocated AS budget,
    NVL(SUM(e.amount), 0) AS expenses
FROM budget b
JOIN departments d ON b.department_id = d.department_id
LEFT JOIN expenses e ON b.department_id = e.department_id
WHERE b.fiscal_year = 2025
GROUP BY d.department_name, b.amount_allocated;

-- 6. Departments where expenses exceed 75% of budget (HAVING clause)
SELECT 
    d.department_name,
    b.amount_allocated AS budget,
    NVL(SUM(e.amount), 0) AS expenses,
    ROUND(NVL(SUM(e.amount), 0) / b.amount_allocated * 100, 2) AS percent_used
FROM budget b
JOIN departments d ON b.department_id = d.department_id
LEFT JOIN expenses e ON b.department_id = e.department_id
WHERE b.fiscal_year = 2025
GROUP BY d.department_name, b.amount_allocated
HAVING NVL(SUM(e.amount), 0) > b.amount_allocated * 0.15;

-- 7. Count trainings per employee
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    COUNT(t.training_id) AS training_count
FROM employees e
LEFT JOIN training_logs t ON e.employee_id = t.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY training_count DESC;

-- 8. Average training duration (in days) per employee
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    AVG(t.end_date - t.start_date + 1) AS avg_training_days
FROM employees e
LEFT JOIN training_logs t ON e.employee_id = t.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
HAVING COUNT(t.training_id) > 0;




-- Sample Report Queries
-- Report 1: Monthly Payroll Summary (Sep 2025)
SELECT
    d.department_name,
    COUNT(p.employee_id) AS num_employees_paid,
    SUM(p.salary) AS total_salary_paid,
    AVG(p.salary) AS avg_salary_paid
FROM payroll p
JOIN employees e ON p.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE p.pay_period = '2025-09'
GROUP BY d.department_name
ORDER BY total_salary_paid DESC;

-- Report 2: Budget Utilization by Department (2025)
SELECT
    d.department_name,
    b.amount_allocated AS budget,
    NVL(SUM(e.amount), 0) AS expenses,
    ROUND(NVL(SUM(e.amount), 0) / b.amount_allocated * 100, 2) AS percent_used
FROM budget b
JOIN departments d ON b.department_id = d.department_id
LEFT JOIN expenses e ON b.department_id = e.department_id
WHERE b.fiscal_year = 2025
GROUP BY d.department_name, b.amount_allocated
ORDER BY percent_used DESC;

-- Report 3: Top 5 Employees by Number of Trainings Attended
SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    COUNT(t.training_id) AS trainings_attended
FROM employees e
LEFT JOIN training_logs t ON e.employee_id = t.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY trainings_attended DESC
FETCH FIRST 5 ROWS ONLY;

-- Report 4: Employees without Any Trainings
SELECT
    e.employee_id,
    e.first_name,
    e.last_name
FROM employees e
LEFT JOIN training_logs t ON e.employee_id = t.employee_id
WHERE t.training_id IS NULL
ORDER BY e.last_name;
