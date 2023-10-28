with
    product_category_source as (
        select
        cast(productcategoryid as int) as product_category_id
        , cast(name as string) as category_name
        , cast(rowguid as string) as category_rowguid
        --, modifieddate
        from {{ source('sap', 'productcategory') }}
    )
select *
from product_category_source    