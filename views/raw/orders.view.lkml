view: orders {
  sql_table_name: `@{gcp_project}.@{bq_dataset}.orders` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension_group: completed_datetime {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.completed_datetime ;;
  }
  dimension_group: created_datetime {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.created_datetime ;;
  }
  dimension: customer_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.customer_id ;;
  }
  dimension: dine_in {
    type: yesno
    sql: ${TABLE}.dine_in ;;
  }
  dimension: location_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.location_id ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  customers.last_name,
  customers.id,
  customers.first_name,
  locations.name,
  locations.id,
  order_items.count
  ]
  }

}
