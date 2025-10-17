# Assignment

## Instructions

Paste the answer to each question in the answer code section below each question.

### Question 1

Construct an ERD in DBML for a social media company whose database includes information about users, their followers, and the posts that they make. Users can follow multiple users and create multiple posts.

Each entity has the following attributes:

- User: id, username, email, created_at
- Post: id, title, body, user_id, status, created_at
- Follows: following_user_id, followed_user_id, created_at

Answer:

```dbml

// Social Media db

Table users {
  id          int        [pk, increment]
  username    varchar
  email       varchar    [not null, unique]
  created_at  timestamp  [not null, default: `now()`]
}

Table follows {
  following_user_id  int         [not null]
  followed_user_id   int         [not null]
  created_at         timestamp   [not null, default: `now()`]

  Note: 'Self-referential many-to-many: many users follow many other users.'
  Indexes {
    (following_user_id, followed_user_id) [pk] // prevent dup following relationships
  }
}

Table posts {
  id          int        [pk, increment]
  title       varchar    [not null]
  body        text
  user_id     int        [not null]
  status      varchar    [not null, note: 'to use enum', default: `draft`]
  created_at  timestamp  [not null, default: `now()`]
}

// Relationships
// A user has many posts
Ref: users.id < posts.user_id [delete: cascade, update: cascade]

// A user (following_user_id) follows many other users (followed_user_id)
Ref: users.id < follows.following_user_id [delete: cascade, update: cascade]

// A user (followed_user_id) follows by many users (following_user_id)
Ref: users.id < follows.followed_user_id  [delete: cascade, update: cascade]

```
### Question 2

Using the data provided in lession 1.3 ( https://github.com/su-ntu-ctp/5m-data-1.3-sql-basic-ddl/tree/solutions/data ), write the SQL statement to alter the teachers table in the lesson schema to add a new column subject of type VARCHAR.

Answer:

```sql
DESC lesson.teachers
ALTER TABLE lesson.teachers ADD COLUMN subject VARCHAR;
```

### Question 3

Using the data provided in lession 1.3 ( https://github.com/su-ntu-ctp/5m-data-1.3-sql-basic-ddl/tree/solutions/data ), write the SQL statement to update the `email` of the teacher with the name 'John Doe' to 'john.doe@school.com' in the teachers table of the `lesson` schema.

Answer:

```sql
-- check first
SELECT * from teachers where name = 'John Doe';
-- do
UPDATE teachers SET email = 'john.doe@school.com' where name = 'John Doe';

```
### Question 4

Using the data provided in lesson 1.4 ( https://github.com/su-ntu-ctp/5m-data-1.4-sql-basic-dml/tree/main/db ), categorize flats into price ranges and count how many flats fall into each category:

- Under $400,000: 'Budget'
- $400,000 to $700,000: 'Mid-Range'
- Above $700,000: 'Premium'
  Show the counts in descending order.

```sql

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

```

### Question 5

Using the data provided in lesson 1.4 ( https://github.com/su-ntu-ctp/5m-data-1.4-sql-basic-dml/tree/main/db ),select the minimum and maximum price of flats sold in each town during the first quarter of 2017 (January to March).

```sql

SELECT 
	town, 
	MAX(resale_price) AS max_resale_price, 
	MIN(resale_price) AS min_resale_price
FROM main.resale_flat_prices_2017 
WHERE transaction_date BETWEEN '2017-01-01' AND '2017-03-01' 
GROUP BY town ORDER BY max_resale_price DESC;
```
### Question 6

Using the data provided in lesson 1.5 ( https://github.com/su-ntu-ctp/5m-data-1.5-sql-advanced/tree/main/db ), using the `claim` and `car` tables, write a SQL query to compute the running total of the `travel_time` column for each `car_id` in the `claim` table. The resulting table should contain `id, car_id, travel_time, running_total`.

Answer:

```sql
SELECT 
	car_id, 
	id, 
	claim_date, 
	travel_time, 
	SUM(travel_time) OVER (PARTITION BY car_id ORDER BY id ASC) AS running_total 
FROM claim ORDER BY car_id, id;

```

### Question 7

Using the data provided in lesson 1.5 ( https://github.com/su-ntu-ctp/5m-data-1.5-sql-advanced/tree/main/db ), using a Common Table Expression (CTE), write a SQL query to return a table containing `id, resale_value, car_use` from `car`, where the car resale value is less than the average resale value for the car use.

Answer:

```sql
-- CTE to return avg resale value for each car use
WITH avg_value AS (
	SELECT car_use, ROUND(AVG(resale_value)) as avg_value_by_use FROM main.car GROUP BY car_use
)
-- construct the table
SELECT c.id, c.resale_value, c.car_use, a.avg_value_by_use, (a.avg_value_by_use - c.resale_value) AS spread
FROM main.car c INNER JOIN avg_value a ON c.car_use=a.car_use 
WHERE c.resale_value < a.avg_value_by_use
ORDER BY spread DESC;

```

## Submission

- Submit the GitHub URL of your assignment solution to NTU black board.
- Should you reference the work of your classmate(s) or online resources, give them credit by adding either the name of your classmate or URL.
