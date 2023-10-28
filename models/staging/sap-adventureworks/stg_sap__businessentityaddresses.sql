with
    businessentity_address_sources as (
        select
            cast(businessentityid as int) as business_entity_id
            , cast(addressid as int) as address_id
            , cast(rowguid as string) as businessentity_rowguide
            --, addresstypeid
            --, modifieddate 
        from {{ source('sap', 'businessentityaddress') }}
    )
select *
from businessentity_address_sources