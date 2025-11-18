/*Problem 1: Find Zomato Customers Who Ordered More 
Than 5 Times but Rated Only Once 
Problem Statement: 
Identify customers who placed more than 5 orders but gave ratings for only one order in the 
last 6 months.
*/


CREATE TABLE zomato_orders ( 
order_id INT, 
customer_id INT, 
customer_name VARCHAR(50), 
order_date DATE 
); 
CREATE TABLE zomato_ratings ( 
rating_id INT, 
customer_id INT, 
rating INT, 
rating_date DATE 
); 
INSERT INTO zomato_orders VALUES 
(1, 1001, 'Gowtham', '2025-01-01'), 
(2, 1001, 'Gowtham', '2025-01-10'), 
(3, 1001, 'Gowtham', '2025-01-20'), 
(4, 1001, 'Gowtham', '2025-02-01'), 
(5, 1001, 'Gowtham', '2025-02-15'), 
(6, 1001, 'Gowtham', '2025-02-25'); 
INSERT INTO zomato_ratings VALUES 
(1, 1001, 4, '2025-01-10');

/* my first logic
SELECT 
	*
FROM zomato_orders AS o
LEFT JOIN zomato_ratings AS r ON o.customer_id = r.customer_id
WHERE o.order_id > 5 AND o.order_date = r.rating_date

*/
/*PostgreSQL Code*/

WITH order_counts AS(
	SELECT 
		customer_id,
		COUNT(*) AS TotalOrders
	FROM zomato_orders
	WHERE order_date >= CURRENT_DATE - INTERVAL '1 YEAR'
	GROUP BY customer_id
),
rating_counts AS(
	SELECT
		customer_id,
		COUNT(*) AS TotalRatings
	FROM zomato_ratings
	WHERE rating_date >= CURRENT_DATE - INTERVAL '1 YEAR'
	GROUP BY customer_id
)
SELECT 
	*
FROM order_counts o
LEFT JOIN rating_counts r ON o.customer_id = r.customer_id
WHERE o.TotalOrders > 5 AND COALESCE(r.TotalRatings,0) = 1

/*MySQL code*/

WITH order_counts AS (
	SELECT
		customer_id,
		COUNT(*) AS TotalOrders
	FROM zomato_orders 
	WHERE order_date >= DATE_SUB(CURDATE() ,INTERVAL 6 MONTH)
	GROUP BY customer_id
),
rating_counts AS (
	SELECT
		customer_id,
		COUNT(*) AS TotalRating
	FROM zomato_ratings 
	WHERE rating_date >= DATE_SUB(CURDATE() , INTERVAL 6 MONTH)
	GROUP BY customer_id
)



















