with
    stores_source as (
        select
            cast(businessentityid as int) as business_entity_id
            , cast(name as string) as store_name
            , cast(salespersonid as int) as sale_person_id
            --, demographics
            , cast(rowguid as string) as store_rowguide
            --, modifieddate  
        from {{ source('sap', 'store') }}
    )
select *
from stores_source