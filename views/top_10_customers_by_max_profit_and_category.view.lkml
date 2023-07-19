view: top_10_customers_by_max_profit_and_category {
  sql_table_name: `deft-scout-391412.project_new.Top 10 Customers by Max Profit and Category` ;;

  dimension: customer_name {
    type: string
    sql: ${TABLE}.CustomerName ;;
  }
  dimension: profit {
    type: number
    sql: ${TABLE}.Profit ;;
  }
  dimension: sub_category {
    type: string
    sql: ${TABLE}.Sub_Category ;;
  }
  measure: count {
    type: count
    drill_fields: [customer_name]
  }
}
