with
    person_creditcards_source as (
        select
            cast(businessentityid as int) as business_entity_id
            , cast(creditcardid as int) as creditcard_id   
            --, modifieddate
        from {{ source('sap', 'personcreditcard') }}
    )
select *
from person_creditcards_source