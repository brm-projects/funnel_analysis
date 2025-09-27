-- find the first time each user hit each funnel step

{{ config(materialized='view') }}

select
  user_id,
  event_name,
  min(event_ts) as first_ts
from {{ ref('stg_events') }}
group by 1,2;
