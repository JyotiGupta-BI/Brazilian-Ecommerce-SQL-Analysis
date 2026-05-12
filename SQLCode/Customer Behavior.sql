
-------------Customer Satisfcation/Behavior

-----Repeat vs One-Time Customers
WITH customer_orders AS (

    SELECT c._customer_unique_id_, COUNT(DISTINCT o._order_id_) AS total_orders

    FROM orders o JOIN customers c
        ON o._customer_id_ = c._customer_id_

    WHERE o._order_status_ = 'delivered'

    GROUP BY c._customer_unique_id_
)

SELECT 
    CASE 
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type, COUNT(*) AS total_customers

FROM customer_orders
GROUP BY 
    CASE 
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END;