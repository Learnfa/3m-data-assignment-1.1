DESC resale_flat_prices_2017;
SELECT * FROM resale_flat_prices_2017 LIMIT 20;

/* 3m-1.1 Coaching - Question 4
 categorize flats into price ranges and count how many flats fall into each category:
- Under $400,000: 'Budget'
- $400,000 to $700,000: 'Mid-Range'
- Above $700,000: 'Premium'
  Show the counts in descending order.
*/

SELECT
	CASE
		WHEN rf.resale_price < 400000 THEN 'Budget'
		WHEN rf.resale_price BETWEEN 400000 AND 700000 THEN 'Mid-Range'
		WHEN rf.resale_price > 700000 THEN 'Premium'
	END AS price_cat,
	COUNT (*) as total_units
FROM main.resale_flat_prices_2017 rf
GROUP BY price_cat
ORDER BY total_units DESC;

/* 3m-1.1 Coaching - Question 5
	select the minimum and maximum price of flats sold in each town during the first quarter of 2017 (January to March).
*/

SELECT town, MAX(resale_price) AS max_resale_price, MIN(resale_price) AS min_resale_price, transaction_date FROM main.resale_flat_prices_2017 WHERE transaction_date BETWEEN '2017-01-01' AND '2017-03-01' GROUP BY town ORDER BY transaction_date DESC;