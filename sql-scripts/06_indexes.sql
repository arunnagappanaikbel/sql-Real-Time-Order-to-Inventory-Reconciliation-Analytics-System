CREATE INDEX idx_sales_product_date ON warehouse.fact_sales(product_id, order_date);
CREATE INDEX idx_inventory_time ON warehouse.fact_inventory_snapshots(snapshot_time);