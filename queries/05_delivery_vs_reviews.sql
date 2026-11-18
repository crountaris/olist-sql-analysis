-- Average review score by delivery time bucket (delivered orders)
WITH delivery AS (
    SELECT
        order_id,
        julianday(order_delivered_customer_date)
            - julianday(order_purchase_timestamp) AS delivery_days
    FROM orders
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
),
reviews AS (
    SELECT order_id, AVG(review_score) AS review_score
    FROM order_reviews
    GROUP BY order_id
)
SELECT
    CASE
        WHEN d.delivery_days <= 7  THEN '1) up to 7 days'
        WHEN d.delivery_days <= 14 THEN '2) 7-14 days'
        WHEN d.delivery_days <= 21 THEN '3) 14-21 days'
        ELSE '4) over 21 days'
    END AS delivery_bucket,
    COUNT(*) AS orders,
    ROUND(AVG(r.review_score), 2) AS avg_review
FROM delivery d
JOIN reviews r ON r.order_id = d.order_id
GROUP BY delivery_bucket
ORDER BY delivery_bucket;