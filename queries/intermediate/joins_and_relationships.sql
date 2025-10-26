-- 📁 queries/intermediate/joins_and_relationships.sql
-- ===================================================
-- Module 04: Joins & Relationships
-- File: joins_and_relationships.sql
-- Tables Used: employees, departments, training_logs, payroll, budget, expenses
-- ===================================================

-- ===================================================
-- 🎯 Learning Objectives:
-- 1. Understand INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN
-- 2. Use table aliases for readability
-- 3. Join across multiple tables
-- 4. Practice joining with WHERE and ON
-- 5. Write business-like queries across departments
-- ===================================================


-- 1. INNER JOIN: List employees with their department names
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
INNER JOIN departments d
    ON e.department_id = d.department_id;
    
    
-- 2. INNER JOIN with filter: Only HR employees
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Human Resources';


-- 3.️ LEFT JOIN: All employees and any related payroll info
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    p.salary,
    p.pay_period
FROM employees e
LEFT JOIN payroll p ON e.employee_id = p.employee_id;


-- 4. RIGHT JOIN: All payroll records and matching employees
SELECT 
    p.payroll_id,
    e.first_name,
    p.salary,
    p.pay_period
FROM payroll p
RIGHT JOIN employees e ON p.employee_id = e.employee_id;

-- 5. FULL OUTER JOIN: All employees and all payrolls (show mismatches)
SELECT 
    e.employee_id,
    e.first_name,
    p.salary,
    p.pay_period
FROM employees e
FULL OUTER JOIN payroll p ON e.employee_id = p.employee_id;

-- 6. Multi-table JOIN: Training records with employee name and trainer name
SELECT 
    t.training_id,
    e.first_name || ' ' || e.last_name AS trainee,
    t.training_title,
    t.start_date,
    c.first_name || ' ' || c.last_name AS trainer
FROM training_logs t
JOIN employees e ON t.employee_id = e.employee_id
JOIN employees c ON t.conducted_by = c.employee_id;

-- 7. Department-wise budget and total expenses (JOIN + GROUP BY)
SELECT 
    d.department_name,
    b.fiscal_year,
    b.amount_allocated,
    NVL(SUM(e.amount), 0) AS total_expenses
FROM budget b
JOIN departments d ON b.department_id = d.department_id
LEFT JOIN expenses e ON b.department_id = e.department_id
GROUP BY d.department_name, b.fiscal_year, b.amount_allocated;

-- 8. Employees without training logs (LEFT JOIN + IS NULL)
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name
FROM employees e
LEFT JOIN training_logs t ON e.employee_id = t.employee_id
WHERE t.training_id IS NULL;

-- 9. Employees and their managers (self-join)
SELECT 
    e.first_name || ' ' || e.last_name AS employee,
    m.first_name || ' ' || m.last_name AS manager
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN employees m ON d.manager_id = m.employee_id;

-- 🔟 CROSS JOIN (use carefully): All department/employee combinations
SELECT 
    d.department_name,
    e.first_name
FROM departments d
CROSS JOIN employees e
WHERE ROWNUM <= 10; -- limit for safety

