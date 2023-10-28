with
    state_provinces_source as (
        select
            cast(stateprovinceid as int) as state_province_id
            , cast(territoryid as int) as territory_id
            , cast(stateprovincecode as string) as state_province_code
            , cast(countryregioncode as string) as country_region_code
            , cast(isonlystateprovinceflag as string) as is_stateprovince_country
            , cast(name as string) as state_province_name
            , cast(rowguid as string) as state_province_rowguide
            --, modifieddate
        from {{ source('sap', 'stateprovince') }}
    )
select *
from state_provinces_source
