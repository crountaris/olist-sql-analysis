-- Top 10 sellers by revenue (delivered orders), with share of total
WITH seller_revenue AS (
    SELECT
        oi.seller_id,
        s.seller_state,
        COUNT(DISTINCT oi.order_id) AS orders,
        ROUND(SUM(oi.price), 2) AS revenue
    FROM order_items oi
    JOIN orders o ON o.order_id = oi.order_id
    JOIN sellers s ON s.seller_id = oi.seller_id
    WHERE o.order_status = 'delivered'
    GROUP BY oi.seller_id, s.seller_state
)
SELECT
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank,
    seller_id,
    seller_state,
    orders,
    revenue,
    ROUND(100.0 * revenue / SUM(revenue) OVER (), 2) AS pct_of_total
FROM seller_revenue
ORDER BY revenue_rank
LIMIT 10;