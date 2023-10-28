with
    stg_businessentity as (
        select *
        from {{ ref('stg_sap__businessentity') }}
    )

    , stg_persons as(
        select *
        from {{ ref('stg_sap__persons') }}
    )

    , stg_stores as (
        select *
        from {{ ref('stg_sap__stores') }}
    )

    , stg_address as (
        select *
        from {{ ref('int_person__address') }}
    )

    , stg_contacts as (
        select *
        from {{ ref('stg_sap__businessentitycontacts') }}
    )

    , join_tables as (
        select 
            stg_businessentity.businessentity_id
            , stg_address.address_id
            , stg_address.sk_address
            , stg_address.state_province_id
            , stg_address.territory_id
            , stg_stores.sale_person_id
            , stg_persons.person_type
            , stg_persons.first_name
            , stg_persons.last_name
            , stg_stores.store_name
            , stg_address.country_region_code
            , stg_address.adrres_line1
            , stg_address.address_city
            , stg_address.postal_code
            , stg_address.state_province_code
            , stg_address.is_stateprovince_country
            , stg_address.state_province_name
            , stg_address.country_region_name

        from stg_businessentity
        left join stg_persons on
            stg_businessentity.businessentity_id = stg_persons.business_entity_id
        left join stg_contacts on
            stg_businessentity.businessentity_id = stg_contacts.person_id
        left join stg_stores on
            stg_contacts.business_entity_id = stg_stores.business_entity_id
        left join stg_address on
            stg_businessentity.businessentity_id = stg_address.business_entity_id or
            stg_contacts.business_entity_id = stg_address.business_entity_id

        )

       , transmorf as (
            select
                *
                , case
                    when store_name is not null 
                    then first_name || ' ' || last_name || ' / ' || store_name
                    else first_name || ' ' || last_name 
                    end as businessentity_name
            from join_tables
        )

select
    *
from transmorf
order by businessentity_id desc