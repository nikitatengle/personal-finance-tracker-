-- =============================
--  Personal Finance Tracker
--  File: queries.sql
--  Description: Common queries for analysis and reporting
-- =============================

USE personal_finance;

-- 1️⃣ Show all users
SELECT * FROM users;

-- 2️⃣ Show all categories
SELECT * FROM categories;

-- 3️⃣ List all income and expenses (combined)
SELECT 'Income' AS type, i.income_date AS date, c.name AS category, i.amount, i.description
FROM income i
JOIN categories c ON i.category_id = c.category_id
UNION ALL
SELECT 'Expense' AS type, e.expense_date AS date, c.name AS category, e.amount, e.description
FROM expenses e
JOIN categories c ON e.category_id = c.category_id
ORDER BY date;

-- 4️⃣ Total monthly income (using DATE_FORMAT)
SELECT DATE_FORMAT(income_date, '%Y-%m') AS month, SUM(amount) AS total_income
FROM income
WHERE user_id = 1
GROUP BY month
ORDER BY month;

-- 5️⃣ Total monthly expenses
SELECT DATE_FORMAT(expense_date, '%Y-%m') AS month, SUM(amount) AS total_expense
FROM expenses
WHERE user_id = 1
GROUP BY month
ORDER BY month;

-- 6️⃣ Category-wise spending
SELECT c.name AS category, SUM(e.amount) AS total_spent
FROM expenses e
JOIN categories c ON e.category_id = c.category_id
WHERE e.user_id = 1
GROUP BY c.name
ORDER BY total_spent DESC;

-- 7️⃣ Monthly net balance (Income - Expense)
SELECT 
  m.month,
  COALESCE(i.total_income, 0) AS total_income,
  COALESCE(e.total_expense, 0) AS total_expense,
  COALESCE(i.total_income, 0) - COALESCE(e.total_expense, 0) AS net_balance
FROM (
  SELECT DATE_FORMAT(income_date, '%Y-%m') AS month FROM income
  UNION
  SELECT DATE_FORMAT(expense_date, '%Y-%m') AS month FROM expenses
) AS m
LEFT JOIN (
  SELECT DATE_FORMAT(income_date, '%Y-%m') AS month, SUM(amount) AS total_income
  FROM income
  WHERE user_id = 1 GROUP BY month
) i ON m.month = i.month
LEFT JOIN (
  SELECT DATE_FORMAT(expense_date, '%Y-%m') AS month, SUM(amount) AS total_expense
  FROM expenses
  WHERE user_id = 1 GROUP BY month
) e ON m.month = e.month
ORDER BY m.month;

-- 8️⃣ Top 3 highest expense categories
SELECT c.name AS category, SUM(e.amount) AS total_spent
FROM expenses e
JOIN categories c ON e.category_id = c.category_id
WHERE e.user_id = 1
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 3;

-- 9️⃣ All transactions for a specific month (example: October 2025)
SELECT 'Income' AS type, i.income_date AS date, c.name AS category, i.amount, i.description
FROM income i
JOIN categories c ON i.category_id = c.category_id
WHERE MONTH(i.income_date) = 10
UNION ALL
SELECT 'Expense' AS type, e.expense_date AS date, c.name AS category, e.amount, e.description
FROM expenses e
JOIN categories c ON e.category_id = c.category_id
WHERE MONTH(e.expense_date) = 10
ORDER BY date;
