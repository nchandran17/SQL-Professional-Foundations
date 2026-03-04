--Schema:
/*
Table: RequestAccepted

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 

Write a solution to find the people who have the most friends and the most friends number.

*/




WITH num_request AS (SELECT requester_id, COUNT(requester_id) as count_requester_id
FROM RequestAccepted
GROUP BY requester_id),
accept_request AS(
    SELECT accepter_id, COUNT(accepter_id) as count_accepter_id
    FROM RequestAccepted
    GROUP BY accepter_id
),
num_friends AS (SELECT COALESCE(n.requester_id, a.accepter_id) as id, (COALESCE(n.count_requester_id, 0)+COALESCE(a.count_accepter_id, 0)) as num
FROM num_request n
FULL OUTER JOIN accept_request a
ON n.requester_id = a.accepter_id)

SELECT id, num
FROM num_friends
ORDER BY num DESC
LIMIT 1;
-- What are we doing here? First we are finding the number of times an id is a requester
-- and the number of times an Id is a accepter.
-- Then we calculate the total number of friends for each id by using coalesce to make
-- sure we get all the id's and we use coalesce again to make sure if there are no values
-- for that that we just add 0 to that id's total. We use a full outer join to make
-- sure we use all the values
-- then we just get all the id and num and order by the number of friends from top
-- to bottom and limit it at 1.



--but wait, this is a very heavy operation. We are using full outer join which is very compute intensive. 
-- The big O for this is O(NlogN) for the two separate group by’s + O(M+N) for the full outer join + O(KlogK) for the final sort.  
-- How do we make this faster?(Look at attempt 2)
