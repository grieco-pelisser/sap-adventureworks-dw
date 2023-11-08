with
    stg_orderheaders as (
        select *
        from {{ ref('stg_sap__salesorderheaders') }}
    )

    , stg_orderdetails as(
        select *
        from {{ ref('stg_sap__salesorderdetails') }}
    )

    , stg_creditcards as (
        select *
        from {{ ref('stg_sap__creditcards') }}
    )
    
    , stg_personcreditcards as (
        select *
        from {{ ref('stg_sap__personcreditcards') }}
    )
     
    , stg_specialoffers as (
        select *
        from {{ ref('stg_sap__specialoffers') }}
    )

    , join_tables as (
        select 
            stg_orderheaders.order_id
            , stg_orderdetails.orderdetail_id
            , stg_orderheaders.order_customer_id
            , stg_orderdetails.product_id
            , stg_orderdetails.special_offer_id
            , stg_orderheaders.order_saleperson_id
            , stg_orderheaders.order_saleterritory_id
            , stg_orderheaders.order_billtoadress_id
            , stg_orderheaders.order_shiptoaddress_id
            , stg_orderheaders.order_shipmethod_id
            , stg_personcreditcards.business_entity_id
            , stg_creditcards.creditcard_id
            , stg_creditcards.creditcard_type
            , stg_orderheaders.order_date
            , stg_orderheaders.order_duedate
            , stg_orderheaders.order_shipdate
            , stg_orderheaders.order_status
            , stg_orderheaders.order_subtotal
            , stg_orderheaders.order_freight
            , stg_orderheaders.order_totaldue
            , stg_orderdetails.order_quantity
            , stg_orderdetails.unit_price
            , stg_orderdetails.unit_price_discount
            , stg_specialoffers.specialoffer_description
            , stg_specialoffers.specialoffer_discount_pct
            , stg_specialoffers.specialoffer_type
            , stg_specialoffers.specialoffer_category
        from stg_orderdetails
        left join stg_orderheaders on
            stg_orderdetails.order_id = stg_orderheaders.order_id
        left join stg_creditcards on
            stg_orderheaders.order_creditcard_id = stg_creditcards.creditcard_id
        left join stg_personcreditcards on
            stg_creditcards.creditcard_id = stg_personcreditcards.creditcard_id
        left join stg_specialoffers on
            stg_orderdetails.special_offer_id = stg_specialoffers.special_offer_id
        )

select
    *
from join_tables
