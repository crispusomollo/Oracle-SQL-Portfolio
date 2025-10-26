# Oracle SQL Learning Portfolio

![Oracle Logo](https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Oracle_logo.svg/320px-Oracle_logo.svg.png)

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![SQL](https://img.shields.io/badge/Language-Oracle%20SQL-orange)](https://www.oracle.com/database/technologies/sql.html)
[![Last Commit](https://img.shields.io/github/last-commit/crispusomollo/oracle-sql-portfolio)](https://github.com/crispusomollo/oracle-sql-portfolio/commits/main)
[![Issues](https://img.shields.io/github/issues/crispusomollo/oracle-sql-portfolio)](https://github.com/crispusomollo/oracle-sql-portfolio/issues)

---

## 📑 Table of Contents

- [Overview](#-overview)
- [Project Structure](#-project-structure)
- [Learning Modules](#-learning-modules)
- [Business Scenarios Highlights](#-business-scenarios-highlights)
  - [HR + Finance + IT](#-hr--finance--it)
  - [Sales Department (NEW)](#-sales-department-new)
- [Getting Started](#-getting-started)
- [Example Output](#-example-output)
- [Future Enhancements](#-future-enhancements)
- [Contributions](#-contributions)
- [License](#-license)
- [About](#-about)

---

## 🚀 Overview

This project is a **hands-on Oracle SQL learning portfolio**, progressing from fundamentals to professional-level reporting using real-world business scenarios.

It uses **Oracle Linux 23 AI Free** and **Oracle SQL Developer** for all examples, with dummy data across departments like **HR, Finance, IT**, and now **Sales**.

> ✅ This repo is designed to showcase my **query-building**, **reporting**, and **business analysis** skills using SQL.

---

## 🗂️ Project Structure
```
oracle-sql-portfolio/
├── queries/
│   └── real_world/
│       └── business_scenarios.sql    # Main SQL scenario bundle
├── docs/
│   └── business_scenarios_summary.md # Detailed learning notes and explanations
├── dummy_data/
│   ├── hr_finance_it_data.sql        # Core departments
│   └── sales_data.sql                # NEW: Sales department data
├── README.md                         # You're here!
└── LICENSE
```
---

## 📚 Learning Modules

| Module | Title                            | Description                                                                 |
|--------|----------------------------------|-----------------------------------------------------------------------------|
| 01     | SQL Foundation                   | SELECT, WHERE, ORDER BY, basic filtering and expressions                    |
| 02     | Joins & Set Operations           | INNER, LEFT, RIGHT, FULL, UNION, INTERSECT                                 |
| 03     | Aggregation & Grouping           | GROUP BY, HAVING, COUNT, SUM, AVG                                           |
| 04     | Subqueries & CTEs                | Nested queries, WITH clause, modular SQL                                    |
| 05     | Analytical Functions             | RANK, DENSE_RANK, LEAD/LAG, PARTITION BY                                   |
| 06     | HR + Finance + IT Scenarios      | Payroll variance, training impact, budget tracking                          |
| 07     | Real-World Sales Analytics 💼    | Sales revenue vs budget, commissions, inventory correlation (NEW!)          |
| 08     | Dashboard Queries & Reports 📊   | KPI summaries, cross-department reports (Coming Soon)                       |

---

## 🔎 Business Scenarios Highlights

Explore realistic use cases powered by SQL:

### HR + Finance + IT

- Payroll vs Budget Variance  
- Inventory Cost Allocation  
- Training Completion Rates by Department  
- Budget Forecasting  
- System Downtime Impact on Payroll  
- Training ROI on Compensation

### Sales Department (NEW)

- 💰 **Sales Revenue vs Budget Performance**  
- 💼 **Commission Impact on Payroll**  
- 📦 **Sales and Inventory Correlation**

📖 Read all scenario summaries and explanations in  
[`docs/business_scenarios_summary.md`](docs/business_scenarios_summary.md)

🧠 Run the SQL directly from  
[`queries/real_world/business_scenarios.sql`](queries/real_world/business_scenarios.sql)

---

## 🧪 Getting Started

### 1. **Clone the Repo**  
   ```bash
   git clone https://github.com/crispusomollo/oracle-sql-portfolio.git
   cd oracle-sql-portfolio
```

### 2. Set up your Oracle DB Environment

- Use Oracle Linux 23 AI Free

- Install Oracle SQL Developer

- Create a user/schema for your learning environment

### 3. Load Dummy Data
```sql
-- Load core data
@dummy_data/hr_finance_it_data.sql

-- Load sales data (NEW)
@dummy_data/sales_data.sql
```

### 4. Start Exploring Queries
Open queries/real_world/business_scenarios.sql in SQL Developer and start executing!

---

## 📌 Future Enhancements

- Add KPI dashboard queries (Module 08)

- Generate ER diagram and include in docs

- Create demo GIF/video

- Integrate SQL linting and formatting

---

## 🤝 Contributions

Contributions are welcome! Feel free to:

- Fork this repo and customize for your own learning

- Submit PRs for additional use cases

- Open issues with questions or feedback

---

## 📜 License

This project is licensed under the MIT License.

---

## 🙋‍♂️ About

Maintained by Crispus Omollo
Proudly built with real SQL and even realer scenarios.

