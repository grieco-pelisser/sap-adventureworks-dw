with
    salesterritories_source as (
        select
            cast(territoryid as int) as sale_territory_id
            , cast(name as string) as sale_territory_name
            , cast(countryregioncode as string) as country_region_code
            --, group 
            --, salesytd  
            --, saleslastyear
            --, costytd 
            --, costlastyear
            , cast(rowguid as string) as salesterritory_rowguide
            --, modifieddate 
        from {{ source('sap', 'salesterritory') }}
    )
select *
from salesterritories_source