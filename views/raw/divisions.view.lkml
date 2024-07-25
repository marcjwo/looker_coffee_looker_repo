view: divisions {
  sql_table_name: `@{gcp_project}.@{bq_dataset}.divisions` ;;
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
  dimension: address_state {
    type: string
    sql: ${TABLE}.address_state ;;
  }
  dimension: address_street {
    type: string
    sql: ${TABLE}.address_street ;;
  }
  dimension: address_zip_code {
    type: string
    sql: ${TABLE}.address_zip_code ;;
  }
  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
  }
  dimension: days_in_operation {
    type: number
    sql: ${TABLE}.days_in_operation ;;
  }
  dimension_group: founding {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.founding_date ;;
  }
  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }
  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
  measure: count {
    type: count
    drill_fields: [id, name, locations.count]
  }
}
