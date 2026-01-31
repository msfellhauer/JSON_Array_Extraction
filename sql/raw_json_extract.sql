-- =============================================================================
-- Project: Snowflake JSON Transformation
-- File: raw_json_extract.sql
-- Author: Mark F.
-- Created: 2026-01-31
-- 
-- Description:
--   This SQL script creates or replaces a flattened, production-ready table
--   in Snowflake from nested JSON data stored in the Bronze layer.
--   It demonstrates an ETL-like transformation: 
--     - Extracts fields from nested JSON
--     - Casts to appropriate Snowflake types
--     - Handles arrays using lateral flatten
--     - Produces a “Silver/production” table ready for analytics
--
--   Use case in analytics engineering:
--     - Supports dashboards, aggregations, and modeling
--     - Optimized for query performance via clustering
--
-- Cluster Strategy:
--   The table is clustered by "date" to improve query performance
--   for time-based filters and aggregations.
-- =============================================================================

create or replace table Snowflake_Schema.Raw_JSON_Extract
(
    reference_number varchar,
    date date,
    type string,
    experience string,
    created_by string,
    status string,
    login_method string,
    export_date date,
    amount number,
    purpose string,
    rate string,
    position string,
    term string,
    created_date datetime,
    address_county string,
    pull_date date,
    pull_type string,
    consent_date date,
    consent_status string,
    assignee string,
    state string
)
cluster by (date)
as
select
    cast(detail:referencenumber as varchar) as reference_number,
    cast(app:updateddatetime as date) as date,
    cast(detail:solutiontype as string) as type,
    cast(detail:experiencetype as string) as experience,
    cast(c.this:type as string) as created_by,
    cast(detail:Status as string) as status,
    cast(people.value.loginmethod as string) as login_method,
    cast(detail.exportdate as date) as export_date,
    cast(detail.amount as number) as amount,
    cast(detail.purposetype as string) as purpose,
    cast(detail.rate as string) as rate,
    cast(detail.prioritytype as string) as position,
    cast(detail.termmonths as string) as term,
    cast(date_trunc('second', convert_timezone('America/Los_Angeles', detail:createddate)) as datetime) as created_date,
    cast(add:countyname as string) as address_county,
    cast(e.this:pulldate as date) as pull_date,
    cast(e.this:pulltype as string) as pull_type,
    cast(e.this.date as date) as consent_date,
    cast(consumer.this:status as string) as consent_status,
    cast(asignees.role:role as string) as assignee,
    cast(detail:state as string) as state
from Snowflake_Schema.Prod_Bronze_Level.JSON
    lateral flatten(input => detail:people) as people,
    lateral flatten(input => detail:asignees) as asignees,
    lateral flatten(input => people.value:consumer) as consumer,
    lateral flatten(input => people.value.consent) as e,
    lateral flatten(input => detail:created) as c,
    lateral flatten(input => a.value:address) as add;
