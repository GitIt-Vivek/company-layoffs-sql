# 📊 Company Layoffs SQL Project  
### *Data Cleaning + Exploratory Data Analysis (EDA) using MySQL*

This project performs **end-to-end data cleaning** and **exploratory data analysis** on a dataset containing global company layoffs.  
All work is done using **MySQL**, following industry-standard methods for data preprocessing and analytics.

---

## 🧹 1. Project Overview

The goal of this project is to:
📊 Company Layoffs SQL Project
Data Cleaning + Exploratory Data Analysis (EDA) using MySQL

This project performs end-to-end data cleaning and exploratory data analysis on a dataset containing global company layoffs.
All work is done using MySQL, following industry-standard data cleaning methods and analytical best-practices.

🧹 1. Project Overview

The goal of this project is to:

Import raw layoffs data

Create a safe staging table

Clean, standardize, and structure the dataset

Remove duplicates

Handle null values

Fix inconsistencies in industry and country fields

Convert data types

Perform exploratory data analysis (EDA) to uncover insights about layoffs across companies, industries, and countries.

This project demonstrates SQL proficiency in:

Window Functions

CTEs

Aggregations

Date cleaning

JOIN-based updating

Data preprocessing workflows

🏗️ 2. Database Setup

A staging table layoffs_staging is created to protect raw data.
A second staging table layoffs_staging_2 is built to attach row numbers and safely remove duplicates.

CREATE TABLE layoffs_staging LIKE layoffs;

INSERT INTO layoffs_staging
SELECT * FROM layoffs;

🧼 3. Data Cleaning Steps
✔️ Step 1: Remove Duplicates

Used ROW_NUMBER() window function partitioned by all relevant columns.

Identified duplicate rows.

Created layoffs_staging_2 and removed rows where row_num > 1.

✔️ Step 2: Standardize Data

Trimmed extra spaces from company names.

Standardized industry values (Crypto, etc.)

Cleaned country names (United States vs United States of America)

Converted date column from text to proper DATE type.

✔️ Step 3: Handle Null Values

Replaced blank industries with NULL.

Filled missing industries by joining on company name (e.g., Airbnb).

Removed rows where both total_laid_off AND percentage_laid_off were NULL.

✔️ Step 4: Final Table Ready

layoffs_staging_2 becomes the cleaned dataset used for EDA.

🔍 4. Exploratory Data Analysis (EDA)
📌 Key Questions Explored
1. Maximum layoffs recorded
SELECT MAX(total_laid_off) FROM layoffs_staging_2;

2. Companies with 100% layoffs
SELECT * 
FROM layoffs_staging_2
WHERE percentage_laid_off = 1;

3. Top 10 companies by single largest layoff event
SELECT company, total_laid_off
FROM layoffs_staging_2
ORDER BY total_laid_off DESC
LIMIT 10;

4. Top 10 companies by total layoffs
SELECT company, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;

5. Countries with the highest total layoffs
SELECT country, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY country
ORDER BY 2 DESC
LIMIT 10;

📈 Insights Found

The United States had the highest total layoffs among all countries.

Some companies laid off 100% of their workforce.

Companies like Katerra, Britishvolt, and others show unusually large single-event layoffs.

📂 5. Files in Repository
File	Description
data_cleaning.sql	Complete SQL workflow for cleaning and preparing the dataset
eda.sql	SQL scripts used for exploratory data analysis
README.md	Project overview, documentation, and insights
🛠️ 6. Tech Stack

MySQL (window functions, joins, data types, cleaning)

SQL Developer / MySQL Workbench (optional)

GitHub for version control

🚀 7. Key Learnings

How to professionally clean a dataset using SQL

Window functions for duplicates handling

Standardizing messy fields (industry, country, date)

Using JOIN to backfill missing values

Performing effective EDA to extract insights

🙌 8. Future Enhancements

Build visual dashboards using Power BI or Tableau

Write stored procedures for automated cleaning

Deploy this project into a real-time analytics pipeline
