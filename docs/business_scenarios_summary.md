# Business Scenarios Summary

This document provides an overview of six real-world business scenarios implemented with Oracle SQL. Each scenario demonstrates key SQL concepts and addresses practical business questions involving HR, Finance, and IT departments.

---

## Scenario 1: Payroll vs Budget Variance

**Business Context:**  
Compare payroll expenses against allocated budgets per department to monitor financial health and spending efficiency.

**Key SQL Concepts:**  
- JOINs (INNER, LEFT)  
- Aggregation (`SUM`) and `GROUP BY`  
- Handling nulls with `NVL`  
- Conditional logic with `CASE`  
- Ordering results for actionable insights

**Learning Outcome:**  
Understand how to combine multiple data sources and aggregate financial data for budget tracking and variance analysis.

---

## Scenario 2: Inventory Cost Allocation

**Business Context:**  
Calculate inventory costs allocated to IT and Finance departments by category, aiding in cost control and budgeting.

**Key SQL Concepts:**  
- Filtering with `WHERE`  
- Aggregation and grouping by multiple columns  
- Calculations within queries (multiplying unit cost and quantity)  
- Sorting to identify top cost drivers

**Learning Outcome:**  
Learn to perform cost analysis by grouping and filtering on relevant departments and categories.

---

## Scenario 3: Employee Training Impact on Payroll

**Business Context:**  
Analyze whether employees attending training programs have salary increases or bonuses post-training.

**Key SQL Concepts:**  
- Common Table Expressions (CTEs) with `WITH` clause  
- Using `DISTINCT` to avoid duplicates  
- Combining multiple data sets with `LEFT JOIN`  
- Handling missing data using `COALESCE`

**Learning Outcome:**  
Develop modular queries to correlate employee training participation with payroll changes, assessing training ROI.

---

## Scenario 4: Budget Utilization Forecast

**Business Context:**  
Forecast next quarter’s payroll budget utilization based on historical monthly expense trends.

**Key SQL Concepts:**  
- Multiple CTEs for stepwise data transformation  
- Date functions (`TO_CHAR`, `TO_DATE`)  
- Averages and projections using aggregate functions  
- Joining budget data for comparative analysis

**Learning Outcome:**  
Understand basic forecasting techniques and how to blend historical and budget data for future planning.

---

## Scenario 5: System Downtime Impact on Payroll Processing

**Business Context:**  
Identify if IT system downtime correlates with delays or issues in payroll processing.

**Key SQL Concepts:**  
- Joining disparate data sets (payroll and downtime logs)  
- Conditional aggregation  
- Use of `CASE` to flag potential impacts  
- Time-based grouping and ordering

**Learning Outcome:**  
Learn to detect operational bottlenecks by correlating event logs with business process data.

---

## Scenario 6: Training Completion Rates by Department

**Business Context:**  
Measure training completion percentages across departments to pinpoint lagging teams and plan interventions.

**Key SQL Concepts:**  
- Aggregation with counts and percentages  
- Combining total and subset counts via CTEs  
- Handling missing data with `NVL`  
- Sorting by computed metrics for prioritization

**Learning Outcome:**  
Gain skills in employee development tracking and department-level analytics.

---

# Summary

This set of scenarios covers foundational to advanced Oracle SQL skills, including complex joins, CTEs, aggregation, filtering, and reporting logic. It reflects real-world data collaboration across HR, Finance, and IT departments, providing a strong portfolio demonstrating both technical and business analytical capabilities.

---

*For full SQL code, see `queries/real_world/business_scenarios.sql`.*

