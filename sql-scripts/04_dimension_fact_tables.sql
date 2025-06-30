CREATE TABLE warehouse.dim_products (
  product_id TEXT PRIMARY KEY,
  product_name TEXT,
  category TEXT
);
CREATE TABLE warehouse.fact_sales (
  order_id TEXT PRIMARY KEY,
  product_id TEXT,
  customer_id TEXT,
  quantity INT,
  total_price NUMERIC,
  order_date DATE
);
CREATE TABLE warehouse.fact_inventory_snapshots (
  snapshot_time TIMESTAMPTZ,
  product_id TEXT,
  available_qty INT
);