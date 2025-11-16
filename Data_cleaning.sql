USE company_layoffs;

SELECT * FROM layoffs;

-- first thing we want to do is create a staging table. This is the one we will work in and clean the data. 
-- We want a table with the raw data in case something happens
CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT layoffs_staging
SELECT * FROM layoffs;

SELECT * FROM layoffs;

-- when we are data cleaning we usually follow a few steps
-- 1. check for duplicates and remove any
-- 2. standardize data and fix errors
-- 3. Look at null values and see what 
-- 4. remove any columns and rows that are not necessary - few ways

-- 1. Remove Duplicates

# First let's check for duplicates

SELECT * FROM layoffs_staging;
WITH duplicate_cte as (
select *,
ROW_NUMBER() OVER(PARTITION BY location, industry, total_laid_off, percentage_laid_off,
`date`, country, funds_raised_millions) as rn 
from layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE rn >1;

-- these are the ones we want to delete where the row number is > 1 or 2or greater essentially
-- now we may want to write it like this:
CREATE TABLE `layoffs_staging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging_2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
from layoffs_staging;

SELECT * FROM layoffs_staging_2
WHERE row_num > 1;

DELETE FROM layoffs_staging_2
WHERE row_num > 1;
SELECT * FROM layoffs_staging_2
WHERE row_num > 1;
SELECT * FROM layoffs_staging_2;

-- After deleting the duplicate rows, we then delete the 
ALTER TABLE layoffs_staging_2
DROP COLUMN row_num;

SELECT * FROM layoffs_staging_2;

-- 2. STANDARDIZE DATA

-- trim() - removes extra spaces
SELECT
company,trim(company)
FROM layoffs_staging_2;

UPDATE layoffs_staging_2
SET company = trim(company);

SELECT DISTINCT industry
from layoffs_staging_2
ORDER BY 1;

select *
from layoffs_staging_2
where industry like 'Crypto%';

UPDATE layoffs_staging_2
SET industry = 'Crypto'
WHERE industry like 'Crypto%';

select distinct industry
from layoffs_staging_2
order by 1;

select distinct country
from layoffs_staging_2;

select *
from layoffs_staging_2
where country like "United States%";

UPDATE layoffs_staging_2
SET country = 'United States'
WHERE country like 'United States%';

select distinct country
from layoffs_staging_2
order by 1;

SELECT `DATE`
FROM layoffs_staging_2;

SELECT `DATE`,
str_to_date(`DATE`,'%m/%d/%Y')
FROM layoffs_staging_2;

UPDATE layoffs_staging_2
SET `DATE` = str_to_date(`DATE`,'%m/%d/%Y');

SELECT `DATE`
FROM layoffs_staging_2;

ALTER TABLE layoffs_staging_2
MODIFY COLUMN `DATE` DATE; 

SELECT *
FROM layoffs_staging_2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
from layoffs_staging_2
WHERE industry IS NULL
OR industry = '';

UPDATE layoffs_staging_2
SET industry = NULL
WHERE industry = '';


SELECT *
from layoffs_staging_2
WHERE company = 'Airbnb';
-- There are two airbnb values , one having null industry values,
-- we should populate the null industry with the industry that is in other airbnb ,
-- so as to maintain consistency and removing null.

SELECT *
from layoffs_staging_2 t1
JOIN layoffs_staging_2 t2
	on t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

SELECT t1.industry, t2.industry
from layoffs_staging_2 t1
JOIN layoffs_staging_2 t2
	on t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging_2 t1
JOIN layoffs_staging_2 t2
on t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;


SELECT *
FROM layoffs_staging_2
WHERE total_laid_off is NULL
AND percentage_laid_off IS NULL;


DELETE 
FROM layoffs_staging_2
WHERE total_laid_off is NULL
AND percentage_laid_off IS NULL;

