with
    orders_salereasons_source as (
        select
            cast(salesorderid as int) as order_id
            , cast(salesreasonid as int) as sale_reason_id
            , date(modifieddate) as modified_date
        from {{ source('sap', 'salesorderheadersalesreason') }}
    )
select *
    --count(*) as total_lines
from orders_salereasons_source
where sale_reason_id = 2