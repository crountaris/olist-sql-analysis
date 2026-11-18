-- Payment methods: number of orders, total value, and share of total value
SELECT
    payment_type,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(payment_value), 2) AS total_value,
    ROUND(100.0 * SUM(payment_value) / SUM(SUM(payment_value)) OVER (), 1) AS pct_of_value
FROM order_payments
GROUP BY payment_type
ORDER BY total_value DESC;