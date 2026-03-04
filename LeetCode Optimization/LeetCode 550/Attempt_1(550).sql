

/*
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.

Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. 
In other words, you need to determine the number of players who logged in on the day immediately following their initial login, and divide it 
by the number of total players.
*/

WITH checkNextDate AS( WITH datesInOrder AS(
SELECT player_id, event_date, ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date ASC) as row_val
FROM Activity
)
SELECT player_id, event_date, LEAD(event_date) OVER(PARTITION BY player_id) as lead_val, row_val
FROM datesInOrder
)
SELECT ROUND(COUNT(c.player_id)::DECIMAL/(SELECT COUNT(DISTINCT player_id) FROM Activity), 2) as fraction
FROM checkNextDate c
WHERE lead_val = event_date + INTERVAL '1 day' AND row_val = 1
-- ok here is what i am doing here. First, i am doing two CTE's. This was probably
-- when i was first learning about CTE's because i did not need to write a CTE as a
-- subquery even if i used this method. I am using a window function to partition by
-- the player id in datesInOrder and using ROW_NUMBER to make sure that row val
-- is 1 when it is the first time the player logs in. then i add a row to get the LEAD
-- value, THEN i compare the lead value to the event date in our row and check if the
-- lead val is one ahead and the curr row we are at has row_val = 1, meaning we are at
-- the first login.



-- this is huge memory overhead. And we are doing multiple CTE’s. And we are doing a sort for
-- the row number which is O(nlogn). Lets not make the computer do so much work. How do we do that?(look at attempt 2)
