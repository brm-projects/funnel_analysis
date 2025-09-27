
  
    

    create or replace table `funnel-analysis-473408`.`analytics`.`fct_funnel_conversions`
      
    
    

    
    OPTIONS()
    as (
      -- overall counts and conversion rates from step to step and end-to-end.



with path as (select * from `funnel-analysis-473408`.`analytics`.`int_user_funnel_path`)

select
  countif(ts_signup is not null)            as n_signup,
  countif(ts_profile_completed is not null) as n_profile_completed,
  countif(ts_kyc_passed is not null)        as n_kyc_passed,
  countif(ts_first_payment is not null)     as n_first_payment,

  safe_divide(countif(ts_profile_completed is not null), countif(ts_signup is not null))          as cr_signup_to_profile,
  safe_divide(countif(ts_kyc_passed is not null),        countif(ts_profile_completed is not null)) as cr_profile_to_kyc,
  safe_divide(countif(ts_first_payment is not null),     countif(ts_kyc_passed is not null))        as cr_kyc_to_payment,
  safe_divide(countif(ts_first_payment is not null),     countif(ts_signup is not null))             as cr_signup_to_payment
from path
    );
  