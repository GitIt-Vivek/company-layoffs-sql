<!-- PROJECT LOGO -->
<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/0/0a/MySQL_textlogo.svg" alt="Logo" width="220">
</p>

<h1 align="center">📊 Company Layoffs SQL Project</h1>
<h3 align="center">Data Cleaning + Exploratory Data Analysis (EDA) using MySQL</h3>

<p align="center">
A complete SQL workflow to clean, prepare, and analyze global company layoff data.
</p>

---

# 🏷️ Badges

<p align="left">
  <img src="https://img.shields.io/badge/SQL-MySQL-blue?logo=mysql&logoColor=white" />
  <img src="https://img.shields.io/badge/Analysis-EDA-green" />
  <img src="https://img.shields.io/badge/Version-0.1.0-orange" />
  <img src="https://img.shields.io/badge/Made%20With-SQL-lightgrey" />
</p>

---

# 📚 Table of Contents

- [1. Project Overview](#1-project-overview)
- [2. Database Setup](#2-database-setup)
- [3. Data Cleaning Steps](#3-data-cleaning-steps)
- [4. Exploratory Data Analysis](#4-exploratory-data-analysis)
- [5. Insights](#5-insights)
- [6. Files in Repository](#6-files-in-repository)
- [7. Tech Stack](#7-tech-stack)
- [8. Key Learnings](#8-key-learnings)
- [9. Future Enhancements](#9-future-enhancements)

---

# 1. Project Overview

This project performs end-to-end **data cleaning** and **exploratory data analysis (EDA)** on a dataset containing global company layoffs.

The project workflow includes:

- Importing and staging raw data  
- Cleaning and standardizing columns  
- Removing duplicates using window functions  
- Handling null and inconsistent values  
- Converting text fields into proper SQL data types  
- Running analytical queries to uncover insights  

Core SQL concepts applied:

- Window functions  
- Aggregations  
- Pattern cleaning  
- Joins for missing data imputation  
- Staging → cleaned dataset workflow  

---

# 2. Database Setup

Two staging tables are created:

1. **layoffs_staging** — Raw backup copy  
2. **layoffs_staging_2** — Cleaned and deduplicated dataset  

```sql
CREATE TABLE layoffs_staging LIKE layoffs;

INSERT INTO layoffs_staging
SELECT * FROM layoffs;
```

---

# 3. Data Cleaning Steps

## ✔️ Step 1: Remove Duplicates

- Applied `ROW_NUMBER()` partitioned by key attributes  
- Identified duplicate rows  
- Removed rows with `row_num > 1`  

## ✔️ Step 2: Standardize Data

- Trimmed company names  
- Standardized industry values  
- Cleaned inconsistent country names  
- Converted date column to SQL `DATE`  

## ✔️ Step 3: Handle Null Values

- Converted blank fields into `NULL`  
- Filled missing industry values using a self join  
- Removed rows with no meaningful layoff information  

## ✔️ Step 4: Final Dataset Ready

- `layoffs_staging_2` is used for all analysis  

---

# 4. Exploratory Data Analysis

## 1️⃣ Maximum layoffs recorded
```sql
SELECT MAX(total_laid_off)
FROM layoffs_staging_2;
```

## 2️⃣ Companies with 100% layoffs
```sql
SELECT *
FROM layoffs_staging_2
WHERE percentage_laid_off = 1;
```

## 3️⃣ Top 10 largest single layoff events
```sql
SELECT company, total_laid_off
FROM layoffs_staging_2
ORDER BY total_laid_off DESC
LIMIT 10;
```

## 4️⃣ Top 10 companies by total layoffs
```sql
SELECT company, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;
```

## 5️⃣ Countries with the highest total layoffs
```sql
SELECT country, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY country
ORDER BY 2 DESC
LIMIT 10;
```

---

# 5. Insights

- The **United States** leads all countries in total layoffs  
- Several companies laid off **100%** of their workforce  
- Companies like **Katerra** and **Britishvolt** had extremely large single-event layoffs  

---

# 6. Files in Repository

| File | Description |
|------|-------------|
| `data_cleaning.sql` | Full SQL cleaning pipeline |
| `eda.sql` | Exploratory analysis SQL queries |
| `README.md` | Project documentation |

---

# 7. Tech Stack

- **MySQL 8+**  
- **MySQL Workbench / SQL Developer**  
- **GitHub** for version control  

---

# 8. Key Learnings

- How to build a professional SQL cleaning workflow  
- Using window functions for deduplication  
- Standardizing inconsistent text fields  
- Imputing missing values using JOINs  
- Performing structured EDA using SQL  

---

# 9. Future Enhancements

- Add Power BI or Tableau dashboards  
- Write stored procedures for automation  
- Integrate with Python for extended analysis  
- Build a pipeline for real-time data ingestion  

---

