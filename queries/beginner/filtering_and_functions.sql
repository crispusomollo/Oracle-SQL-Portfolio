-- =============================================
-- Module 03: Filtering & Functions
-- File: filtering_and_functions.sql
-- Tables Used: employees, training_logs
-- =============================================

-- =============================================
-- 🎯 Learning Objectives:
-- 1. Filter with LIKE, IN, BETWEEN, IS NULL/NOT NULL
-- 2. Use Oracle SQL string functions: UPPER, LOWER, INITCAP, LENGTH, SUBSTR
-- 3. Use date functions: SYSDATE, MONTHS_BETWEEN, ADD_MONTHS, TRUNC
-- 4. Use numeric functions: ROUND, FLOOR, CEIL
-- 5. Nest functions inside WHERE/SELECT
-- =============================================


-- 1. String Functions: Format employee names in proper case
SELECT 
    INITCAP(first_name) AS formatted_first_name,
    INITCAP(last_name) AS formatted_last_name
FROM employees;

-- 2. UPPER/LOWER: Normalize email addresses
SELECT 
    employee_id,
    email,
    UPPER(email) AS email_upper,
    LOWER(email) AS email_lower
FROM employees;

-- 3. LENGTH and SUBSTR: First 3 letters of last name
SELECT 
    employee_id,
    last_name,
    LENGTH(last_name) AS name_length,
    SUBSTR(last_name, 1, 3) AS short_lastname
FROM employees;

-- 4. Filtering with LIKE: Names containing 'e'
SELECT 
    employee_id,
    first_name,
    last_name
FROM employees
WHERE first_name LIKE '%e%';

-- 5. Filtering with BETWEEN: Salaries in a range
SELECT 
    employee_id,
    first_name,
    salary
FROM employees
WHERE salary BETWEEN 80000 AND 100000;

-- 6. IS NULL and IS NOT NULL
SELECT 
    employee_id,
    phone
FROM employees
WHERE phone IS NOT NULL;

-- 7. Date Functions: Calculate employee age
SELECT 
    first_name,
    dob,
    TRUNC(MONTHS_BETWEEN(SYSDATE, dob) / 12) AS age_years
FROM employees;

-- 8. Add months to hire date (next review date)
SELECT 
    employee_id,
    hire_date,
    ADD_MONTHS(hire_date, 12) AS next_review
FROM employees;

-- 9. TRUNC and SYSDATE: Show current date without time
SELECT 
    SYSDATE AS current_datetime,
    TRUNC(SYSDATE) AS current_date_only
FROM dual;

-- 🔟 Numeric functions: Round salaries
SELECT 
    employee_id,
    salary,
    ROUND(salary, -3) AS rounded_salary,
    FLOOR(salary) AS floor_salary,
    CEIL(salary) AS ceil_salary
FROM employees;

-- 11. Combine filtering and functions: Employees with long names and high pay
SELECT 
    first_name,
    last_name,
    LENGTH(first_name || last_name) AS name_length,
    salary
FROM employees
WHERE LENGTH(first_name || last_name) > 12 AND salary > 90000;
