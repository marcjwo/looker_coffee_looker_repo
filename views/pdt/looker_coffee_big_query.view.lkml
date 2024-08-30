# If necessary, uncomment the line below to include explore_source.
# include: "orders.explore.lkml"

explore: looker_coffee_big_query {
  hidden: yes
}

view: looker_coffee_big_query {
  derived_table: {
    sql_trigger_value: SELECT COUNT(*) FROM ${orders_and_items.SQL_TABLE_NAME};;
    publish_as_db_view: yes
    partition_keys: ["created_time"]
    cluster_keys: ["division_name","location_name","category","brand"]
    explore_source: orders_and_items {
      column: customer_age { field: customers.age }
      column: customer_full_name { field: customers.full_name }
      column: customer_gender { field: customers.gender }
      column: customer_id {}
      column: division_address_city { field: divisions.address_city }
      column: division_name { field: divisions.name }
      column: location_address_street { field: locations.address_street }
      column: location_address_zip_code { field: locations.address_zip_code }
      column: location_name { field: locations.name }
      column: completed_time {}
      column: created_time {}
      column: order_items_id {}
      column: order_id {}
      column: order_type {}
      column: brand {}
      column: category {}
      column: cost {}
      column: country_of_origin {}
      column: name {}
      column: price {}
      column: size {}
    }
  }
  dimension: customer_age {
    description: "Customer age"
    type: number
    # sql: ${TABLE}.age ;;
  }
  dimension: customer_full_name {
    description: "Customer fullname"
    # sql: ${TABLE}.full_name ;;
  }
  dimension: customer_gender {
    description: "Customer gender"
    # sql: ${TABLE}.gender ;;
  }
  dimension: customer_id {
    label: "Customers Customer ID"
    description: "Customer that issued the order, can be null"
  }
  dimension: division_address_city {
    description: ""
    # sql: ${TABLE}.address_city ;;
  }
  dimension: divison_name {
    description: "Division name"
  }
  dimension: location_address_street {
    description: ""
  }
  dimension: location_address_zip_code {
    description: ""
  }
  dimension: location_name {
    description: "Location name"
  }
  dimension: order_completed_time {
    label: "Orders Completed Time"
    description: "Date and time the order was completed"
    type: date_time
    sql: ${TABLE}.completed_time ;;
  }
  dimension: order_created_time {
    label: "Orders Created Time"
    description: "Date and time the order was placed"
    type: date_time
    sql: ${TABLE}.created_time ;;
  }
  dimension: order_items_id {
    label: "Orders Order Item ID"
    description: "Order Item ID"
    type: number
  }

  dimension: order_id {
    label: "Orders Order ID"
    description: "Order ID"
    type: number
  }
  dimension: order_type {
    label: "Orders Order Type"
    description: "Type of order, dine in or take away"
  }
  dimension: product_brand {
    label: "Product Brand"
    description: "Product brand"
    sql: ${TABLE}.brand ;;
  }
  dimension: product_category {
    label: "Product Category"
    description: "Product category"
    sql: ${TABLE}.category ;;
  }
  dimension: product_cost {
    label: "Product Cost"
    description: "Product costs"
    type: number
    sql: ${TABLE}.cost ;;
  }
  dimension: product_country_of_origin {
    label: "Product Country of Origin"
    description: "Product country of origin"
    sql: ${TABLE}.country_of_origin ;;
  }
  dimension: product_name {
    label: "Product Name"
    description: "Product name"
    sql: ${TABLE}.name ;;
  }
  dimension: product_price {
    label: "Product Price"
    description: "Product retail price"
    value_format: "$#,##0.00"
    type: number
    sql: ${TABLE}.price ;;
  }
  dimension: product_size {
    label: "Product Size"
    description: "Product serving size"
    sql: ${TABLE}.size ;;
  }
}
