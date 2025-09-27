

  create or replace view `funnel-analysis-473408`.`analytics`.`stg_events`
  OPTIONS()
  as --clean & standardize the raw seed (analytics.events) so types/text are consistent.



with raw as (
  select
    cast(user_id as int64)                              as user_id,
    timestamp(event_time)                               as event_ts,
    lower(event_name)                                   as event_name,
    cast(step as int64)                                 as step,
    lower(source)                                       as source,
    upper(country)                                      as country
  from `funnel-analysis-473408`.`analytics`.`events`   -- the seeded CSV table
  where lower(event_name) in ('signup','profile_completed','kyc_passed','first_payment')
)
select * from raw;

