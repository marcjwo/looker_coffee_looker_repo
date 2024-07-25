include: "/views/raw/orders.view.lkml"
view: +orders {
  label: "Orders"
  fields_hidden_by_default: yes

  dimension: id {
    description: "Order ID"
    label: "Order ID"
    hidden: no
  }

  dimension_group: created_datetime {
    label: "Created"
    type: time
    description: "Date and time the order was placed"
    hidden: no
    timeframes: [date, month_name,month, year, quarter, week, day_of_week, raw]
  }

  dimension_group: completed_datetime {
    label: "Completed"
    type: time
    description: "Date and time the order was completed"
    hidden: no
    timeframes: [date, month_name, month, year, quarter, week, day_of_week, raw]
  }

  dimension_group: completion {
    description: "Time to complete order"
    label: "Order Completion"
    hidden: no
    type: duration
    sql_start: ${created_datetime_raw} ;;
    sql_end: ${completed_datetime_raw} ;;
    intervals: [minute]
  }

  dimension: customer_id {
    description: "Customer that issued the order, can be null"
    hidden: no
  }

  dimension: order_type {
    description: "Type of order, dine in or take away"
    hidden: no
    sql: CASE WHEN ${dine_in} THEN "Dine-in" ELSE "Takeaway" END ;;
  }

  # dimension_group: time_since_location_was_founded  {
  #   hidden: no
  #   description: "Duration sincelocation that receives the order has existed"
  #   # label: "Days Since Location Exists"
  #   type: duration
  #   intervals: []
  #   sql_start: ${locations.founding_date} ;;
  #   sql_end: ${created_datetime_date} ;;
  # }

  dimension: time_since_location_was_founded  {
    hidden: no
    description: "Duration since location that receives the order has existed"
    label: "Months Since Location Exists"
    type: number
    sql: DATE_DIFF(${created_datetime_date},${locations.founding_date}, MONTH) ;;
  }

  measure: average_order_completion_duration {
    type: average
    description: "Average time to complete order in minutes"
    hidden: no
    sql: ${minutes_completion} ;;
  }

  measure: count {
    description: "Total Order Count"
    label: "Total Order Count"
    hidden: no
  }

  measure: first_order {
    type: date_date
    hidden: no
    sql: MIN(${created_datetime_date}) ;;
  }

  measure: last_order {
    type: date_date
    hidden: no
    sql: MAX(${created_datetime_date}) ;;
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

# view: orders {
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
