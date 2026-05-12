
---------- 1. total revenue and how has it grown month-over-month-----------

WITH monthly_revenue AS (
    SELECT 
		format(o._order_purchase_timestamp_,'yyyy-MM') as order_month,
--        DATEFROMPARTS(YEAR(o._order_purchase_timestamp_),MONTH(o._order_purchase_timestamp_),1) AS order_month,
        SUM(p._payment_value_) AS revenue
    FROM orders o JOIN order_payments p
        ON o._order_id_ = p._order_id_
    WHERE o._order_status_ = 'delivered'
    GROUP BY FORMAT(o._order_purchase_timestamp_, 'yyyy-MM')
)

SELECT 
    order_month, revenue,
	LAG(revenue) OVER (ORDER BY order_month) AS prev_month_revenue,
    ROUND((revenue - LAG(revenue) OVER (ORDER BY order_month)) * 100.0 / LAG(revenue) OVER (ORDER BY order_month)
	, 2) AS mom_growth_pct
FROM monthly_revenue
ORDER BY order_month;


----2. Which months have peak sales and why (seasonality)? --------------------

SELECT 
    DATENAME(MONTH, o._order_purchase_timestamp_) AS month_name,
    MONTH(o._order_purchase_timestamp_) AS month_number,
    SUM(p._payment_value_) AS revenue
FROM orders o JOIN order_payments p
    ON o._order_id_ = p._order_id_
WHERE o._order_status_ = 'delivered'
GROUP BY 
    DATENAME(MONTH, o._order_purchase_timestamp_),
    MONTH(o._order_purchase_timestamp_)
ORDER BY month_number;

---- reson for spike in May/Aug-------
------ a. is t seasonal spike, lets find Year-wise Monthly Pattern

SELECT YEAR(_order_purchase_timestamp_) AS year, DATENAME(MONTH, _order_purchase_timestamp_) AS month_name,
    MONTH(_order_purchase_timestamp_) AS month_number, COUNT(DISTINCT _order_id_) AS total_orders
FROM orders
WHERE _order_status_ = 'delivered'
GROUP BY											-- this shows spikes were different in every month across the year
    YEAR(_order_purchase_timestamp_),				-- hence not a seasonal spike
	MONTH(_order_purchase_timestamp_), 
	DATENAME(MONTH, _order_purchase_timestamp_)
ORDER BY 
    year, month_number;

------b. Check: Is it just more orders?

SELECT MONTH(_order_purchase_timestamp_) AS month_number, COUNT(DISTINCT _order_id_) AS total_orders
FROM orders
WHERE _order_status_ = 'delivered'				--- this shows total orders were high may/aug
GROUP BY MONTH(_order_purchase_timestamp_)		--- Growth driven by order volume
ORDER BY total_orders DESC;

-------c. Check: Is order value higher?--------------------

WITH order_value AS (
	SELECT o._order_id_, MONTH(o._order_purchase_timestamp_) AS month_number,
	SUM(p._payment_value_) AS order_value
	FROM orders o JOIN order_payments p
	ON o._order_id_ = p._order_id_
	WHERE o._order_status_ = 'delivered'								---- Sep/Oct have higher AOV
	GROUP BY o._order_id_, MONTH(o._order_purchase_timestamp_)			---- May/Aug do NOT	
)
SELECT month_number, AVG(order_value) AS avg_order_value
FROM order_value
GROUP BY month_number
ORDER BY avg_order_value DESC;

--------d. Check: Which categories are causing spike (CORE WHY)---------------

SELECT YEAR(o._order_purchase_timestamp_) AS year, MONTH(o._order_purchase_timestamp_) AS month_number, 
		pct.product_category_name_english AS category, COUNT(*) AS total_orders
FROM orders o
JOIN order_items oi
    ON o._order_id_ = oi._order_id_
JOIN products pr
    ON oi._product_id_ = pr._product_id_
LEFT JOIN product_category_name_translation pct
    ON pr._product_category_name_ = pct.product_category_name
WHERE 
    o._order_status_ = 'delivered'
	AND YEAR(o._order_purchase_timestamp_) = 2018
    AND MONTH(o._order_purchase_timestamp_) IN (5, 8)
GROUP BY 
	YEAR(o._order_purchase_timestamp_), MONTH(o._order_purchase_timestamp_), pct.product_category_name_english
ORDER BY 
    month_number,total_orders DESC;


---------- 3. What is average order value (AOV) over time?
WITH monthly_metrics AS (
    SELECT 
		FORMAT(o._order_purchase_timestamp_, 'MMM-yyyy') AS month_year,
        YEAR(o._order_purchase_timestamp_) AS year,
        MONTH(o._order_purchase_timestamp_) AS month_number,
        COUNT(DISTINCT o._order_id_) AS total_orders,
        SUM(p._payment_value_) AS total_revenue

    FROM orders o JOIN order_payments p
        ON o._order_id_ = p._order_id_
		WHERE o._order_status_ = 'delivered'

    GROUP BY 
        FORMAT(o._order_purchase_timestamp_, 'MMM-yyyy'),YEAR(o._order_purchase_timestamp_), MONTH(o._order_purchase_timestamp_)
)

SELECT month_year, total_orders, total_revenue,
    ROUND(total_revenue * 1.0 / total_orders,2) AS avg_order_value
FROM monthly_metrics
ORDER BY year, month_number; 


