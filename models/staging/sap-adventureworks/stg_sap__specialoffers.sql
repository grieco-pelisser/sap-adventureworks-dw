with
    special_offers_source as (
        select
            cast(specialofferid as int) as special_offer_id
            , cast(description as string) as specialoffer_description
            , cast(discountpct as decimal) as specialoffer_discount_pct
            , cast(type as string) as specialoffer_type
            , cast(category as string) as specialoffer_category
            --, startdate
            --, enddate 
            --, minqty 
            --, maxqty  
            , cast(rowguid as string) as specialoffer_rowguide
            --, modifieddate 
        from {{ source('sap', 'specialoffer') }}
    )
select *
from special_offers_source