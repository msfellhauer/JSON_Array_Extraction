# Snowflake JSON Transformation Project

## Overview
This project demonstrates the transformation of raw JSON data into a structured, production-ready table in Snowflake. The source data originated from nested JSON stored in the Bronze layer of the Snowflake data warehouse. Using SQL and Snowflake-specific features such as `LATERAL FLATTEN` and type casting, the data was transformed into a clean, flattened format suitable for analytics, reporting, and downstream modeling.

## Key Features
- **Nested JSON Handling**: Extracted and flattened arrays and objects using `LATERAL FLATTEN`.
- **Data Type Casting**: Converted JSON fields into appropriate Snowflake types (`VARCHAR`, `NUMBER`, `DATE`, `DATETIME`).
- **Clustering for Performance**: The production table is clustered by `date` to optimize queries that filter by time.
- **Clean, Production-Ready Output**: The resulting table can be used for dashboards, aggregations, or machine learning pipelines.

## Skills Demonstrated
- Snowflake SQL and ETL transformations  
- Working with nested JSON and arrays  
- Data modeling and preparation for analytics  
- Understanding of table clustering and performance optimization  

## How to Use
1. Connect to your Snowflake environment.  
2. Run `raw_json_extract.sql` to create or replace the table: `Snowflake_Schema.Raw_JSON_Extract`.  
3. Use the resulting table for analytics, reporting, or further transformation in Silver/Gold layers.  

---

> **Note:** All sensitive or personally identifiable information, including any company specific data, has been masked or removed. This project focuses solely on the data transformation process.
