-- Monthly revenue with running (cumulative) total, Jan 2017 - Aug 2018
WITH monthly AS (
    SELECT
        strftime('%Y-%m', o.order_purchase_timestamp) AS month,
        ROUND(SUM(oi.price), 2) AS revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY month
)
SELECT
    month,
    revenue,
    ROUND(SUM(revenue) OVER (ORDER BY month), 2) AS cumulative_revenue
FROM monthly
WHERE month BETWEEN '2017-01' AND '2018-08'
ORDER BY month;