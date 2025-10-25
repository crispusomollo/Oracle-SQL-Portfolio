-- ===============================================
-- Module 02: Basic SQL Queries
-- File: select_basics.sql
-- Description: Foundational SQL SELECT statements using Oracle syntax.
-- Tables Used: employees, departments
-- ===============================================

-- ===============================================
-- 🎯 Learning Objectives:
-- 1. Retrieve data using SELECT
-- 2. Filter rows using WHERE
-- 3. Sort results using ORDER BY
-- 4. Limit results using ROWNUM
-- 5. Combine columns with aliases and expressions
-- ===============================================


-- 1. Basic SELECT: Get all employees
SELECT * FROM employees;

-- 2. SELECT specific columns: First and Last names only
SELECT first_name, last_name FROM employees;

-- 3. Use aliases to make output clearer
SELECT 
    first_name AS "First Name", 
    last_name AS "Last Name", 
    salary AS "Monthly Salary"
FROM employees;

-- 4. Combine columns into full name
SELECT 
    first_name || ' ' || last_name AS full_name
FROM employees;

-- 5. Add a calculated field (annual salary)
SELECT 
    first_name, 
    last_name, 
    salary, 
    salary * 12 AS annual_salary
FROM employees;

-- 6.️ WHERE clause: Employees in IT department (ID = 3)
SELECT 
    first_name, 
    last_name, 
    department_id
FROM employees
WHERE department_id = 3;

-- 7.️ WHERE with logical operators: Male employees in Finance earning over 90k
SELECT 
    first_name, 
    last_name, 
    gender, 
    salary, 
    department_id
FROM employees
WHERE gender = 'Male' AND department_id = 2 AND salary > 90000;

-- 8. ORDER BY: List employees by salary (high to low)
SELECT 
    first_name, 
    last_name, 
    salary
FROM employees
ORDER BY salary DESC;

-- 9. ORDER BY multiple columns: By department, then salary (low to high)
SELECT 
    department_id, 
    first_name, 
    last_name, 
    salary
FROM employees
ORDER BY department_id ASC, salary ASC;

-- 🔟 Limit results (Top 5 highest-paid) using ROWNUM
SELECT * 
FROM (
    SELECT 
        employee_id, 
        first_name, 
        last_name, 
        salary 
    FROM employees 
    ORDER BY salary DESC
)
WHERE ROWNUM <= 5;

-- 11. Filter using LIKE: Employees whose first name starts with 'A'
SELECT 
    employee_id, 
    first_name, 
    last_name
FROM employees
WHERE first_name LIKE 'A%';

-- 12. BETWEEN clause: Employees born between 1985 and 1995
SELECT 
    employee_id, 
    first_name, 
    dob
FROM employees
WHERE dob BETWEEN DATE '1985-01-01' AND DATE '1995-12-31';

-- 13. IN clause: Employees in HR or IT
SELECT 
    employee_id, 
    first_name, 
    department_id
FROM employees
WHERE department_id IN (1, 3);

-- 14. NULL check: Employees with no phone number (if applicable)
SELECT 
    employee_id, 
    first_name, 
    phone
FROM employees
WHERE phone IS NULL;

