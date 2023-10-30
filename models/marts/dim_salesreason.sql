with
    stg_orderssalesreason as (
        select *
        from {{ ref('stg_sap__sohsalesreasons') }}
    )

    , stg_salesreason as(
        select *
        from {{ ref('stg_sap__salesreasons') }}
    )

    , join_tables as (
        select
            stg_orderssalesreason.order_id
            , stg_orderssalesreason.sale_reason_id
            , stg_salesreason.sale_reason_name
            , stg_salesreason.sale_reason_type
        from stg_orderssalesreason
        left join stg_salesreason on
            stg_orderssalesreason.sale_reason_id = stg_salesreason.sale_reason_id
        )

        , key_create as (
            select
                row_number() over(order by order_id) as pk_ordersalereason
                , *  
            from join_tables
        )

select *
from key_create
