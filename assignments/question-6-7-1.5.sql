SHOW ALL tables;

DESC address;
DESC car;
DESC claim;
DESC client;

SUMMARIZE address;
SUMMARIZE car;
SUMMARIZE claim;
SUMMARIZE client;

/* 3m-1.1 Coaching - Question 6
 * compute the running total of the `travel_time` column for each `car_id` in the `claim` table. 
 * The resulting table should contain `id, car_id, travel_time, running_total`
 */
SELECT car_id, id, claim_date, travel_time FROM claim ORDER BY car_id, claim_date DESC; 
SELECT 
	car_id, 
	id, 
	claim_date, 
	travel_time, 
	SUM(travel_time) OVER (PARTITION BY car_id ORDER BY id ASC) AS running_total 
FROM claim ORDER BY car_id, id;

/* 3m-1.1 Coaching - Question 7
 * using a Common Table Expression (CTE), write a SQL query to 
 * return a table containing `id, resale_value, car_use` from `car`, 
 * where the car resale value is less than the average resale value for the car use.
 */

-- CTE to return avg resale value for each car type
WITH avg_value AS (
	SELECT car_use, ROUND(AVG(resale_value)) as avg_value_by_use FROM main.car GROUP BY car_use
)
-- contruct the table
SELECT c.id, c.resale_value, c.car_use, a.avg_value_by_use 
FROM main.car c INNER JOIN avg_value a ON c.car_use=a.car_use 
WHERE c.resale_value < a.avg_value_by_use
ORDER BY a.avg_value_by_use - c.resale_value DESC;

