
-------- 1.Which product categories have high sales but low ratings?
WITH category_metrics AS (

    SELECT pct.product_category_name_english AS category, COUNT(DISTINCT o._order_id_) AS total_orders,
        ROUND(AVG(CAST(r._review_score_ AS FLOAT)), 2) AS avg_review_score

    FROM orders o

    JOIN order_items oi
        ON o._order_id_ = oi._order_id_

    JOIN products pr
        ON oi._product_id_ = pr._product_id_

    LEFT JOIN product_category_name_translation pct
        ON pr._product_category_name_= pct.product_category_name

    JOIN order_reviews r
        ON o._order_id_ = r._order_id_

    WHERE o._order_status_ = 'delivered'
	and pct.product_category_name_english IS NOT NULL
    GROUP BY pct.product_category_name_english
)

SELECT TOP 10 *
FROM category_metrics
WHERE avg_review_score < 4
ORDER BY total_orders DESC;

-------2. Which product categories have the highest Average Order Value (AOV)?
WITH category_aov AS (
    SELECT pct.product_category_name_english AS category, COUNT(DISTINCT o._order_id_) AS total_orders,
        ROUND(SUM(p._payment_value_) * 1.0 / COUNT(DISTINCT o._order_id_),2) AS avg_order_value

    FROM orders o
    JOIN order_payments p
        ON o._order_id_ = p._order_id_

    JOIN order_items oi
        ON o._order_id_ = oi._order_id_

    JOIN products pr
        ON oi._product_id_ = pr._product_id_

    LEFT JOIN product_category_name_translation pct
        ON pr._product_category_name_ = pct.product_category_name

    WHERE 
        o._order_status_ = 'delivered'
        AND pct.product_category_name_english IS NOT NULL

    GROUP BY pct.product_category_name_english
)

SELECT TOP 10 *
FROM category_aov
WHERE total_orders >= 100
ORDER BY avg_order_value DESC;
