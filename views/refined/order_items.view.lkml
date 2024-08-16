include: "/views/raw/order_items.view.lkml"

view: +order_items {
  label: "Orders"
  fields_hidden_by_default: yes

  dimension: id {
    label: "Order Item ID"
    primary_key: yes
    hidden: no
  }

  dimension: item_price {
    description: "Items price"
    hidden: yes
    label: "Item price"
    sql: ${products.price} ;;
  }

  dimension: item_cost  {
    description: "Item cost"
    hidden: yes
    label: "Item cost"
    sql: ${products.cost} ;;
  }

  dimension: item_margin {
    description: "Item margin"
    hidden: yes
    label: "Item margin"
    sql: ${item_price}-${item_cost} ;;
  }

  measure: total_sales {
    description: "Total Sales"
    hidden: no
    label: "Total Sales"
    sql: ${item_price} ;;
    type: sum
    value_format_name: usd
  }

  measure: average_sales {
    description: "Average Sales"
    hidden: no
    label: "Average Sales"
    sql: ${item_price} ;;
    type: average
    value_format_name: usd
  }

  measure: total_cost {
    description: "Total Cost"
    hidden: no
    label: "Total Cost"
    sql: ${item_cost} ;;
    type: sum
    value_format_name: usd
  }

  measure: average_cost {
    description: "Average Cost"
    hidden: no
    label: "Average Cost"
    sql: ${item_cost} ;;
    type: sum
    value_format_name: usd
  }

  measure: total_margin {
    description: "Total Margin"
    hidden: no
    label: "Total Margin"
    sql: ${item_margin} ;;
    type: sum
    value_format_name: usd
  }

  measure: average_margin {
    description: "Average Margin"
    hidden: no
    label: "Average Margin"
    sql: ${item_margin} ;;
    type: average
    value_format_name: usd
  }

  measure: count {
    description: "Order Item Count"
    label: "Total Order Items"
    hidden: no
  }
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

# view: order_items {
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
