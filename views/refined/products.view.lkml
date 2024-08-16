include: "/views/raw/products.view.lkml"

view: +products {
  label: "Products"
  fields_hidden_by_default: yes

  dimension: id {
    description: "Product ID"
    primary_key: yes
    hidden: no
  }

  dimension: name {
    description: "Product name"
    hidden: no
  }
  dimension: brand {
    description: "Product brand"
    hidden: no
  }
  dimension: category {
    description: "Product category"
    hidden: no
  }
  dimension: size {
    description: "Product serving size"
    hidden: no
  }
  dimension: country_of_origin {
    description: "Product country of origin"
    hidden: no
  }
  dimension: cost {
    description: "Product costs"
    hidden: no
  }
  dimension: price {
    description: "Product retail price"
    hidden: no
  }
  # measure: total_cost {
  #   description: "Total aggregated product costs"
  #   hidden: no
  #   type: sum
  #   sql: ${cost} ;;
  # }
  # measure: total_sales {
  #   description: "Total aggregated product sales"
  #   hidden: no
  #   type: sum
  #   sql: ${price} ;;
  # }

  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: products {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
