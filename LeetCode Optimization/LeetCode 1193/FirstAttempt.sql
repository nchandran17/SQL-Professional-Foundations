/*
Table: Transactions

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
 

Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.

Return the result table in any order.

*/




SELECT TO_CHAR(trans_date, 'YYYY-MM') as month, country, COUNT(*) as trans_count, SUM((CASE WHEN state = 'approved' THEN 1 ELSE 0 END)) as approved_count, SUM(amount) as trans_total_amount, SUM((CASE WHEN state = 'approved' THEN amount ELSE 0 END)) as approved_total_amount
FROM Transactions
GROUP BY country, month


/*
This problem is straightforward, but requires knowledge of how sql works
in the backend. The most important line of code here is
GROUP BY country, month.
This tells the sql engine to create a bucket for each time we see
an instance of that and create a counter for that bucket. Therefore we can just do COUNT(*) to get the amount of times that bucket appears.
When we do group by, we are essentially operating inside each
bucket seperately and reporting data back about that bucket.
So when we use something like SUM, it is summing all the values in that
bucket for whatever column. We use the case when to tell sum
which columns not to add.
IMPORTANT NOTES:
using month in the group by is postgresql specific(or at least
modern sql specific), but the same query can be run by copying what month
represents and putting it into the group by.
Also, on a really large database where we are constantly updating
something like this, if we create an index once, it will make this query lightning fast every time, O(logn)
*/
