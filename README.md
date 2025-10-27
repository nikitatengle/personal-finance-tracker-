Project Overview
The Personal Finance Tracker is a SQL-based mini project developed using **MySQL** and **Visual Studio Code (VS Code)**.  
It helps users record, organize, and analyze their income and expenses efficiently.  
This project demonstrates fundamental database management concepts such as schema design, data insertion, and analytical SQL queries for monthly financial summaries.

Run files in order:
schema.sql → Creates database & tables
sample_data.sql → Inserts sample data
views.sql → Creates report views
queries.sql → Runs analysis queries

Check data and views:
USE personal_finance;
SHOW TABLES;
SELECT * FROM view_monthly_summary;
