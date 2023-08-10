SELECT * 
FROM ApplicationTrain

-- EXPLORATORY DATA ANALYSIS

-- Check how many rows contain null values in specific columns (CODE_GENDER, CNT_CHILDREN, AMT_INCOME_TOTAL, NAME_EDUCATION_TYPE, DAYS_EMPLOYED, 
-- OCCUPATION_TYPE, ORGANIZATION_TYPE)
SELECT COUNT(*) - COUNT(CODE_GENDER) AS CODE_GENDER, 
		   COUNT(*) - COUNT(CNT_CHILDREN) AS CNT_CHILDREN,
		   COUNT(*) - COUNT(AMT_INCOME_TOTAL) AS AMT_INCOME_TOTAL,
		   COUNT(*) - COUNT(NAME_EDUCATION_TYPE) AS NAME_EDUCATION_TYPE,
		   COUNT(*) - COUNT(DAYS_EMPLOYED) AS DAYS_EMPLOYED,
		   COUNT(*) - COUNT(OCCUPATION_TYPE) AS OCCUPATION_TYPE,
		   COUNT(*) - COUNT(ORGANIZATION_TYPE) AS ORGANIZATION_TYPE
FROM ApplicationTrain

-- Let us locate any outliers in the CNT_CHILDREN, AMT_INCOME_TOTAL, DAYS_EMPLOYED
SELECT CNT_CHILDREN
FROM ApplicationTrain
ORDER BY CNT_CHILDREN DESC

SELECT AMT_INCOME_TOTAL
FROM ApplicationTrain
ORDER BY AMT_INCOME_TOTAL DESC

SELECT DAYS_EMPLOYED
FROM ApplicationTrain
ORDER BY DAYS_EMPLOYED DESC


-- DATA ANALYSIS


-- What is the percentage of each gender?
SELECT CODE_GENDER, ROUND(COUNT(CODE_GENDER)*100.00/(SELECT COUNT(*) FROM ApplicationTrain), 2) AS "Percentage"
FROM ApplicationTrain
GROUP BY CODE_GENDER

-- On average, how many children do all the clients have?
SELECT AVG(CAST(CNT_CHILDREN AS float)) AS Average
FROM ApplicationTrain

-- What is the average income?
SELECT ROUND(AVG(CAST(AMT_INCOME_TOTAL AS float)), 2) AS Average
FROM ApplicationTrain

-- Group the incomes into low, middle and upper classes and count how many clients fall into each category.
SELECT a.Income_Group, COUNT(a.Income_Group) AS Frequency
FROM (SELECT 
		CASE
			WHEN CAST(AMT_INCOME_TOTAL AS float) < 48500.00 THEN 'Lower'
			WHEN CAST(AMT_INCOME_TOTAL AS float) > 145500.00 THEN 'Upper'
			ELSE 'Middle'
		END AS Income_Group
	 FROM ApplicationTrain) AS a
GROUP BY a.Income_Group

-- Which gender has the highest average income?
SELECT CODE_GENDER, ROUND(AVG(CAST(AMT_INCOME_TOTAL AS float)), 2) AS Average_Income
FROM ApplicationTrain
GROUP BY CODE_GENDER
ORDER BY Average_Income DESC

-- Count how many clients fall into each occupation type.
SELECT OCCUPATION_TYPE, ROUND(100.00*COUNT(OCCUPATION_TYPE)/(SELECT COUNT(*) FROM ApplicationTrain), 2) AS "Percentage"
FROM ApplicationTrain
GROUP BY OCCUPATION_TYPE

-- Count how many clients fall into each organization type.
SELECT ORGANIZATION_TYPE, ROUND(100.00*COUNT(ORGANIZATION_TYPE)/(SELECT COUNT(*) FROM ApplicationTrain), 2) AS "Percentage"
FROM ApplicationTrain
GROUP BY ORGANIZATION_TYPE

-- Which occupation type has the highest average income?
SELECT ORGANIZATION_TYPE, ROUND(AVG(CAST(AMT_INCOME_TOTAL AS float)), 2) AS Average_Income
FROM ApplicationTrain
GROUP BY ORGANIZATION_TYPE
ORDER BY Average_Income DESC

-- On average, how many children do the clients in each occupation type have?
SELECT OCCUPATION_TYPE, ROUND(AVG(CAST(CNT_CHILDREN AS float)), 0) AS Average_Children
FROM ApplicationTrain
WHERE OCCUPATION_TYPE IS NOT NULL
GROUP BY OCCUPATION_TYPE
ORDER BY Average_Children DESC

-- Get a percentage of clients that are in the upper income class for each occupation type and organization type.
SELECT OCCUPATION_TYPE, ROUND(100.00*COUNT(OCCUPATION_TYPE)/(SELECT COUNT(*) FROM ApplicationTrain), 2) AS "Percentage"
FROM ApplicationTrain
WHERE CAST(AMT_INCOME_TOTAL AS FLOAT) > 145500.00
GROUP BY OCCUPATION_TYPE

