with
    businessentity_contacts_source as (
        select
            cast(businessentityid as int) as business_entity_id
            , cast(personid as int) as person_id
            --, contacttypeid
            , cast(rowguid as string) as businessentitycontact_rowguide
            --, modifieddate
        from {{ source('sap', 'businessentitycontact') }}
    )
select *
from businessentity_contacts_source