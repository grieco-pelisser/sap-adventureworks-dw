with
    businessentity_sources as (
        select
            cast(businessentityid as int) as businessentity_id
            --, cast(rowguid as int) as 
            --, cast(modifieddate  as int) as 
        from {{ source('sap', 'businessentity') }}
    )
select *
from businessentity_sources
