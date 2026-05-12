
-----------------------------------------Delivery Performance-------------------------------------------------

----------What is the average delivery delay (Actual vs Estimated)?
SELECT 
    ROUND(
        AVG(
            DATEDIFF(DAY, o._order_estimated_delivery_date_, o._order_delivered_customer_date_)
        ) * 1.0,
    2) AS avg_delivery_delay_days

FROM orders o

WHERE 
    o._order_status_ = 'delivered'
    AND o._order_delivered_customer_date_ IS NOT NULL
    AND o._order_estimated_delivery_date_ IS NOT NULL;

--------------------------------------Customer Satisfaction-------------------------------------------------

--------------Does delivery delay impact customer review scores?-----------------------

WITH delivery_reviews AS (

    SELECT 
        o._order_id_, DATEDIFF(DAY, o._order_estimated_delivery_date_, o._order_delivered_customer_date_) AS delivery_variance,
        r._review_score_

    FROM orders o JOIN order_reviews r
        ON o._order_id_ = r._order_id_

    WHERE 
        o._order_status_ = 'delivered'
        AND o._order_delivered_customer_date_ IS NOT NULL
        AND o._order_estimated_delivery_date_ IS NOT NULL
)

SELECT 
    _review_score_, ROUND(AVG(delivery_variance) * 1.0, 2) AS avg_delivery_variance
FROM delivery_reviews
GROUP BY _review_score_
ORDER BY _review_score_;

-----------------Which high-volume sellers consistently deliver orders late?------
---focus on sellers with: meaningful order volume AND consistently poor delivery performance

WITH seller_delivery_performance AS (

    SELECT oi._seller_id_, COUNT(DISTINCT o._order_id_) AS total_orders, ROUND(
	AVG(DATEDIFF(DAY, o._order_estimated_delivery_date_, o._order_delivered_customer_date_)) * 1.0
	,2) AS avg_delivery_variance

    FROM orders o JOIN order_items oi
        ON o._order_id_ = oi._order_id_

    WHERE 
        o._order_status_ = 'delivered'
        AND o._order_delivered_customer_date_ IS NOT NULL
        AND o._order_estimated_delivery_date_ IS NOT NULL

    GROUP BY oi._seller_id_
)

SELECT TOP 10
    _seller_id_, total_orders, avg_delivery_variance
	FROM seller_delivery_performance
WHERE 
    total_orders >= 100

ORDER BY avg_delivery_variance DESC;








