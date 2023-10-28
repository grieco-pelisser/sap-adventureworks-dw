with
    addresses_source as (
        select
            cast(addressid as int) as address_id
            , cast(stateprovinceid as int) as state_province_id
            , cast(addressline1 as string) as adrres_line1
            , cast(city as string) as address_city
            , cast(postalcode as string) as postal_code
            , cast(rowguid as string) as address_rowguide
            --, modifieddate
            --, addressline2
            --, spatiallocation
        from {{ source('sap', 'address') }}
    )
select *
from addresses_source