/* Problem 3:
Find Flipkart Customers Who Purchased Products in More
Than 3 Categories. */

/* Problem Statement:
Identify customers who bought products from more than 3 
different categories in the last year.*/

CREATE TABLE flipkart_purchases ( 
purchase_id INT, 
customer_id INT, 
customer_name VARCHAR(50), 
product_category VARCHAR(50), 
purchase_date DATE 
); 

INSERT INTO flipkart_purchases VALUES 
(1, 201, 'Gowtham', 'Electronics', '2024-09-10'), 
(2, 201, 'Gowtham', 'Books', '2024-10-15'), 
(3, 201, 'Gowtham', 'Fashion', '2025-01-20'), 
(4, 201, 'Gowtham', 'Home & Kitchen', '2025-03-10'); 

/*PostgreSQL version of code*/
SELECT 
	customer_id,
	customer_name,
	COUNT(DISTINCT product_category ) AS category_count
FROM flipkart_purchases
WHERE purchase_date>= CURRENT_DATE - INTERVAL '18 MONTH'
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category ) > 3;

/*MYSQL version of code*/

SELECT customer_id, customer_name, COUNT(DISTINCT product_category) AS 
category_count 
FROM flipkart_purchases 
WHERE purchase_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) 
GROUP BY customer_id, customer_name 
HAVING category_count > 3



















































