connection: "@{connection_name}"

label: "Looker Coffee [DEMO]"

include: "/explores/orders.explore.lkml"

datagroup: looker_coffee_default_datagroup {
  max_cache_age: "12 hours"
  sql_trigger: SELECT COUNT(*) FROM `@{gcp_project}.@{bq_dataset}.orders` ;;
}

persist_with: looker_coffee_default_datagroup


# include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
