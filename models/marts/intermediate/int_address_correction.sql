with
    stg_address as (
        select 
            business_entity_id
            , address_id
            , row_number() over (partition by business_entity_id order by address_id desc) as rownum
        from {{ ref('stg_sap__businessentityaddresses') }}
    )
    , address_sources as (
        select 
            business_entity_id
            , address_id
        from stg_address
        where rownum = 1
    )

select 
    *
from address_sources