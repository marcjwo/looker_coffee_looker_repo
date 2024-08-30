include: "/views/raw/customers.view.lkml"

# explore: customers {}

view: +customers {
  label: "Customers"
  fields_hidden_by_default: yes

  dimension: id {
    primary_key: yes
    label: "Customer ID"
    hidden: no
  }

  dimension: age {
    description: "Customer age"
    hidden: no
  }

  dimension: age_tier {
    label: "Age Tier"
    type: tier
    tiers: [0, 18, 25, 35, 45, 55]
    sql: ${age} ;;
    style: integer
  }

  dimension: gender {
    description: "Customer gender"
    hidden: no
  }

  dimension: first_name {
    description: "Customer first name"
    hidden: yes
  }

  dimension: last_name {
    description: "Customer last name"
    hidden: yes
  }

  dimension: full_name {
    description: "Customer fullname"
    hidden: no
    sql: CONCAT(${first_name}, ' ', ${last_name}) ;;
  }

  measure: count {
    description: "Customer count"
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

# view: customers {
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
