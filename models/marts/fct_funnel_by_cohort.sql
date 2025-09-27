-- conversion by signup cohort (month of signup).

{{ config(materialized='table') }}

with e as (select * from {{ ref('stg_events') }}),

signup as (
  select user_id, min(event_ts) as signup_ts
  from e
  where event_name='signup'
  group by 1
),

path as (select * from {{ ref('int_user_funnel_path') }}),

joined as (
  select
    p.*,
    timestamp_trunc(s.signup_ts, month) as signup_month
  from path p
  left join signup s using (user_id)
)

select
  signup_month,
  countif(ts_signup is not null)            as n_signup,
  countif(ts_profile_completed is not null) as n_profile_completed,
  countif(ts_kyc_passed is not null)        as n_kyc_passed,
  countif(ts_first_payment is not null)     as n_first_payment
from joined
group by signup_month
order by signup_month;
