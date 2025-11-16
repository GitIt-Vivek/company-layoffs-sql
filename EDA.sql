SELECT * from layoffs_staging_2;

SELECT MAX(total_laid_off)
FROM layoffs_staging_2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging_2;

SELECT *
FROM layoffs_staging_2
WHERE percentage_laid_off = 1;

SELECT *
FROM layoffs_staging_2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions desc;
-- We can see Brititshvolt being the highest, it seems like an EV company
-- Quibi - Looks like it raised enough funding, despite this, it failed due to failure to attract traction

SELECT *
FROM layoffs_staging_2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;
-- As we can see, company named katerra laid off many people

-- The top 10 companies with the most single layoffs
SELECT company, total_laid_off
FROM layoffs_staging_2
ORDER BY 2 DESC 
LIMIT 10;

-- The top 10 companies with the most total layoffs
SELECT company, sum(total_laid_off)
FROM layoffs_staging_2
GROUP BY company
ORDER BY 2 DESC 
LIMIT 10;

-- The top countries having most total layoffs with respect to each country
SELECT country, sum(total_laid_off)
FROM layoffs_staging_2
GROUP BY country
ORDER BY 2 DESC 
LIMIT 10;
-- Here , we see that US ranks the highest in total layoffs, followed by India, Netherlands and so on.


