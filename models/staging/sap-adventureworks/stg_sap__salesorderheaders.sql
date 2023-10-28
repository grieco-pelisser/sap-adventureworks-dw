with
    sales_ordersheader_source as (
        select
            cast(salesorderid as int) as order_id
            , cast(customerid as int) as order_customer_id
            , cast(salespersonid as int) as order_saleperson_id
            , cast(territoryid as int) as order_saleterritory_id
            , cast(billtoaddressid as int) as order_billtoadress_id
            , cast(shiptoaddressid as int) as order_shiptoaddress_id
            , cast(shipmethodid as int) as order_shipmethod_id
            , cast(creditcardid as int) as order_creditcard_id
            --, revisionnumber
            , date(orderdate) as order_date
            , date(duedate) as order_duedate
            , date(shipdate) as order_shipdate
            , cast(status as int) as order_status
            --, onlineorderflag
            --, purchaseordernumber
            --, accountnumber
            --, creditcardapprovalcode
            --, currencyrateid
            , cast(subtotal as decimal) as order_subtotal
            --, taxamt
            , cast(freight as decimal) as order_freight
            , cast(totaldue as decimal) as order_totaldue
            --, comment
            , cast(rowguid as string) as order_rowguide
            --, modifieddate
        from {{ source('sap', 'salesorderheader') }}
    )
select *
from sales_ordersheader_source