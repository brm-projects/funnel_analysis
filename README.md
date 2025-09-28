# Funnel Analysis with dbt + BigQuery

This project demonstrates how to build an **end-to-end analytics workflow** for user funnel analysis, from raw events to business insights.

## Project Overview
We analyze a typical product growth funnel with 4 steps:

1. **Signup**
2. **Profile Completed**
3. **KYC Passed**
4. **First Payment**

The objective is to identify **where users drop off**, and to analyze differences by **acquisition channel, cohort, and geography**.

## Tech Stack
- **Python** → generate synthetic seed data (`events.csv`)
- **dbt** → transform raw events into clean, business-ready models
- **BigQuery (Google Cloud)** → data warehouse
- **Dashboard (Looker)** (ongoing)

## Repository Structure
- seeds/
- events.csv # Synthetic event data
- models/
- staging/ # Raw events cleaned (views)
- intermediate/ # Funnel path logic (views)
- marts/ # Business-ready facts (tables)
- schema.yml # Tests (nulls, accepted values)


## Dashboard (ongoing)

The dashboard walks through:
- **Funnel Overview** → conversion rates at each step
- **By Acquisition Source** → Ads vs Organic vs Partner
- **Cohort Analysis** → conversions over time
- **Geography** → country-level drop-offs


## Reproducibility
To reproduce locally:
```bash
# Install dependencies
pip install dbt-bigquery

# Run seeds (load events into BigQuery)
dbt seed

# Build models
dbt run

# Run tests
dbt test

