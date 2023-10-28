with
    sales_orderdetails_source as (
        select
            cast(salesorderid as int) as order_id
            , cast(salesorderdetailid as int) as orderdetail_id
            , cast(productid as int) as product_id
            , cast(specialofferid as int) as special_offer_id
            --, carriertrackingnumber
            , cast(orderqty as int) as order_quantity
            , cast(unitprice as decimal) as unit_price
            , cast(unitpricediscount as decimal) as unit_price_discount
            , cast(rowguid as string) as orderdetail_rowguide
            --, modifieddate
        from {{ source('sap', 'salesorderdetail') }}
     )
select *
from sales_orderdetails_source