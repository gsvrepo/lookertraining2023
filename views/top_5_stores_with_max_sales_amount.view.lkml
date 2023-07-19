view: top_5_stores_with_max_sales_amount {
  sql_table_name: `deft-scout-391412.project_new.Top 5 Stores with Max Sales Amount` ;;

  dimension: county {
    type: string
    sql: ${TABLE}.county ;;
  }
  dimension: store_name {
    type: string
    sql: ${TABLE}.store_name ;;
  }
  dimension: total_sales {
    type: number
    sql: ${TABLE}.Total_Sales ;;
  }
  dimension: year {
    type: number
    sql: ${TABLE}.YEAR ;;
  }
  measure: count {
    type: count
    drill_fields: [store_name]
  }
}
