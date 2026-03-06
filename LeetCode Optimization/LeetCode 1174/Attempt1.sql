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


SELECT ROUND(((COUNT(*)::DECIMAL)/(SELECT COUNT(DISTINCT customer_id) FROM Delivery))*100, 2) as immediate_percentage
FROM
(SELECT customer_id
FROM
(SELECT customer_id, ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) as order_val,
order_date, customer_pref_delivery_date
FROM Delivery)
WHERE order_val = 1 AND order_date = customer_pref_delivery_date)

/*
What i am doing here. First i use ROW_NUMBER so i can figure out which the first order date is, then
i check if the first order date was delivered on the same day. Then i get the count of that 
and divide by a subquery that gives me the count of all distinct customer_ids, and use ::DECIMAL, 
to make sure i get a decimal value, then multiply that by 100 to get percent val, 
then use round to round to 2 places.
*/
