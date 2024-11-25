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


  dimension: good_name {
    type: string
    sql: CONCAT(${first_name}, ' ', ${last_name}) ;;
  }
  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, orders.count]
  }

  dimension: age_group {
    type: string
    sql:
    CASE
      WHEN ${age} < 18 THEN 'Under 18'
      WHEN ${age} BETWEEN 18 AND 24 THEN '18-24'
      WHEN ${age} BETWEEN 25 AND 34 THEN '25-34'
      WHEN ${age} BETWEEN 35 AND 44 THEN '35-44'
      WHEN ${age} BETWEEN 45 AND 54 THEN '45-54'
      WHEN ${age} BETWEEN 55 AND 64 THEN '55-64'
      WHEN ${age} BETWEEN 65 AND 74 THEN '65-74'
      WHEN ${age}  
 >= 75 THEN '75+'
    END
   ;;
  }


}
