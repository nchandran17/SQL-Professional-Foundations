

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

SELECT id, COUNT(*) as num
FROM (
    SELECT requester_id as id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id as id FROM RequestAccepted
)
as combined_ids
GROUP BY id
ORDER BY num DESC
LIMIT 1

-- Why are we doing it this way now? First this is much simpler and easier for the
-- computer. we combine the id's from requester id and accepter id by using union all
-- the reason we use union all is because A) we do not want to delete duplicates
-- because then we will lose data. B) UNION ALL is faster because the computer does
-- not have to do the task of deleting duplicate rows


-- O(N)*2 plus O(NlogN) for this one
