view: customers {
  sql_table_name: `@{gcp_project}.@{bq_dataset}.customers` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: address_city {
    type: string
    sql: ${TABLE}.address_city ;;
  }
  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }
  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }
  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }


dimension: full_name {
  type: string
  sql: CONCAT(${first_name}, ' ', ${last_name}) ;;
}
  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, orders.count]
  }
}
