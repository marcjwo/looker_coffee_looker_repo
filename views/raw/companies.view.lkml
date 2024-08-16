# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
# explore: companies {
#   hidden: yes
#     join: companies__divisions {
#       view_label: "Companies: Divisions"
#       sql: LEFT JOIN UNNEST(${companies.divisions}) as companies__divisions ;;
#       relationship: one_to_many
#     }
# }

view: companies {
  sql_table_name: `@{gcp_project}.@{bq_dataset}.companies` ;;
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
  dimension: days_in_operation {
    type: number
    sql: ${TABLE}.days_in_operation ;;
  }
  dimension: divisions {
    hidden: yes
    sql: ${TABLE}.divisions ;;
  }
  dimension_group: founding {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.founding_date ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
  measure: count {
    type: count
    drill_fields: [id, name]
  }
}

view: companies__divisions {

  dimension: companies__divisions {
    type: string
    sql: companies__divisions ;;
  }
}
