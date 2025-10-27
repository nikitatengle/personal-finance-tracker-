-- =============================
--  Personal Finance Tracker
--  File: sample_data.sql
--  Description: Sample user, category, income, and expense data
-- =============================

USE personal_finance;

-- Insert sample user
INSERT INTO users (name, email, currency) VALUES
('Riya Sharma', 'riya@example.com', 'INR');

-- Insert categories (income + expense)
INSERT INTO categories (name, type) VALUES
('Salary', 'income'),
('Freelancing', 'income'),
('Interest', 'income'),
('Groceries', 'expense'),
('Rent', 'expense'),
('Utilities', 'expense'),
('Entertainment', 'expense'),
('Transport', 'expense');

-- Insert sample incomes for user_id = 1
INSERT INTO income (user_id, category_id, amount, income_date, description) VALUES
(1, 1, 50000.00, '2025-09-01', 'September Salary'),
(1, 2, 7500.00, '2025-09-10', 'Freelance Project'),
(1, 3, 300.00, '2025-09-15', 'Bank Interest'),
(1, 1, 50000.00, '2025-10-01', 'October Salary'),
(1, 2, 8000.00, '2025-10-12', 'Freelance Work'),
(1, 3, 250.00, '2025-10-18', 'Savings Interest');

-- Insert sample expenses for user_id = 1
INSERT INTO expenses (user_id, category_id, amount, expense_date, description) VALUES
(1, 4, 4000.00, '2025-09-05', 'Groceries shopping'),
(1, 5, 15000.00, '2025-09-06', 'Monthly rent'),
(1, 6, 2800.00, '2025-09-08', 'Electricity + water bill'),
(1, 7, 1200.00, '2025-09-15', 'Movie & Dinner'),
(1, 8, 900.00, '2025-09-20', 'Local transport'),
(1, 4, 4200.00, '2025-10-06', 'Groceries'),
(1, 5, 15000.00, '2025-10-07', 'Monthly rent'),
(1, 6, 3100.00, '2025-10-09', 'Utilities'),
(1, 7, 1800.00, '2025-10-16', 'Friends outing'),
(1, 8, 1000.00, '2025-10-22', 'Transport pass');
