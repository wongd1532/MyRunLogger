# MyRunLogger

This project was started 9/30/2024.
Goal: create a database for logging personal running data, then analyze using visualization tools to get valuable insights.

## Project Plan
- [ ] **PHASE 1️⃣**: Conceptual Schema Design
    - [x] Create [Entity-Relationship Diagram](#entity-relationship-diagram) *(2 Oct 2024)*
    - [x] [Relational Data Model](#relational-data-model) *(2 Oct 2024)*
    - [ ] Database [Normalization](#normalization) for Data Integrity
- [ ] **PHASE 2️⃣**: Physical Database Design
    - [ ] Write Database creation DDL statements in SQL
    - [ ] Execute SQL statements to create database in MySQL
    - [ ] Data loading and testing
- [ ] **PHASE 3️⃣**: Data Modelling
    - [ ] Write SQL Queries for data extraction
    - [ ] Setup for Visualization
    - [ ] Design and Develop Dashboards

## PHASE 1️⃣: Conceptual Schema

### Entity Relationship Diagram
![MyRunLogger Entity-Relationship-Diagram](https://github.com/wongd1532/MyRunLogger/blob/main/conceptual-schema/ERD.jpg?raw=true)

### Relational Data Model
![MyRunLogger Relational-Data-Model](https://github.com/wongd1532/MyRunLogger/blob/main/conceptual-schema/relational-data-model.jpg?raw=true)

### Normalization
#### First Normal Form
- [x] No multi-valued fields
- [x] Each table has an uniquely identifying primary key
- [x] 