-- 1. Demand Spike Detection
CREATE OR REPLACE VIEW warehouse.vw_demand_spike AS
WITH daily_sales AS (
  SELECT product_id, order_date, SUM(quantity) AS total_quantity
  FROM warehouse.fact_sales
  GROUP BY product_id, order_date
),
sales_with_lag AS (
  SELECT *, LAG(total_quantity) OVER (PARTITION BY product_id ORDER BY order_date) AS prev_quantity
  FROM daily_sales
)
SELECT *, ROUND((total_quantity - prev_quantity)::numeric / NULLIF(prev_quantity, 0) * 100, 2) AS pct_growth
FROM sales_with_lag
WHERE prev_quantity IS NOT NULL AND total_quantity > 2 * prev_quantity;

-- 2. High Return Products
CREATE OR REPLACE VIEW warehouse.vw_high_return_products AS
SELECT
  fs.product_id,
  SUM(fs.quantity) AS total_sold,
  COALESCE(SUM(r.quantity_returned), 0) AS total_returned,
  ROUND(COALESCE(SUM(r.quantity_returned)::numeric, 0) / NULLIF(SUM(fs.quantity), 0) * 100, 2) AS return_rate
FROM warehouse.fact_sales fs
LEFT JOIN staging.returns r ON fs.product_id = r.product_id
GROUP BY fs.product_id
HAVING ROUND(COALESCE(SUM(r.quantity_returned)::numeric, 0) / NULLIF(SUM(fs.quantity), 0) * 100, 2) > 30;

-- 3. High Frequency Customers
CREATE OR REPLACE VIEW warehouse.vw_high_freq_customers AS
WITH customer_orders AS (
  SELECT customer_id, order_date, COUNT(*) AS daily_order_count
  FROM warehouse.fact_sales
  GROUP BY customer_id, order_date
)
SELECT * FROM customer_orders
WHERE daily_order_count > 2;

-- 4. Inventory Shrinkage
CREATE OR REPLACE VIEW warehouse.vw_inventory_shrinkage AS
WITH sales_summary AS (
  SELECT product_id, SUM(quantity) AS total_sold
  FROM warehouse.fact_sales
  GROUP BY product_id
),
inventory_summary AS (
  SELECT product_id, MIN(available_qty) AS min_qty
  FROM warehouse.fact_inventory_snapshots
  GROUP BY product_id
)
SELECT
  s.product_id,
  s.total_sold,
  i.min_qty,
  s.total_sold - i.min_qty AS shrinkage
FROM sales_summary s
JOIN inventory_summary i ON s.product_id = i.product_id
WHERE s.total_sold > i.min_qty;

-- 5. Moving Average Sales (7 days)
CREATE OR REPLACE VIEW warehouse.vw_moving_avg_sales AS
SELECT
  product_id,
  order_date,
  SUM(quantity) AS total_sold,
  ROUND(AVG(SUM(quantity)) OVER (
    PARTITION BY product_id ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS avg_7d_qty
FROM warehouse.fact_sales
GROUP BY product_id, order_date;