This repo contains me sharping my sql skills with gowtham sb 100 sql interview questions of zomato, flipkart, dating apps.

Day 19-11- 2025
Problem 1: learnings 
-> To fetch past 6 months or past year or past days orders 
   -> for that subtract current date with the interval (DATE_SUB(CURDATE(), INTERVAL 6 MONTH) or CURRENT_DATE - INTERVAL '6 MONTH'

-> Learned CTE use case : ⭐ To calculate two separate aggregated results and then use them together in a final query.
And same problem 1 can be solved using subquery
SELECT
    o.customer_id,
    o.TotalOrders,
    r.TotalRating
FROM
    (
        SELECT
            customer_id,
            COUNT(*) AS TotalOrders
        FROM zomato_orders
        WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
        GROUP BY customer_id
    ) AS o
LEFT JOIN
    (
        SELECT
            customer_id,
            COUNT(*) AS TotalRating
        FROM zomato_ratings
        WHERE rating_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
        GROUP BY customer_id
    ) AS r
ON o.customer_id = r.customer_id
WHERE o.TotalOrder > 5 AND COALESCE(r.TotalRating.0) = 1
