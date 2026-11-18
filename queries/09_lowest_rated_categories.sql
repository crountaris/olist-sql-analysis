-- 10 lowest-rated product categories (delivered orders, min. 100 orders)
WITH order_scores AS (
    SELECT order_id, AVG(review_score) AS review_score
    FROM order_reviews
    GROUP BY order_id
),
order_categories AS (
    SELECT DISTINCT
        oi.order_id,
        COALESCE(t.product_category_name_english, p.product_category_name) AS category
    FROM order_items oi
    JOIN orders o ON o.order_id = oi.order_id
    JOIN products p ON p.product_id = oi.product_id
    LEFT JOIN product_category_name_translation t
        ON t.product_category_name = p.product_category_name
    WHERE o.order_status = 'delivered'
)
SELECT
    oc.category,
    COUNT(*) AS orders,
    ROUND(AVG(s.review_score), 2) AS avg_review
FROM order_categories oc
JOIN order_scores s ON s.order_id = oc.order_id
WHERE oc.category IS NOT NULL
GROUP BY oc.category
HAVING COUNT(*) >= 100
ORDER BY avg_review ASC
LIMIT 10;