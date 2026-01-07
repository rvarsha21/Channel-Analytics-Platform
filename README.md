# Channel-Analytics-Platform

### Project Overview

This project establishes an end-to-end data platform in Snowflake to analyze over 15,000 YouTube channels. It moves beyond simple reporting by implementing a full Medallion Architecture (Bronze, Silver, Gold) and integrating native AI components—specifically Snowflake Cortex for sentiment analysis and Natural Language Search—to democratize data access for non-technical stakeholders.

### Workflow

| Stage | Description | Key Tech |
| --- | --- | --- |
| **Data Ingestion (Bronze)** | Ingested raw YouTube API/CSV data into a landing zone, preserving original formatting for auditability.

 | SQL, Staging |
| **Data Modeling (Silver)** | Designed a Star Schema (Facts & Dimensions) and implemented **incremental loading** logic (CDC) to process only new records, reducing compute costs.

 | Snowflake, SQL |
| **AI Enrichment** | Applied Cortex AI SQL functions directly to raw text descriptions to generate sentiment scores and labels without external ETL tools.

 | Cortex AI |
| **Business Logic (Gold)** | Aggregated data into specialized tables for high-value metrics, such as "Efficiency Leaders" and "Market Portfolio" dominance.

 | SQL, DBT (logic) |
| **Analytics & UI** | Deployed a Streamlit dashboard for visualization and integrated **Cortex Analyst** to enable Text-to-SQL querying for business users.

 | Streamlit, Cortex Analyst |

### Objectives

* 
**Architect a Scalable Warehouse:** Build a robust three-layer data warehouse (Bronze, Silver, Gold) handling the complete lifecycle from ingestion to intelligence .


* 
**Optimize Data Freshness:** Implement automated incremental loading to append only new channel records, avoiding costly full-load refreshes.


* 
**Democratize Data Access:** Enable plain English querying (e.g., "Show top 10 channels") using Cortex Analyst to bridge the gap between raw data and business users.


* 
**Identify Market Efficiency:** Calculate custom KPIs to spot "Efficiency Leaders"—channels with high engagement relative to their subscriber base.



### Datasets

* 
**Source Data:** YouTube API Data / CSV exports.


* 
**Volume:** 15,830 channel records processed.


* **Data Model:**
* 
**Fact Table:** `FACT_CHANNEL_METRICS` (Views, Subscriber Counts, Video Counts) .


* 
**Dimension Tables:** `DIM_CHANNEL`, `DIM_COUNTRY`, `DIM_CATEGORY`.





### Key Analytical Features & Logic

* 
**Incremental Ingestion Logic:** Custom SQL logic identifies and appends only new records to the Silver layer, ensuring efficiency.


* 
**Sentiment Analysis:** Native AI SQL functions analyze channel descriptions to classify content tone (Positive/Neutral) directly within the warehouse.


* **Growth Classification:** Logic to categorize channels based on subscriber trends:
* *Rising:*  growth
* *Declining:*  growth
* 
*Stable:* Between -5% and 10% .




* 
**Efficiency Index:** A calculated metric identifying channels that "punch above their weight" by achieving high views-per-video relative to their subscriber size.
