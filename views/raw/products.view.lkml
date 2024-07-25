view: products {
  sql_table_name: `@{gcp_project}.@{bq_dataset}.products` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }
  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }
  dimension: country_of_origin {
    type: string
    sql: ${TABLE}.country_of_origin ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
  dimension: price {
    type: number
    sql: ${TABLE}.price ;;
  }
  dimension: size {
    type: string
    sql: ${TABLE}.size ;;
  }
  measure: count {
    type: count
    drill_fields: [id, name, order_items.count]
  }
}
