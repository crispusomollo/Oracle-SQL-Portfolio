-- Module 07: Subqueries & Nested Queries
-- File: subqueries_nested.sql
-- =============================================

-- 🎯 Learning Objectives:
-- 1. Understand subqueries in SELECT, FROM, WHERE clauses
-- 2. Correlated subqueries
-- 3. Use EXISTS and NOT EXISTS
-- 4. Apply subqueries for filtering and aggregation

-- 1. Subquery in WHERE clause: Find employees with salary above average salary of their department
SELECT 
    employee_id,
    first_name,
    last_name,
    department_id,
    salary
FROM (
    SELECT e.employee_id, e.first_name, e.last_name, e.department_id, p.salary
    FROM employees e
    JOIN payroll p ON e.employee_id = p.employee_id
    WHERE p.pay_period = '2025-09'
) emp_pay
WHERE salary > (
    SELECT AVG(salary)
    FROM (
        SELECT e2.employee_id, e2.department_id, p2.salary
        FROM employees e2
        JOIN payroll p2 ON e2.employee_id = p2.employee_id
        WHERE p2.pay_period = '2025-09'
    ) dept_pay
    WHERE dept_pay.department_id = emp_pay.department_id
);

-- 2. Correlated subquery with EXISTS: Employees who have attended any training
SELECT 
    employee_id,
    first_name,
    last_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM training_logs t
    WHERE t.employee_id = e.employee_id
);

-- 3. NOT EXISTS: Employees without any training
SELECT 
    employee_id,
    first_name,
    last_name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM training_logs t
    WHERE t.employee_id = e.employee_id
);


