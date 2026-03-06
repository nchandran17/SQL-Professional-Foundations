/*
Schema and prompt: 
Table: Delivery

+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
 

If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

*/

SELECT ROUND((((SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END))::DECIMAL)/(COUNT(*)))*100, 2) as immediate_percentage
FROM(
SELECT order_date, customer_pref_delivery_date, ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date ASC) as row_val
FROM Delivery)
WHERE row_val = 1


/*
What do i do here differently? First, in the subquery, i give each order date per
customer a row value depending on how early it was, same as before. Outside the subquery,
the first piece of logic that will be executed is the WHERE clause. I elimate any orders
that are not the first placed by a customer. Then I use the secret weapon of percentage
problems in sql. The SUM CASE WHEN. I check if each row from my subquery meets a condition,
and if it does i add one, and if not i add 0. By the end, i have the number
of first orders that were 'immediately delivered'. Then i simply use COUNT(*), because
we already used WHERE to make sure we only have the first order for each specific unique
customer, so we dont need another subquery. This makes our code significantly more efficient.
*/
