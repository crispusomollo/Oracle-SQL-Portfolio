-- Module 06: Analytic Functions & Windowing
-- File: analytic_functions.sql
-- Tables Used: employees, payroll, departments
-- =============================================

-- =============================================
-- 🎯 Learning Objectives:
-- 1. Understand analytic/window functions: ROW_NUMBER(), RANK(), DENSE_RANK()
-- 2. Use LEAD() and LAG() for previous/next row analysis
-- 3. Partition data using PARTITION BY
-- 4. Apply OVER() clause with ORDER BY for running totals and moving averages
-- =============================================

-- 1. Assign row numbers to employees ordered by salary within their department
SELECT 
    employee_id,
    first_name,
    last_name,
    department_id,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM (
    SELECT e.employee_id, e.first_name, e.last_name, e.department_id, p.salary
    FROM employees e
    JOIN payroll p ON e.employee_id = p.employee_id
    WHERE p.pay_period = '2025-09'
);

-- 2. Rank employees with ties on salary within departments
SELECT 
    employee_id,
    first_name,
    last_name,
    department_id,
    salary,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank,
    DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dense_salary_rank
FROM (
    SELECT e.employee_id, e.first_name, e.last_name, e.department_id, p.salary
    FROM employees e
    JOIN payroll p ON e.employee_id = p.employee_id
    WHERE p.pay_period = '2025-09'
);

-- 3. Show previous and next salary for employees ordered by salary (within department)
SELECT 
    employee_id,
    first_name,
    last_name,
    department_id,
    salary,
    LAG(salary) OVER (PARTITION BY department_id ORDER BY salary) AS previous_salary,
    LEAD(salary) OVER (PARTITION BY department_id ORDER BY salary) AS next_salary
FROM (
    SELECT e.employee_id, e.first_name, e.last_name, e.department_id, p.salary
    FROM employees e
    JOIN payroll p ON e.employee_id = p.employee_id
    WHERE p.pay_period = '2025-09'
);

-- 4. Calculate running total of salaries in each department ordered by salary descending
SELECT 
    employee_id,
    first_name,
    last_name,
    department_id,
    salary,
    SUM(salary) OVER (PARTITION BY department_id ORDER BY salary DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_salary_total
FROM (
    SELECT e.employee_id, e.first_name, e.last_name, e.department_id, p.salary
    FROM employees e
    JOIN payroll p ON e.employee_id = p.employee_id
    WHERE p.pay_period = '2025-09'
);

-- 5. Calculate moving average salary over current and 2 previous rows within each department
SELECT 
    employee_id,
    first_name,
    last_name,
    department_id,
    salary,
    AVG(salary) OVER (PARTITION BY department_id ORDER BY salary DESC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_salary
FROM (
    SELECT e.employee_id, e.first_name, e.last_name, e.department_id, p.salary
    FROM employees e
    JOIN payroll p ON e.employee_id = p.employee_id
    WHERE p.pay_period = '2025-09'
);



-- Sample Dashboard Queries using Analytic Functions
-- File: dashboard_analytic_queries.sql
-- =============================================

-- 1. Top 3 highest paid employees per department with their rank
SELECT
    department_id,
    first_name || ' ' || last_name AS employee_name,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_salary_rank
FROM (
    SELECT e.employee_id, e.first_name, e.last_name, e.department_id, p.salary
    FROM employees e
    JOIN payroll p ON e.employee_id = p.employee_id
    WHERE p.pay_period = '2025-09'
)
WHERE ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) <= 3;

-- 2. Running total of payroll expenses by department ordered by employee salary
SELECT
    department_id,
    first_name || ' ' || last_name AS employee_name,
    salary,
    SUM(salary) OVER (PARTITION BY department_id ORDER BY salary DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_payroll_total
FROM (
    SELECT e.employee_id, e.first_name, e.last_name, e.department_id, p.salary
    FROM employees e
    JOIN payroll p ON e.employee_id = p.employee_id
    WHERE p.pay_period = '2025-09'
);

-- 3. Salary difference from previous employee within the same department
SELECT
    department_id,
    first_name || ' ' || last_name AS employee_name,
    salary,
    salary - LAG(salary) OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_diff_prev
FROM (
    SELECT e.employee_id, e.first_name, e.last_name, e.department_id, p.salary
    FROM employees e
    JOIN payroll p ON e.employee_id = p.employee_id
    WHERE p.pay_period = '2025-09'
);

-- 4. Average salary over last 3 employees within each department (moving average)
SELECT
    department_id,
    first_name || ' ' || last_name AS employee_name,
    salary,
    AVG(salary) OVER (PARTITION BY department_id ORDER BY salary DESC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_salary
FROM (
    SELECT e.employee_id, e.first_name, e.last_name, e.department_id, p.salary
    FROM employees e
    JOIN payroll p ON e.employee_id = p.employee_id
    WHERE p.pay_period = '2025-09'
);

