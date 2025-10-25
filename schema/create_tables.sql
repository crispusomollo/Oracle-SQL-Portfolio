-- Drop tables if exist (in reverse order of dependencies)
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE user_accounts CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE system_logs CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE inventory CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE procurement CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE expenses CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE budget CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE payroll CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE training_logs CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE employees CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE departments CASCADE CONSTRAINTS';
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

-- Departments
CREATE TABLE departments (
    department_id      NUMBER PRIMARY KEY,
    department_name    VARCHAR2(100) NOT NULL,
    manager_id         NUMBER
);

-- Employees
CREATE TABLE employees (
    employee_id        NUMBER PRIMARY KEY,
    first_name         VARCHAR2(50),
    last_name          VARCHAR2(50),
    dob                DATE,
    gender             VARCHAR2(10),
    email              VARCHAR2(100),
    phone              VARCHAR2(20),
    hire_date          DATE,
    department_id      NUMBER,
    salary             NUMBER(10,2),
    job_title          VARCHAR2(100),
    CONSTRAINT fk_emp_department
      FOREIGN KEY (department_id)
      REFERENCES departments(department_id)
);

-- Training Logs (Managed by IT, for HR)
CREATE TABLE training_logs (
    training_id        NUMBER PRIMARY KEY,
    employee_id        NUMBER,
    training_title     VARCHAR2(100),
    trainer            VARCHAR2(100),
    start_date         DATE,
    end_date           DATE,
    location           VARCHAR2(100),
    conducted_by       NUMBER, -- from IT department (employee_id)
    CONSTRAINT fk_training_employee
      FOREIGN KEY (employee_id)
      REFERENCES employees(employee_id),
    CONSTRAINT fk_training_conductor
      FOREIGN KEY (conducted_by)
      REFERENCES employees(employee_id)
);

-- Payroll
CREATE TABLE payroll (
    payroll_id         NUMBER PRIMARY KEY,
    employee_id        NUMBER,
    salary             NUMBER(10,2),
    bonuses            NUMBER(10,2),
    deductions         NUMBER(10,2),
    pay_period         VARCHAR2(20),
    approved_by        NUMBER, -- employee from Finance
    CONSTRAINT fk_payroll_employee
      FOREIGN KEY (employee_id)
      REFERENCES employees(employee_id),
    CONSTRAINT fk_payroll_approver
      FOREIGN KEY (approved_by)
      REFERENCES employees(employee_id)
);

-- Budget
CREATE TABLE budget (
    budget_id          NUMBER PRIMARY KEY,
    fiscal_year        VARCHAR2(10),
    department_id      NUMBER,
    amount_allocated   NUMBER(12,2),
    amount_used        NUMBER(12,2),
    budget_status      VARCHAR2(20),
    CONSTRAINT fk_budget_department
      FOREIGN KEY (department_id)
      REFERENCES departments(department_id)
);

-- Expenses
CREATE TABLE expenses (
    expense_id         NUMBER PRIMARY KEY,
    description        VARCHAR2(200),
    amount             NUMBER(10,2),
    expense_date       DATE,
    department_id      NUMBER,
    approved_by        NUMBER,
    CONSTRAINT fk_expense_department
      FOREIGN KEY (department_id)
      REFERENCES departments(department_id),
    CONSTRAINT fk_expense_approver
      FOREIGN KEY (approved_by)
      REFERENCES employees(employee_id)
);

-- Procurement
CREATE TABLE procurement (
    procurement_id     NUMBER PRIMARY KEY,
    item_name          VARCHAR2(100),
    quantity           NUMBER,
    cost               NUMBER(10,2),
    purchased_for_dept NUMBER,
    requester_id       NUMBER, -- usually from IT
    CONSTRAINT fk_procurement_dept
      FOREIGN KEY (purchased_for_dept)
      REFERENCES departments(department_id),
    CONSTRAINT fk_procurement_requester
      FOREIGN KEY (requester_id)
      REFERENCES employees(employee_id)
);

-- Inventory
CREATE TABLE inventory (
    item_id            NUMBER PRIMARY KEY,
    item_name          VARCHAR2(100),
    category           VARCHAR2(50),
    quantity           NUMBER,
    purchase_date      DATE,
    department_id      NUMBER,
    procured_by        NUMBER, -- employee
    CONSTRAINT fk_inventory_dept
      FOREIGN KEY (department_id)
      REFERENCES departments(department_id),
    CONSTRAINT fk_inventory_procured_by
      FOREIGN KEY (procured_by)
      REFERENCES employees(employee_id)
);

-- System Logs
CREATE TABLE system_logs (
    log_id             NUMBER PRIMARY KEY,
    system_name        VARCHAR2(100),
    issue_reported     VARCHAR2(200),
    resolved_by        NUMBER,
    resolution_time    INTERVAL DAY TO SECOND,
    reported_date      DATE,
    CONSTRAINT fk_system_resolver
      FOREIGN KEY (resolved_by)
      REFERENCES employees(employee_id)
);

-- User Accounts
CREATE TABLE user_accounts (
    user_id            NUMBER PRIMARY KEY,
    employee_id        NUMBER,
    username           VARCHAR2(50),
    role               VARCHAR2(50),
    status             VARCHAR2(20),
    created_on         DATE,
    CONSTRAINT fk_user_account_employee
      FOREIGN KEY (employee_id)
      REFERENCES employees(employee_id)
);

