WITH t0 AS (
SELECT * 
FROM SuperStoreSales_Whole
WHERE YEAR(Order_Date) = 2018
),
-- SELECT * FROM t0
t1 AS (
SELECT
	Order_ID, Order_Date, Customer_ID, Sales, FORMAT(Order_Date, 'yyyy-MM-01') AS Order_Month
FROM
	t0
),
-- SELECT * FROM t1 ORDER BY Customer_ID
t2 AS (
SELECT
	Customer_ID, FORMAT(MIN(Order_Date), 'yyyy-MM-01') AS Cohort_Month
FROM
	t0
GROUP BY Customer_ID
),
-- SELECT * FROM t2
t3 AS (
SELECT
	t1.*, t2.Cohort_Month, DATEDIFF(MONTH, t2.Cohort_Month, t1.Order_Month) + 1 AS Cohort_Index
FROM
	t1
	LEFT JOIN
	t2 ON t1.Customer_ID = t2.Customer_ID
),
-- SELECT * FROM t3 ORDER BY Customer_ID
t4 AS (
SELECT
	Cohort_Month, Cohort_Index, COUNT(DISTINCT Customer_ID) AS Customer_Count
FROM
	t3
GROUP BY Cohort_Month, Cohort_Index
),
t4_2 AS (
SELECT
	Cohort_Month, Cohort_Index, SUM(Sales) AS Total_Sales
FROM
	t3
GROUP BY Cohort_Month, Cohort_Index
),
-- SELECT * FROM t4
t5 AS (
SELECT *
FROM
	t4
	PIVOT(
	SUM(Customer_Count)
	FOR Cohort_Index IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) piv
)
 -- SELECT * FROM t5
SELECT
	Cohort_Month, 
	ROUND(CAST(1.0 * [1] / [1] AS float), 2) [1],
	ROUND(CAST(1.0 * [2] / [1] AS float),2) AS [2],
	ROUND(CAST(1.0 * [3] / [1] AS float), 2) AS [3],
	ROUND(CAST(1.0 * [4] / [1] AS float), 2) AS [4],
	ROUND(CAST(1.0 * [5] / [1] AS float), 2) AS [5],
	ROUND(CAST(1.0 * [6] / [1] AS float), 2) AS [6],
	ROUND(CAST(1.0 * [7] / [1] AS float), 2) AS [7],
	ROUND(CAST(1.0 * [8] / [1] AS float), 2) AS [8],
	ROUND(CAST(1.0 * [9] / [1] AS float), 2) AS [9],
	ROUND(CAST(1.0 * [10] / [1] AS float), 2) AS [10],
	ROUND(CAST(1.0 * [11] / [1] AS float), 2) AS [11],
	ROUND(CAST(1.0 * [12] / [1] AS float), 2) AS [12]
FROM t5;