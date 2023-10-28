with
    stg_businessentityaddresses as (
        select *
        from {{ ref('int_address_correction') }}
    )

    , stg_address as(
        select *
        from {{ ref('stg_sap__address') }}
    )

    , stg_stateprovinces as (
        select *
        from {{ ref('stg_sap__stateprovinces') }}
    )

    , stg_countryregions as (
        select *
        from {{ ref('stg_sap__countryregions') }}
    )

    , join_tables as (
        select 
            stg_businessentityaddresses.business_entity_id
            , stg_businessentityaddresses.address_id
            , stg_address.state_province_id
            , stg_stateprovinces.territory_id
            , stg_stateprovinces.country_region_code
            , stg_address.adrres_line1
            , stg_address.address_city
            , stg_address.postal_code
            , stg_stateprovinces.state_province_code
            , stg_stateprovinces.is_stateprovince_country
            , stg_stateprovinces.state_province_name
            , stg_countryregions.country_region_name
        from stg_businessentityaddresses
        left join stg_address on
            stg_businessentityaddresses.address_id = stg_address.address_id
        left join stg_stateprovinces on
            stg_address.state_province_id = stg_stateprovinces.state_province_id
        left join stg_countryregions on
            stg_stateprovinces.country_region_code = stg_countryregions.country_region_code
        )

       , key_create as (
            select
                cast(business_entity_id as string) || cast(address_id as string) as sk_address
                , *  
            from join_tables
       )

select 
    *
from key_create


