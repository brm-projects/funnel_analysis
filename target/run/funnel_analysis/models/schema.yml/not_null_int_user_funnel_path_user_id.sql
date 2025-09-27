
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select user_id
from `funnel-analysis-473408`.`analytics`.`int_user_funnel_path`
where user_id is null



  
  
      
    ) dbt_internal_test