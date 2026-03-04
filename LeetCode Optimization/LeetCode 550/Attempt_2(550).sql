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
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday 
using some device.

Write a solution to report the fraction of players that logged in again on the day after the day they first
logged in, rounded to 2 decimal places. In other words, you need to determine the number of players who 
logged in on the day immediately following their initial login, and divide it by the number of total players.
*/



WITH findFirstLogin AS(
    SELECT player_id, event_date, MIN(event_date) OVER(PARTITION BY player_id) as first_login
    FROM Activity
)
SELECT ROUND(COUNT(DISTINCT player_id)::DECIMAL/(SELECT COUNT(DISTINCT player_id) FROM Activity), 2) as fraction
FROM findFirstLogin
WHERE event_date = first_login + INTERVAL '1 day'
-- What i am doing here: first find the first login. That is an O(n) scan.
-- Then i eliminate all rows where the event date is not equal to a day after the first
-- login. This is also an O(n) scan and then we just do some arithmetic. we also have a
-- subquery that is O(n) so we have like 3*O(n) which is much faster than finding a
-- leading value for each row.
