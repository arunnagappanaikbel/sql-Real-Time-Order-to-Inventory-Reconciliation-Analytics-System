BEGIN;
CALL warehouse.sp_load_fact_sales();
COMMIT;