with
    product_subcategory_sources as (
        select
            cast(productsubcategoryid as int) as product_subcategory_id
            , cast(productcategoryid as int) as product_category_id
            , cast(name as string) as subcategory_name
            , cast(rowguid as string) as subcategory_rowguide
            --, modifieddate 
        from {{ source('sap', 'productsubcategory') }}
    )
select *
from product_subcategory_sources