connection: "traininglooker_gsv"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
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
explore: top_10_customers_by_max_profit_and_category {}
explore: top_5_popular_products_per_county {}
explore: top_5_stores_with_max_sales_amount {}
explore: list_of_orders {}
explore: orders_with_location {}
explore: accounts {}
#explore: opportunities {}
explore: opportunities {
  join: accounts {
    relationship: many_to_one
    sql_on: ${accounts.account_id} = ${opportunities.account_id} ;;
  }
}
