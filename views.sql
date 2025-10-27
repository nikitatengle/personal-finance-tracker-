-- =============================
--  Personal Finance Tracker
--  File: views.sql
--  Description: Useful database views for reporting
-- =============================

USE personal_finance;

-- View 1: Monthly total income
CREATE OR REPLACE VIEW view_monthly_income AS
SELECT user_id, DATE_FORMAT(income_date, '%Y-%m') AS month, SUM(amount) AS total_income
FROM income
GROUP BY user_id, month;

-- View 2: Monthly total expense
CREATE OR REPLACE VIEW view_monthly_expense AS
SELECT user_id, DATE_FORMAT(expense_date, '%Y-%m') AS month, SUM(amount) AS total_expense
FROM expenses
GROUP BY user_id, month;

-- View 3: Monthly summary (income, expense, balance)
CREATE OR REPLACE VIEW view_monthly_summary AS
SELECT 
  COALESCE(i.user_id, e.user_id) AS user_id,
  COALESCE(i.month, e.month) AS month,
  COALESCE(i.total_income, 0) AS total_income,
  COALESCE(e.total_expense, 0) AS total_expense,
  COALESCE(i.total_income, 0) - COALESCE(e.total_expense, 0) AS balance
FROM view_monthly_income i
LEFT JOIN view_monthly_expense e 
  ON i.user_id = e.user_id AND i.month = e.month
UNION
SELECT 
  e.user_id, e.month, 0 AS total_income, e.total_expense, -e.total_expense AS balance
FROM view_monthly_expense e
WHERE NOT EXISTS (
  SELECT 1 FROM view_monthly_income i 
  WHERE i.user_id = e.user_id AND i.month = e.month
);

-- View 4: Category-wise spending summary
CREATE OR REPLACE VIEW view_category_spending AS
SELECT e.user_id, c.name AS category, SUM(e.amount) AS total_spent
FROM expenses e
JOIN categories c ON e.category_id = c.category_id
GROUP BY e.user_id, c.name;
