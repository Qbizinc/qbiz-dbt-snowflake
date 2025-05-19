
    
    

select
    hash_key as unique_field,
    count(*) as n_records

from SANDBOX_DATA_PIPELINE.bronze.tpcds_customer
where hash_key is not null
group by hash_key
having count(*) > 1


