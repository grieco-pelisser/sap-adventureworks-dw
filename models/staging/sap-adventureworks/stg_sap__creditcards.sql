with
    creditcards_source as (
        select
            cast(creditcardid as int) as creditcard_id
            , cast(cardtype as string) as creditcard_type
            , cast(cardnumber as int) as creditcard_number
            --, expmonth 
            --, expyear 
            --, modifieddate
        from {{ source('sap', 'creditcard') }}
    )
select *
from creditcards_source
