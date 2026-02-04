/*
Problem: LeetCode 1661 - Average Time of Process per Machine
URL: https://leetcode.com/problems/average-time-of-process-per-machine/

Description:
Find the average time it takes for each machine to complete a process.
The time for one process is (end timestamp - start timestamp).
The average is calculated per machine_id across all its processes.

Table: Activity
- machine_id (int)
- process_id (int)
- activity_type (enum: 'start' or 'end')
- timestamp (float)
*/


SELECT a.machine_id, ROUND(AVG(a1.timestamp-a.timestamp):: numeric, 3) as processing_time
FROM Activity a
JOIN Activity a1
ON a.machine_id = a1.machine_id 
AND a.process_id = a1.process_id
WHERE a.activity_type = 'start' AND a1.activity_type = 'end'
GROUP BY a.machine_id;
