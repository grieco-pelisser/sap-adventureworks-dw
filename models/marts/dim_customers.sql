with
    stg_customers as (
        select *
        from {{ ref('stg_sap__customers') }}
    )

    , stg_businessentity as(
        select *
        from {{ ref('int_person__businessentity') }}
    )

    , join_tables as (
        select 
            stg_customers.customer_id
            , stg_customers.person_id
            , stg_customers.store_id
            , stg_customers.territory_id
            , stg_businessentity.address_id
            , stg_businessentity.sk_address
            , stg_businessentity.state_province_id
            , stg_businessentity.person_type
            , stg_businessentity.first_name
            , stg_businessentity.last_name
            , stg_businessentity.store_name
            , stg_businessentity.country_region_code
            , stg_businessentity.adrres_line1
            , stg_businessentity.address_city
            , stg_businessentity.postal_code
            , stg_businessentity.state_province_code
            , stg_businessentity.is_stateprovince_country
            , stg_businessentity.state_province_name
            , stg_businessentity.country_region_name
            , stg_businessentity.businessentity_name
        from stg_customers
        left join stg_businessentity on
            stg_customers.person_id = stg_businessentity.businessentity_id 
        )

        , key_create as (
            select
                row_number() over(order by customer_id) as pk_customer
                ,  *
            from join_tables
        )

select 
    *
from key_create
order by customer_id desc
