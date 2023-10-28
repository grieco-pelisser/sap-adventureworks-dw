with
    sales_in_2011 as (
        select sum(total_cost) as cost_total_sale
        from {{ ref('fct_orders') }}
        where order_date between '2011-01-01' and '2011-12-31'
    )

select cost_total_sale
from sales_in_2011
where cost_total_sale not between 12646112 and 12646113