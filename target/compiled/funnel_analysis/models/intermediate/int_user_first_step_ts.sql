-- find the first time each user hit each funnel step



select
  user_id,
  event_name,
  min(event_ts) as first_ts
from `funnel-analysis-473408`.`analytics`.`stg_events`
group by 1,2