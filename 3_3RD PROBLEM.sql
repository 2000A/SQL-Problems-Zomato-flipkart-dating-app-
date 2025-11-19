/*Problem 3: Identify Dating App Users Who Matched With 
More Than 5 Users But Sent Messages to Less Than 3 
Problem Statement: 
Find users who matched with more than 5 users but sent messages to less than 3 of them in 
the last 3 months*/


CREATE TABLE matches ( 
match_id INT, 
user_id INT, 
matched_user_id INT, 
match_date DATE 
); 

CREATE TABLE messages ( 
message_id INT, 
sender_id INT, 
receiver_id INT, 
message_date DATE 
); 

INSERT INTO matches VALUES 
(1, 301, 401, '2025-01-01'), 
(2, 301, 402, '2025-01-05'), 
(3, 301, 403, '2025-01-10'), 
(4, 301, 404, '2025-01-15'), 
(5, 301, 405, '2025-01-20'),
(6, 301, 406, '2025-01-25'); 

INSERT INTO messages VALUES 
(1, 301, 401, '2025-01-10'), 
(2, 301, 402, '2025-01-15');


SELECT *
FROM matches

SELECT *
FROM messages
/* postgresql code in one go */

WITH match_counts AS(
	SELECT
		user_id,
		COUNT(matched_user_id) AS total_matches
	FROM matches
	WHERE match_date >= CURRENT_DATE - INTERVAL '13 MONTH'
	GROUP BY user_id
),
message_counts AS(
	SELECT 
	sender_id,
	COUNT(receiver_id) AS total_message
	FROM messages
	WHERE message_date >= CURRENT_DATE - INTERVAL '13 MONTH'
	GROUP BY sender_id
)
SELECT 
	*
FROM match_counts m
LEFT JOIN message_counts msg ON m.user_id = msg.sender_id
WHERE m.total_matches > 5 AND msg.total_message < 3



/* More refining with respect to solution*/

WITH match_counts AS(
	SELECT
		user_id,
		COUNT(*) AS total_matches
	FROM matches
	WHERE match_date >= CURRENT_DATE - INTERVAL '13 MONTH'
	GROUP BY user_id
),
message_counts AS(
	SELECT 
	sender_id,
	COUNT(DISTINCT receiver_id) AS messages_sent
	FROM messages
	WHERE message_date >= CURRENT_DATE - INTERVAL '13 MONTH'
	GROUP BY sender_id
)
SELECT 
	*
FROM match_counts m
LEFT JOIN message_counts msg ON m.user_id = msg.sender_id
WHERE m.total_matches > 5 AND COALESCE(msg.messages_sent,0) < 3






















































































