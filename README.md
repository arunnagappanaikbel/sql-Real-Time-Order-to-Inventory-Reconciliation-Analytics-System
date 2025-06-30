📦 Project: Real-Time Order-to-Inventory Reconciliation & Analytics System

### 🔗 A production-grade, real-time PostgreSQL SQL-based ETL pipeline to track, reconcile, and analyze orders and inventory with business-critical logic, automation-ready architecture, and advanced analytics capabilities.

---

## 📁 Folder Structure

```
etl_order_inventory_project/
│
├── sql/
│   ├── 01_create_schemas.sql
│   ├── 02_staging_tables.sql
│   ├── 03_intermediate_transformations.sql
│   ├── 04_dimension_fact_tables.sql
│   ├── 05_views_business_logic.sql
│   ├── 06_indexes.sql
│   ├── 07_functions_procedures.sql
│   ├── 08_logging.sql
│   ├── 09_run_etl.sql
│   └── 10_complex_business_logic.sql
│
├── data/
│   ├── orders.csv
│   ├── inventory.csv
│   └── returns.csv
│
├── logs/
│   └── etl_log_table.csv
│
├── README.md
```

---

## 🚀 Project Features

✅ Pure PostgreSQL-based ETL  
✅ Real-time business reconciliation logic  
✅ Data cleansing, transformation, enrichment  
✅ Window functions, CTEs, aggregates  
✅ Inventory audit, product performance insights  
✅ Stored procedures and functions for reusability  
✅ Exception-safe logging with audit trail  
✅ Indexing for performance  
✅ View-based analytics and reporting layer  
✅ Modular structure ready for automation (cron/Airflow)

---

## 🔍 Core Business Use Cases

- 📦 Order-to-Inventory Reconciliation
- 📊 Sales Trend Analysis
- 📈 Demand Spike Alerts
- 🔁 Return Rate Monitoring
- 🔧 Inventory Shrinkage
- 👥 Customer Activity
- 📉 Stock Alerts

---

## 🔧 Tech Stack

| Tool            | Purpose                            |
|-----------------|------------------------------------|
| PostgreSQL      | Main SQL database engine           |
| SQL/PLpgSQL     | Core ETL and logic implementation  |
| CSV             | Sample data ingestion              |
| pgAdmin / DBeaver | DB interface for development     |

---

## 🛠️ Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/etl_order_inventory_project.git
   cd etl_order_inventory_project
   ```

2. **Open in pgAdmin / psql CLI**
   Load scripts from the `sql/` folder in order:
   - 01_create_schemas.sql
   - ...
   - 10_complex_business_logic.sql

3. **Load sample data**
   ```sql
   COPY staging.orders FROM '/path/orders.csv' CSV HEADER;
   COPY staging.inventory FROM '/path/inventory.csv' CSV HEADER;
   COPY staging.returns FROM '/path/returns.csv' CSV HEADER;
   ```

4. **Run ETL**
   ```sql
   \i sql/09_run_etl.sql
   ```

---

## 🧠 Advanced Logic Highlights

| View Name                       | Purpose                                      |
|--------------------------------|----------------------------------------------|
| vw_demand_spike                | Sales spike detection (100%+ increase)       |
| vw_high_return_products        | Detects SKUs with return rate > 30%          |
| vw_high_freq_customers         | Customers ordering >2x daily                 |
| vw_inventory_shrinkage         | Detects inventory inconsistencies            |
| vw_moving_avg_sales            | 7-day moving average sales per product       |

---

## 🔐 Logging & Auditing

- audit.etl_logs logs each major ETL event
- Exceptions are captured using RAISE NOTICE
- Check logs using:
  ```sql
  SELECT * FROM audit.etl_logs ORDER BY event_time DESC;
  ```

---

## 🧪 Optional Enhancements

- Integrate pg_cron / Airflow
- Unit testing via pgTAP
- Dockerize PostgreSQL setup
- Add Kafka/API ingestion support
- Secure with role-based access

---

## 👤 Author

**Arun Naik**  
🔗 [LinkedIn]([https://www.linkedin.com](https://www.linkedin.com/in/arun-naik-527443163/)) | 🌐 [Portfolio](https://yourportfolio.com)

---

## 📃 License

Open-source under the [MIT License](LICENSE)
