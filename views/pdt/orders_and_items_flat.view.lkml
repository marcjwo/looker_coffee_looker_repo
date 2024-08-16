# If necessary, uncomment the line below to include explore_source.
# include: "orders.explore.lkml"
include: "/views/refined/*.*"

# explore: orders_and_items_test {
#   from:orders_and_items
#   join: customers {
#     sql_on: ${customers.id} = ${orders_and_items_test.customer_id};;
#     type: left_outer
#     relationship: many_to_one
#   }
# }

view: orders_and_items {
  fields_hidden_by_default: yes
  derived_table: {
    partition_keys: ["created"]
    cluster_keys: ["division_id","location_id","order_type","category"]
    datagroup_trigger: looker_coffee_default_datagroup
    explore_source: order_items {
      column: company_id {field: companies.id}
      column: location_id {field: locations.id}
      column: division_id {field: divisions.id}
      column: order_id { field: orders.id }
      column: order_type { field: orders.order_type }
      column: customer_id { field: orders.customer_id }
      column: created { field: orders.created_datetime_raw }
      column: completed { field: orders.completed_datetime_raw }
      column: name { field: products.name }
      column: price { field: products.price }
      column: size { field: products.size }
      column: cost { field: products.cost }
      column: category { field: products.category }
      column: brand { field: products.brand }
      column: product_id { field: products.id }
      column: country_of_origin { field: products.country_of_origin }
      column: order_items_id {field: order_items.id}
      derived_column: primary_key {
        sql: FARM_FINGERPRINT(CAST(CONCAT(order_id,order_items_id) as STRING)) ;;
      }
    }
  }

  # dimension: partition_key {
  #   hidden: yes
  #   # sql: ${created_date} ;;
  # }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    # sql: CONCAT(${order_id},${order_items_id}) ;;
  }

  dimension: company_id {
    hidden: yes
    label: "Company ID"
    description: "Company ID"
    type: number
  }

  dimension: location_id {
    hidden: yes
    label: "Location ID"
    description: "Location ID"
    type: number
  }

  dimension: division_id {
    hidden: yes
    label: "Division ID"
    description: "Division ID"
    type: number
  }

  dimension: order_id {
    hidden: yes
    label: "Order ID"
    description: "Order ID"
    type: string
  }

  dimension: order_type {
    hidden: no
    view_label: "Orders"
    description: "Type of order, dine in or take away"
  }
  dimension: customer_id {
    hidden: no
    view_label: "Customers"
    description: "Customer that issued the order, can be null"
    type: number
  }
  # dimension_group: created {
  #   label: "Orders Created Time"
  #   description: "Date and time the order was placed"
  #   type: date_time
  # }

  dimension_group: created {
    view_label: "Orders"
    label: "Created"
    type: time
    datatype: datetime
    description: "Date and time the order was placed"
    hidden: no
    timeframes: [date, month_name,month, year, quarter, week, day_of_week, raw, time]
  }

  dimension_group: completed {
    view_label: "Orders"
    label: "Completed"
    type: time
    description: "Date and time the order was completed"
    hidden: no
    timeframes: [date, month_name,month, year, quarter, week, day_of_week, raw, time]
  }



  # dimension_group: completed_datetime_time {
  #   label: "Orders Completed Time"
  #   description: "Date and time the order was completed"
  #   type: date_time
  # }


  dimension: name {
    hidden: no
    view_label: "Product"
    description: "Product name"
  }
  dimension: price {
    hidden: no
    view_label: "Product"
    description: "Product retail price"
    type: number
  }
  dimension: size {
    hidden: no
    view_label: "Product"
    description: "Product serving size"
  }
  dimension: cost {
    hidden: no
    view_label: "Product"
    description: "Product costs"
    type: number
  }
  dimension: category {
    hidden: no
    view_label: "Product"
    description: "Product category"
  }
  dimension: brand {
    hidden: no
    view_label: "Product"
    description: "Product brand"
  }
  dimension: product_id {
    hidden: yes
    view_label: "Product"
    description: "Product ID"
    type: number
  }
  dimension: country_of_origin {
    hidden: no
    view_label: "Product"
    description: "Product country of origin"
  }
  dimension: order_items_id {
    hidden: no
    view_label: "Orders"
    label: "Order Item ID"
    description: "Order Item ID"
    type: number
  }

  ##########  ##########  ##########  ##########  ##########  ##########  ##########  ##########  ##########  ##########  ##########  ##########  ##########  ##########  ##########

  dimension_group: completion {
    description: "Time to complete order"
    view_label: "Orders"
    label: "Order Completion"
    hidden: no
    type: duration
    sql_start: ${created_raw} ;;
    sql_end: ${completed_raw} ;;
    intervals: [minute]
  }

  measure: average_order_completion_duration {
    view_label: "Orders"
    type: average
    description: "Average time to complete order in minutes"
    hidden: no
    sql: ${minutes_completion} ;;
  }

  measure: total_order_items {
    hidden: no
    view_label: "Orders"
    label: "Total Order Items"
    type: count_distinct
    sql: ${order_items_id} ;;
  }

  measure: total_orders {
    hidden: no
    view_label: "Orders"
    label: "Total Orders"
    type: count_distinct
    sql: ${order_id} ;;
  }

  # dimension: item_price {
  #   description: "Items price"
  #   hidden: yes
  #   label: "Item price"
  #   sql: ${products.price} ;;
  # }

  # dimension: item_cost  {
  #   description: "Item cost"
  #   hidden: yes
  #   label: "Item cost"
  #   sql: ${products.cost} ;;
  # }

  dimension: item_margin {
    view_label: "Product"
    description: "Item margin"
    hidden: yes
    label: "Item margin"
    sql: ${price}-${cost} ;;
  }

  measure: total_sales {
    view_label: "Orders"
    description: "Total Sales"
    hidden: no
    label: "Total Sales"
    sql: ${price} ;;
    type: sum
    value_format_name: usd
  }

  measure: average_sales {
    view_label: "Orders"
    description: "Average Sales"
    hidden: no
    label: "Average Sales"
    sql: ${price} ;;
    type: average
    value_format_name: usd
  }

  measure: total_cost {
    view_label: "Orders"
    description: "Total Cost"
    hidden: no
    label: "Total Cost"
    sql: ${cost} ;;
    type: sum
    value_format_name: usd
  }

  measure: average_cost {
    view_label: "Orders"
    description: "Average Cost"
    hidden: no
    label: "Average Cost"
    sql: ${cost} ;;
    type: sum
    value_format_name: usd
  }

  measure: total_margin {
    view_label: "Orders"
    description: "Total Margin"
    hidden: no
    label: "Total Margin"
    sql: ${item_margin} ;;
    type: sum
    value_format_name: usd
  }

  measure: average_margin {
    view_label: "Orders"
    description: "Average Margin"
    hidden: no
    label: "Average Margin"
    sql: ${item_margin} ;;
    type: average
    value_format_name: usd
  }

    ##########  ##########  ##########  ##########  ##########  ##########  ##########  ##########  ##########  ##########  ##########  ##########  ##########  ##########


}
