SELECT * FROM (
  SELECT 'Genre' AS Category, Genre AS 'Genre/Platform/Publisher', ROUND(SUM(Global_Sales),2) AS total_global_sales
  FROM bysql.vgsales GROUP BY Genre ORDER BY total_global_sales DESC LIMIT 10
)
UNION ALL
SELECT * FROM (
  SELECT 'Platform', Platform, ROUND(SUM(Global_Sales),2)
  FROM bysql.vgsales GROUP BY Platform ORDER BY 3 DESC LIMIT 10
)
UNION ALL
SELECT * FROM (
  SELECT 'Publisher', Publisher, ROUND(SUM(Global_Sales),2)
  FROM bysql.vgsales GROUP BY Publisher ORDER BY 3 DESC LIMIT 10
)
ORDER BY 1, 3 DESC;
