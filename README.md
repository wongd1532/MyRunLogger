# MyRunLogger

This project was started 9/30/2024.
Goal: create a database for logging personal running data, then analyze using visualization tools to get valuable insights.

## [x] **PHASE 1️⃣**: Conceptual Schema *(1 Oct 2024 - 9 Oct 2024)*

### [x] 1.1: Create [Entity-Relationship Diagram](conceptual-schema/ERD.jpg)
- ![MyRunLogger Entity-Relationship-Diagram](https://github.com/wongd1532/MyRunLogger/blob/main/conceptual-schema/ERD.jpg?raw=true)

### [x] 1.2: Create [Relational Data Model](conceptual-schema/relational-data-model.jpg)
- ![MyRunLogger Relational-Data-Model](https://github.com/wongd1532/MyRunLogger/blob/main/conceptual-schema/relational-data-model.jpg?raw=true)

### [x] 1.3: [x] Database Normalization for Data Integrity
- Wrote [normalization.md](conceptual-schema/normalization.md) explaining normalization process, considerations, and skill development

### [x] 1.4: [Assumptions and Constraints](#assumptions-and-constraints)
- Wrote [assumptions-and-constraints.md](conceptual-schema/assumptions-and-constraints.md) to clarify ambiguities from real-world modelling in the conceptual schema
- This also serves as a foundation for writing `ON DELETE` and `ON UPDATE` foreign key constraints in database creation scripts

## [ ] **PHASE 2️⃣**: Physical Schema *(9 Oct 2024 - )*

### [x] 2.1: SQL DDL Script for Database Creation
- Wrote [create_db.sql](physical-schema/create_db.sql)

### [x] 2.2: Database Set-Up in MySQL
- Using MySQL Workbench, locally hosted MySQL server and set up `my_run_logger_db` by running create_db.sql script as root user

### [ ] 2.3: Data Loading
- Created user:
    - Username: `data_loader`
    - Password: `data_loader_PASSWORD123.`
- Granted user data_loader following privileges for the `my_run_logger_db` schema: DELETE, EXECUTE, INSERT, SELECT, SHOW VIEW, UPDATE
- For data loading, run the following command as root user to enable csv loading: `SET GLOBAL local_infile = 1;`


### [ ] 2.4: Data Testing



- [ ] **PHASE 3️⃣**: Data Modelling
    - [ ] Write SQL Queries for Data Extraction
    - [ ] Setup for Visualization
    - [ ] Design and Develop Dashboards
