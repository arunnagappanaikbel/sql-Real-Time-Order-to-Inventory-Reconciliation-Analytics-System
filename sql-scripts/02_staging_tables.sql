CREATE TABLE staging.orders (
  order_id TEXT,
  product_id TEXT,
  quantity INT,
  price NUMERIC,
  order_time TIMESTAMPTZ,
  customer_id TEXT
);
CREATE TABLE staging.inventory (
  product_id TEXT,
  available_qty INT,
  updated_time TIMESTAMPTZ
);