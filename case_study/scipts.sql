/* Create Schema & Table using csv */
CREATE SCHEMA IF NOT EXISTS bysql;

CREATE TABLE IF NOT EXISTS bysql.vgsales AS
SELECT * FROM read_csv_auto('S:\module1\3m-data-assignment-1.1\case_study\data\vgsales.csv', 
                   nullstr=['N/A', 'NA', 'n/a']);

/* Check table */
SUMMARIZE bysql.vgsales;
SELECT * from bysql.vgsales;

/* How can game developers and publishers optimize their strategy to maximize global sales 
 * by understanding the performance of different game genres, platforms, and publishers?
 */
-- Which genres contribute the most to global sales?
SELECT Genre, SUM(Global_Sales) AS Total_Global_Sales FROM bysql.vgsales GROUP BY Genre ORDER BY Total_Global_Sales DESC;

-- Which platforms generate the highest global sales?
SELECT Platform, SUM(Global_Sales) AS Total_Global_Sales FROM bysql.vgsales GROUP BY Platform ORDER BY Total_Global_Sales DESC;

-- Which publishers are the most successful in terms of global sales? - just look at those with > 10m total global sales
SELECT Publisher, SUM(Global_Sales) AS Total_Global_Sales 
FROM bysql.vgsales 
GROUP BY Publisher HAVING Total_Global_Sales > 10 
ORDER BY Total_Global_Sales DESC;


-- How does success vary across regions (North America, Europe, Japan, Others)?
WITH 
	sales AS (
	  SELECT
	    ROUND(SUM(NA_Sales),2) AS na,
	    ROUND(SUM(EU_Sales),2) AS eu,
	    ROUND(SUM(JP_Sales),2) AS jp,
	    ROUND(SUM(Other_Sales),2) AS oth,
	    ROUND(SUM(Global_Sales),2) AS global
	  FROM bysql.vgsales
	),
	pct_of_global AS (
	  SELECT
	    ROUND(na/global*100,1) AS na,
	    ROUND(eu/global*100,1) AS eu,
	    ROUND(jp/global*100,1) AS jp,
	    ROUND(oth/global*100,1) AS oth
	  FROM sales
	)
SELECT 'Sales' AS attributes, na AS North_America, eu AS Europe, jp AS Japan, oth as Others FROM sales UNION ALL 
SELECT '% over Global' AS attributes, na AS North_America, eu AS Europe, jp AS Japan, oth as Others FROM pct_of_global;


-- What are the trends over time in game sales by genre and platform?
SELECT Year, Genre, ROUND(SUM(Global_Sales), 2) AS total_global_sales
FROM bysql.vgsales
WHERE Year IS NOT NULL
GROUP BY Year, Genre
ORDER BY Year, total_global_sales DESC;

SELECT Year, Platform, ROUND(SUM(Global_Sales), 2) AS total_global_sales
FROM bysql.vgsales
WHERE Year IS NOT NULL
GROUP BY Year, Platform
ORDER BY Year, total_global_sales DESC;


----------------------------
  SELECT
    Genre,
    Platform,
    SUM(Global_Sales) AS total_sales
  FROM bysql.vgsales
  GROUP BY Genre, Platform order by Genre, Platform;
  
  SELECT
  Genre, Platform, total_sales, pct_of_genre, rn
FROM ranked
WHERE rn <= 3
ORDER BY Genre, rn;