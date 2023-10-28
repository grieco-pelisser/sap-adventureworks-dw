with
    persons_source as (
        select
            cast(businessentityid as int) as business_entity_id
            , cast(persontype as string) as person_type
            --, namestyle 
            --, title 
            , cast(firstname as string) as first_name
            --, middlename 
            , cast(lastname as string) as last_name
            --, suffix  
            --, emailpromotion
            --, additionalcontactinfo
            --, demographics  
            --, rowguid  
            --, modifieddate  
        from {{ source('sap', 'person') }}
    )
select *
from persons_source