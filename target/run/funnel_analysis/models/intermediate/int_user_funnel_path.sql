

  create or replace view `funnel-analysis-473408`.`analytics`.`int_user_funnel_path`
  OPTIONS()
  as -- reshape into one row per user with a timestamp column for each step.



with s as (select * from `funnel-analysis-473408`.`analytics`.`int_user_first_step_ts`)

select
  user_id,
  max(if(event_name='signup',            first_ts, null)) as ts_signup,
  max(if(event_name='profile_completed', first_ts, null)) as ts_profile_completed,
  max(if(event_name='kyc_passed',        first_ts, null)) as ts_kyc_passed,
  max(if(event_name='first_payment',     first_ts, null)) as ts_first_payment
from s
group by 1;

