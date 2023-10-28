with
    sales_reason_source as (
        select
            cast(salesreasonid as int) as sale_reason_id
            , cast(name as string) as sale_reason_name
            , cast(reasontype as string) as sale_reason_type
            --, modifieddate 
        from {{ source('sap', 'salesreason') }}
    )
select *
from sales_reason_source