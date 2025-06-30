CREATE TABLE audit.etl_logs (
  id SERIAL PRIMARY KEY,
  event_time TIMESTAMPTZ DEFAULT NOW(),
  event_description TEXT
);
CREATE OR REPLACE PROCEDURE audit.sp_log_event(p_event TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO audit.etl_logs(event_description) VALUES (p_event);
EXCEPTION
  WHEN OTHERS THEN
    RAISE NOTICE 'Logging failed: %', SQLERRM;
END;
$$;