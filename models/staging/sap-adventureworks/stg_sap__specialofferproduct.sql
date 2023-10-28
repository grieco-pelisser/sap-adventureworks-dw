with
    specialoffer_products_source as (
        select
            cast(specialofferid as int) as special_offer_id
            , cast(productid as int) as product_id
            , cast(rowguid as string) as specialorderproduct_rowguide
            --, modifieddate
        from {{ source('sap', 'specialofferproduct') }}
    )
select *
from specialoffer_products_source