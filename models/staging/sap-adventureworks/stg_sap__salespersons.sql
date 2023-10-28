with
    salesperson_sources as (
        select
            cast(businessentityid as int) as business_entity_id
            , cast(territoryid as int) as saleperson_territory_id
            , cast(salesquota as decimal) as saleperson_quota
            , cast(bonus as decimal) as saleperson_bonus
            , cast(commissionpct as decimal) as saleperson_comissionpct
            , cast(salesytd as decimal) as total_sale_todate
            , cast(saleslastyear as decimal) as sales_lastyear
            , cast(rowguid as string) as saleperson_rowguide
            --, modifieddate
        from {{ source('sap', 'salesperson') }}
    )
select *
from salesperson_sources