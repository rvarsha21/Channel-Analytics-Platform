# Channel Analytics Platform

## Project Overview

[cite_start]This project establishes a scalable, end-to-end data platform in Snowflake to analyze over 15,000 YouTube channels[cite: 8, 33]. [cite_start]Moving beyond traditional ETL, this solution implements a robust Medallion Architecture (Bronze, Silver, Gold) and leverages Snowflake’s native AI capabilities—specifically Cortex AI for sentiment analysis and Cortex Analyst for Text-to-SQL search—to democratize data access and uncover actionable content strategies[cite: 55, 135, 204].

## Workflow

| Stage | Description | Tech Stack |
| :--- | :--- | :--- |
| **Data Ingestion (Bronze)** | [cite_start]Ingested raw YouTube API/CSV data into a landing zone, preserving original formatting for auditability and lineage[cite: 10, 19]. | Snowflake SQL, Staging |
| **Data Modeling (Silver)** | [cite_start]Designed a Star Schema (Facts & Dimensions) and implemented **incremental loading** logic to process only new records, reducing compute costs and ensuring freshness[cite: 11, 39, 187]. | Snowflake, SQL |
| **AI Enrichment** | [cite_start]Applied Cortex AI SQL functions directly to raw text descriptions to generate sentiment scores (Positive/Neutral) without external ETL tools[cite: 55, 57]. | Snowflake Cortex AI |
| **Business Logic (Gold)** | [cite_start]Aggregated data into specialized tables for high-value metrics, identifying "Efficiency Leaders" and calculating market dominance[cite: 275, 283]. | SQL, DBT |
| **Analytics & UI** | [cite_start]Deployed a Streamlit dashboard for visualization and integrated **Cortex Analyst** to enable natural language querying for business users[cite: 16, 204]. | Streamlit, Cortex Analyst |

## Objectives

* [cite_start]**Architect a Modern Data Warehouse:** Build a complete data lifecycle system from raw ingestion to business intelligence using the Bronze-Silver-Gold methodology [cite: 9, 10-14].
* [cite_start]**Optimize Data Pipelines:** Implement automated incremental loading (Change Data Capture) to append only new channel records, avoiding costly full-load refreshes[cite: 35, 39].
* [cite_start]**Democratize Data Access:** Bridge the gap between raw data and stakeholders by enabling plain English querying (e.g., "Show top 10 channels") using Cortex Analyst[cite: 203, 204].
* [cite_start]**Identify Content Efficiency:** Develop custom KPIs to spot channels that achieve high view counts relative to their subscriber base, identifying high-ROI partnership targets[cite: 283, 357].

## Datasets

* **Primary Source:** YouTube API Data / CSV Exports.
* [cite_start]**Volume:** 15,830+ Channel Records[cite: 33].
* **Data Model Structure:**
    * [cite_start]**Fact Table:** `FACT_CHANNEL_METRICS` (Key metrics: View Count, Subscriber Count, Video Count)[cite: 193].
    * [cite_start]**Dimension Tables:** `DIM_CHANNEL`, `DIM_COUNTRY`, `DIM_CATEGORY`[cite: 190, 192, 198].

## Business Logic & AI Capabilities

### 1. Incremental Ingestion Strategy
[cite_start]Instead of full reloads, the system uses custom SQL logic to identify new records based on `Channel_ID` and appends them to the Silver layer, ensuring the warehouse remains up-to-date efficiently[cite: 39, 54].

### 2. Native AI Sentiment Analysis
Utilized `SNOWFLAKE.CORTEX` functions on the description column to auto-classify channel tone.
* **Input:** Raw channel description text.
* [cite_start]**Output:** Sentiment Score & Label (Positive, Neutral, Negative) [cite: 55-57].

### 3. Growth & Efficiency Classification
Custom logic applied in the Gold Layer to categorize channel performance:
* [cite_start]**Growth Label:** Categorizes channels as *Rising* (≥10% growth), *Declining* (≤-5%), or *Stable* [cite: 289-293].
* [cite_start]**Efficiency Index:** Calculates "Views Per Subscriber" to identify smaller channels with highly active audiences[cite: 283, 376].

## Dashboard Visualizations

* [cite_start]**Top Performers:** Dynamic filtering of top channels by country and category[cite: 294].
* [cite_start]**Efficiency Scatterplot:** Visualizing Subscribers vs. Views per Video to find outliers "punching above their weight"[cite: 358, 376].
* [cite_start]**Market Distribution:** Analyzing the "Tiny vs. Giants" skew, highlighting the dominance of Mega channels (>10M subs) vs. Emerging creators[cite: 436, 452].
