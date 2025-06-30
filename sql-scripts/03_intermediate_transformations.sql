CREATE TABLE intermediate.cleaned_orders AS
WITH valid_orders AS (
  SELECT DISTINCT *
  FROM staging.orders
  WHERE quantity > 0 AND price >= 0
)
SELECT *, quantity * price AS total_price FROM valid_orders;
CREATE TABLE intermediate.cleaned_inventory AS
SELECT DISTINCT * FROM staging.inventory WHERE available_qty IS NOT NULL;