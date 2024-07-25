# If necessary, uncomment the line below to include explore_source.
# include: "orders.explore.lkml"

view: customer_order_facts {
  derived_table: {
    datagroup_trigger: looker_coffee_default_datagroup
    explore_source: order_items {
      column: id { field: customers.id }
      column: order_count { field: orders.count }
      column: total_sales {}
      column: first_order { field: orders.first_order }
      column: last_order { field: orders.last_order }
      filters: {
        field: customers.id
        value: "NOT NULL"
      }
    }
  }
  dimension: id {
    description: "Customer ID"
    primary_key: yes
    hidden: yes
    type: number
  }

  ##### Time and Cohort Fields ######


  dimension_group: first_order {
    description: "First Order"
    label: "First Order"
    type: time
    timeframes: [date, week, month, year]
  }
  dimension_group: last_order {
    description: "Last Order"
    label: "Last Order"
    type: time
    timeframes: [date, week, month, year]
  }
  dimension: days_as_customer {
    label: "Days As Customer"
    description: "Days between first and latest order"
    type: number
    sql: TIMESTAMP_DIFF(${last_order_date}, ${first_order_date}, DAY)+1 ;;
  }
  dimension: days_as_customer_tiered {
    label: "Days As Customer Tiered"
    type: tier
    tiers: [0, 1, 7, 14, 21, 28, 30, 60, 90, 120]
    sql: ${days_as_customer} ;;
    style: integer
  }

  ##### Lifetime Behavior - Order Counts ######


  dimension: order_count {
    label: "Lifetime Orders"
    type: number
  }

  dimension: repeat_customer {
    label: "Repeat Customer"
    description: "Lifetime Count of Orders > 1"
    type: yesno
    sql: ${order_count} > 1 ;;
  }

  dimension: lifetime_orders_tier {
    label: "Lifetime Orders Tier"
    type: tier
    tiers: [0, 1, 2, 3, 5, 10]
    sql: ${order_count} ;;
    style: integer
  }

  measure: average_lifetime_orders {
    label: "Average Lifetime Orders"
    type: average
    value_format_name: decimal_2
    sql: ${order_count} ;;
  }

  ##### Lifetime Behavior - Revenue ######


  dimension: total_sales {
    label: "Lifetime Revenue"
    value_format_name: usd
    type: number
  }

  dimension: lifetime_revenue_tier {
    label: "Lifetime Reveneue Tier"
    type: tier
    tiers: [0, 25, 50, 100, 200, 500, 1000]
    sql: ${total_sales} ;;
    style: integer
  }

  measure: average_lifetime_revenue {
    label: "Average Lifetime Margin"
    type: average
    value_format_name: usd
    sql: ${total_sales} ;;
  }
}
