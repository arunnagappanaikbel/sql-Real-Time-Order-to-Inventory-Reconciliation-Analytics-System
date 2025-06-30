CREATE VIEW warehouse.vw_cumulative_sales AS
WITH ordered_data AS (
  SELECT order_id, product_id, order_date, quantity,
         SUM(quantity) OVER (PARTITION BY product_id ORDER BY order_date) AS cumulative_qty
  FROM warehouse.fact_sales
)
SELECT * FROM ordered_data;
CREATE VIEW warehouse.vw_low_stock_alerts AS
SELECT product_id, MIN(available_qty) AS min_stock
FROM warehouse.fact_inventory_snapshots
GROUP BY product_id
HAVING MIN(available_qty) < 10;