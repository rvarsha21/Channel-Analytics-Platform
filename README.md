# Channel Analytics Platform

## Project Overview

This project establishes a scalable, end-to-end data platform in Snowflake to analyze over 15,000 YouTube channels. Moving beyond traditional ETL, this solution implements a robust Medallion Architecture (Bronze, Silver, Gold) and leverages Snowflake’s native AI capabilities—specifically Cortex AI for sentiment analysis and Cortex Analyst for Text-to-SQL search—to democratize data access and uncover actionable content strategies.

## Workflow

| Stage | Description | 
| :--- | :--- |
| **Data Ingestion (Bronze)** | Ingested raw YouTube API/CSV data into a landing zone, preserving original formatting for auditability and lineage. 
| **Data Modeling (Silver)** | Designed a Star Schema (Facts & Dimensions) and implemented **incremental loading** logic to process only new records, reducing compute costs and ensuring freshness. 
| **AI Enrichment** | Applied Cortex AI SQL functions directly to raw text descriptions to generate sentiment scores (Positive/Neutral) without external ETL tools. 
| **Business Logic (Gold)** | Aggregated data into specialized tables for high-value metrics, identifying "Efficiency Leaders" and calculating market dominance. 
| **Analytics & UI** | Deployed a Streamlit dashboard for visualization and integrated **Cortex Analyst** to enable natural language querying for business users. 

## Objectives

* **Architect a Modern Data Warehouse:** Build a complete data lifecycle system from raw ingestion to business intelligence using the Bronze-Silver-Gold methodology.
* **Optimize Data Pipelines:** Implement automated incremental loading (Change Data Capture) to append only new channel records, avoiding costly full-load refreshes.
* **Democratize Data Access:** Bridge the gap between raw data and stakeholders by enabling plain English querying (e.g., "Show top 10 channels") using Cortex Analyst.
* **Identify Content Efficiency:** Develop custom KPIs to spot channels that achieve high view counts relative to their subscriber base, identifying high-ROI partnership targets.

## Datasets

* **Primary Source:** YouTube API Data / CSV Exports.
* **Volume:** 15,830+ Channel Records.
* **Data Model Structure:**
    * **Fact Table:** `FACT_CHANNEL_METRICS` (Key metrics: View Count, Subscriber Count, Video Count).
    * **Dimension Tables:** `DIM_CHANNEL`, `DIM_COUNTRY`, `DIM_CATEGORY`.

## Business Logic & AI Capabilities

### 1. Incremental Ingestion Strategy
Instead of full reloads, the system uses custom SQL logic to identify new records based on `Channel_ID` and appends them to the Silver layer, ensuring the warehouse remains up-to-date efficiently.

### 2. Native AI Sentiment Analysis
Utilized `SNOWFLAKE.CORTEX` functions on the description column to auto-classify channel tone.
* **Input:** Raw channel description text.
* **Output:** Sentiment Score & Label (Positive, Neutral, Negative).

### 3. Growth & Efficiency Classification
Custom logic applied in the Gold Layer to categorize channel performance:
* **Growth Label:** Categorizes channels as *Rising* (≥10% growth), *Declining* (≤-5%), or *Stable*.
* **Efficiency Index:** Calculates "Views Per Subscriber" to identify smaller channels with highly active audiences.

## Dashboard Visualizations

* **Top Performers:** Dynamic filtering of top channels by country and category.
* **Efficiency Scatterplot:** Visualizing Subscribers vs. Views per Video to find outliers "punching above their weight".
* **Market Distribution:** Analyzing the "Tiny vs. Giants" skew, highlighting the dominance of Mega channels (>10M subs) vs. Emerging creators.
