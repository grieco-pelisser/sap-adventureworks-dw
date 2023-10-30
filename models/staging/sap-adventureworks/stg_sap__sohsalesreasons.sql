with
    orders_salereasons_source as (
        select
            cast(salesorderid as int) as order_id
            , cast(salesreasonid as int) as sale_reason_id
            , date(modifieddate) as modified_date
        from {{ source('sap', 'salesorderheadersalesreason') }}
    )
select *
from orders_salereasons_source
