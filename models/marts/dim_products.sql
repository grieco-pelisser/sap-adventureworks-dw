with
    stg_products as (
        select *
        from {{ ref('stg_sap__products') }}
    )

    , stg_subcategories as(
        select *
        from {{ ref('stg_sap__productsubcategories') }}
    )

    , stg_categories as (
        select *
        from {{ ref('stg_sap__productcategories') }}
    )

    , join_tables as (
        select 
            stg_products.product_id
            , stg_subcategories.product_subcategory_id
            , stg_categories.product_category_id
            , stg_products.product_model_id
            , stg_products.product_name
            , stg_subcategories.subcategory_name
            , stg_categories.category_name
            , stg_products.product_number
            , stg_products.is_product_salable
            , stg_products.product_standardcost
            , stg_products.product_sellstart_date
            , stg_products.product_size
            , stg_products.size_unitmeasure_code
            , stg_products.weight_unitmeasure_code
            , stg_products.product_weight
            , stg_products.days_to_manufacture
            , stg_products.product_line
            , stg_products.product_class
            , stg_products.product_style
        from stg_products
        left join stg_subcategories on
            stg_products.product_subcategory_id = stg_subcategories.product_subcategory_id
        left join stg_categories on
            stg_subcategories.product_category_id = stg_categories.product_category_id
        )

        , key_create as (
            select
                row_number() over(order by product_id) as pk_product
                , *  
            from join_tables
        )

select *
from key_create