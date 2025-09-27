-- conversion broken down by acquisition source (e.g., ads, organic, partner).

{{ config(materialized='table') }}

with e as (select * from {{ ref('stg_events') }}),

firsts as (
  select user_id, min(event_ts) as signup_ts
  from e
  where event_name='signup'
  group by 1
),

source_at_signup as (
  -- source captured at the signup moment
  select f.user_id, any_value(e.source) as source
  from firsts f
  join e using (user_id)
  where e.event_name='signup' and e.event_ts = f.signup_ts
  group by f.user_id
),

path as (select * from {{ ref('int_user_funnel_path') }}),

joined as (
  select p.*, s.source
  from path p
  left join source_at_signup s using (user_id)
)

select
  source,
  countif(ts_signup is not null)            as n_signup,
  countif(ts_profile_completed is not null) as n_profile_completed,
  countif(ts_kyc_passed is not null)        as n_kyc_passed,
  countif(ts_first_payment is not null)     as n_first_payment,

  safe_divide(countif(ts_profile_completed is not null), countif(ts_signup is not null))            as cr_signup_to_profile,
  safe_divide(countif(ts_kyc_passed is not null),        countif(ts_profile_completed is not null)) as cr_profile_to_kyc,
  safe_divide(countif(ts_first_payment is not null),     countif(ts_kyc_passed is not null))        as cr_kyc_to_payment,
  safe_divide(countif(ts_first_payment is not null),     countif(ts_signup is not null))             as cr_signup_to_payment
from joined
group by source
order by source;
