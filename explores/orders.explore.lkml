include: "/views/refined/*.view.lkml"
include: "/views/pdt/*.view.lkml"

explore: order_items {
  label: "(1) Orders, Products, and Customers"

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: locations {
    type: left_outer
    sql_on: ${orders.location_id} = ${locations.id} ;;
    relationship: many_to_one
  }

  join: divisions {
    type: left_outer
    sql_on: ${locations.division_id} = ${divisions.id}  ;;
    relationship: many_to_one
  }

  join: companies {
    type: left_outer
    sql_on: ${divisions.company_id} = ${companies.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${order_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: customers {
    type: left_outer
    sql_on: ${orders.customer_id} = ${customers.id} ;;
    relationship: many_to_one
  }

  join: customer_order_facts {
    view_label: "Customers"
    type: left_outer
    relationship: one_to_one
    sql_on: ${orders.customer_id} = ${customer_order_facts.id} ;;
  }
}

explore: orders_and_items_test {
  from: orders_and_items
}

explore: orders_and_items {
  # label: "(1) Orders, Products, and Customers_test"

  join: locations {
    type: left_outer
    sql_on: ${orders_and_items.location_id} = ${locations.id} ;;
    relationship: many_to_one
  }

  join: divisions {
    type: left_outer
    sql_on: ${orders_and_items.division_id} = ${divisions.id}  ;;
    relationship: many_to_one
  }

  join: companies {
    type: left_outer
    sql_on: ${divisions.company_id} = ${companies.id} ;;
    relationship: many_to_one
  }

  # join: products {
  #   type: left_outer
  #   sql_on: ${orders_and_items.product_id} = ${products.id} ;;
  #   relationship: many_to_one
  # }

  join: customers {
    type: left_outer
    sql_on: ${orders_and_items.customer_id} = ${customers.id} ;;
    relationship: many_to_one
  }

  join: customer_order_facts {
    view_label: "Customers"
    type: left_outer
    relationship: one_to_one
    sql_on: ${orders_and_items.customer_id} = ${customer_order_facts.id} ;;
  }

}
