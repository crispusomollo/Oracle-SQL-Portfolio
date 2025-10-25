-- 👥 Insert into departments

-- Insert departments
INSERT INTO departments (department_id, department_name, manager_id) VALUES (1, 'Human Resources', NULL);
INSERT INTO departments (department_id, department_name, manager_id) VALUES (2, 'Finance', NULL);
INSERT INTO departments (department_id, department_name, manager_id) VALUES (3, 'Information Technology', NULL);
INSERT INTO departments (department_id, department_name, manager_id) VALUES (4, 'Administration', NULL);
INSERT INTO departments (department_id, department_name, manager_id) VALUES (5, 'Operations', NULL);

-- 👤 Insert into employees
-- We’ll create employees with various roles, salaries, and departments. 
-- A few will be assigned as managers (to be updated after insert to avoid FK conflict).

-- Insert employees
INSERT INTO employees (employee_id, first_name, last_name, dob, gender, email, phone, hire_date, department_id, salary, job_title)
VALUES (101, 'Alice', 'Mwangi', DATE '1985-06-15', 'Female', 'alice.mwangi@example.com', '0712345678', DATE '2015-01-10', 1, 120000, 'HR Manager');

INSERT INTO employees (employee_id, first_name, last_name, dob, gender, email, phone, hire_date, department_id, salary, job_title)
VALUES (102, 'Brian', 'Odhiambo', DATE '1990-03-20', 'Male', 'brian.odhiambo@example.com', '0723456789', DATE '2018-06-20', 2, 110000, 'Finance Manager');

INSERT INTO employees (employee_id, first_name, last_name, dob, gender, email, phone, hire_date, department_id, salary, job_title)
VALUES (103, 'Cynthia', 'Kimani', DATE '1992-11-10', 'Female', 'cynthia.kimani@example.com', '0734567890', DATE '2019-03-15', 3, 130000, 'IT Manager');

-- HR Staff
INSERT INTO employees VALUES (104, 'David', 'Njenga', DATE '1995-07-07', 'Male', 'david.njenga@example.com', '0745678901', DATE '2021-08-01', 1, 75000, 'HR Assistant');
INSERT INTO employees VALUES (105, 'Emily', 'Wambui', DATE '1998-04-18', 'Female', 'emily.wambui@example.com', '0756789012', DATE '2022-02-10', 1, 72000, 'Recruitment Officer');

-- Finance Staff
INSERT INTO employees VALUES (106, 'Felix', 'Mutua', DATE '1988-12-03', 'Male', 'felix.mutua@example.com', '0767890123', DATE '2020-09-15', 2, 95000, 'Accountant');
INSERT INTO employees VALUES (107, 'Grace', 'Chebet', DATE '1993-01-25', 'Female', 'grace.chebet@example.com', '0778901234', DATE '2021-04-20', 2, 98000, 'Payroll Officer');

-- IT Staff
INSERT INTO employees VALUES (108, 'Henry', 'Kariuki', DATE '1987-09-09', 'Male', 'henry.kariuki@example.com', '0789012345', DATE '2017-11-30', 3, 100000, 'Systems Analyst');
INSERT INTO employees VALUES (109, 'Irene', 'Mburu', DATE '1991-06-22', 'Female', 'irene.mburu@example.com', '0790123456', DATE '2020-01-12', 3, 105000, 'Network Admin');
INSERT INTO employees VALUES (110, 'James', 'Otieno', DATE '1996-10-05', 'Male', 'james.otieno@example.com', '0701234567', DATE '2023-03-25', 3, 85000, 'IT Support');

-- Admin & Operations
INSERT INTO employees VALUES (111, 'Karen', 'Maina', DATE '1983-02-16', 'Female', 'karen.maina@example.com', '0711122233', DATE '2014-09-01', 4, 90000, 'Admin Officer');
INSERT INTO employees VALUES (112, 'Leon', 'Kibet', DATE '1994-12-28', 'Male', 'leon.kibet@example.com', '0722233344', DATE '2019-12-12', 5, 95000, 'Operations Analyst');

-- Insert training logs
INSERT INTO training_logs (training_id, employee_id, training_title, trainer, start_date, end_date, location, conducted_by)
VALUES (201, 104, 'Workplace Ethics', 'Henry Kariuki', DATE '2023-01-10', DATE '2023-01-12', 'Boardroom A', 108);

INSERT INTO training_logs (training_id, employee_id, training_title, trainer, start_date, end_date, location, conducted_by)
VALUES (202, 105, 'Onboarding and Orientation', 'Irene Mburu', DATE '2023-02-15', DATE '2023-02-16', 'HR Room', 109);

INSERT INTO training_logs (training_id, employee_id, training_title, trainer, start_date, end_date, location, conducted_by)
VALUES (203, 106, 'Finance Systems Security', 'James Otieno', DATE '2023-03-05', DATE '2023-03-06', 'IT Lab', 110);

INSERT INTO training_logs (training_id, employee_id, training_title, trainer, start_date, end_date, location, conducted_by)
VALUES (204, 107, 'Payroll Compliance', 'Brian Odhiambo', DATE '2023-04-01', DATE '2023-04-02', 'Finance Hall', 106);

INSERT INTO training_logs (training_id, employee_id, training_title, trainer, start_date, end_date, location, conducted_by)
VALUES (205, 108, 'Advanced Networking', 'Cynthia Kimani', DATE '2023-05-10', DATE '2023-05-12', 'Data Center', 103);


-- Update department managers
UPDATE departments SET manager_id = 101 WHERE department_id = 1; -- HR
UPDATE departments SET manager_id = 102 WHERE department_id = 2; -- Finance
UPDATE departments SET manager_id = 103 WHERE department_id = 3; -- IT
UPDATE departments SET manager_id = 111 WHERE department_id = 4; -- Admin
UPDATE departments SET manager_id = 112 WHERE department_id = 5; -- Ops
