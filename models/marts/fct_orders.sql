with
    dim_products as(
        select*
        from {{ ref('dim_products') }}
    )

    , dim_customers as (
        select *
        from {{ ref('dim_customers') }}
    )

    , orders_products as (
        select *
        from {{ ref('int_sales__orders') }}
    )

    , join_tables as (
        select 
            orders_products.order_id
            , orders_products.orderdetail_id
            , orders_products.order_customer_id
            , dim_customers.pk_customer
            , dim_products.pk_product
            , orders_products.product_id
            , orders_products.special_offer_id
            , orders_products.order_saleperson_id
            , dim_customers.store_id
            , dim_customers.person_id
            , dim_customers.territory_id
            , dim_customers.address_id
            , orders_products.order_saleterritory_id
            , orders_products.order_billtoadress_id
            , orders_products.order_shiptoaddress_id
            , orders_products.order_shipmethod_id
            , orders_products.creditcard_id
            , orders_products.creditcard_type
            , orders_products.order_date
            , orders_products.order_duedate
            , orders_products.order_shipdate
            , orders_products.order_status
            , orders_products.order_subtotal
            , orders_products.order_freight
            , orders_products.order_totaldue
            , orders_products.order_quantity
            , orders_products.unit_price
            , orders_products.unit_price_discount
            , orders_products.specialoffer_description
            , orders_products.specialoffer_discount_pct
            , orders_products.specialoffer_type
            , orders_products.specialoffer_category
            , dim_products.product_subcategory_id
            , dim_products.product_category_id
            , dim_products.product_model_id
            , dim_products.product_name
            , dim_products.subcategory_name
            , dim_products.category_name
            , dim_products.product_number
            , dim_products.is_product_salable
            , dim_products.product_standardcost
            , dim_products.product_sellstart_date
            , dim_products.product_size
            , dim_products.size_unitmeasure_code
            , dim_products.weight_unitmeasure_code
            , dim_products.product_weight
            , dim_products.days_to_manufacture
            , dim_products.product_line
            , dim_products.product_class
            , dim_products.product_style
            , dim_customers.state_province_id
            , dim_customers.person_type
            , dim_customers.country_region_code
            , dim_customers.adrres_line1
            , dim_customers.address_city
            , dim_customers.postal_code
            , dim_customers.state_province_code
            , dim_customers.is_stateprovince_country
            , dim_customers.state_province_name
            , dim_customers.country_region_name
            , dim_customers.businessentity_name
        from orders_products
            left join dim_products on
                orders_products.product_id = dim_products.product_id
            left join dim_customers on 
                orders_products.order_customer_id = dim_customers.customer_id
    )

    , transformations_01 as (
        select
            *
            , unit_price * order_quantity as total_cost
            , (1 - specialoffer_discount_pct) * unit_price * order_quantity as net_cost
            , case 
                when specialoffer_discount_pct > 0 then true
                when specialoffer_discount_pct = 0 then false
                else false
            end as is_discount
            , order_freight / count(order_id) over(partition by order_id) as avg_freightcost
        from join_tables
    )

    , transformations_02 as (
        select
            cast(order_id as string) || cast(orderdetail_id as string) as sk_order
            , *
            , case
                when order_status = 1
                    then 'in process'
                when order_status = 2 
                    then 'approved'
                when order_status = 3
                    then 'backordered'
                when order_status = 4
                    then 'rejected'
                when order_status = 5
                    then 'shipped'
                when order_status = 6
                    then 'cancelled'
                end as status_update
        from transformations_01
    )

select *
from transformations_02

