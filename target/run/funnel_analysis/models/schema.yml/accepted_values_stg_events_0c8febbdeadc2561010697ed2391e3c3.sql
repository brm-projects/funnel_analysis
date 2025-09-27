
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        event_name as value_field,
        count(*) as n_records

    from `funnel-analysis-473408`.`analytics`.`stg_events`
    group by event_name

)

select *
from all_values
where value_field not in (
    'signup','profile_completed','kyc_passed','first_payment'
)



  
  
      
    ) dbt_internal_test