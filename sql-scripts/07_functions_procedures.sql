CREATE OR REPLACE FUNCTION warehouse.fn_avg_order_value(p_product_id TEXT)
RETURNS NUMERIC AS $$
BEGIN
  RETURN (
    SELECT AVG(total_price)
    FROM warehouse.fact_sales
    WHERE product_id = p_product_id
  );
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE PROCEDURE warehouse.sp_load_fact_sales()
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO warehouse.fact_sales
  SELECT order_id, product_id, customer_id, quantity, total_price, order_time::date
  FROM intermediate.cleaned_orders
  ON CONFLICT DO NOTHING;
  PERFORM audit.sp_log_event('fact_sales loaded');
END;
$$;