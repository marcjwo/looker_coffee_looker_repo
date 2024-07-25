view: order_items {
  sql_table_name: `@{gcp_project}.@{bq_dataset}.order_items` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }
  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }
  measure: count {
    type: count
    drill_fields: [id, products.name, products.id, orders.id]
  }
}
