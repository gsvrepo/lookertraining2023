view: top_5_popular_products_per_county {
  sql_table_name: `deft-scout-391412.project_new.Top 5 Popular Products Per County` ;;

  dimension: county {
    type: string
    sql: ${TABLE}.county ;;
  }
  dimension: date {
    type: number
    sql: ${TABLE}.date ;;
  }
  dimension: item_description {
    type: string
    sql: ${TABLE}.item_description ;;
  }
  dimension: sale_dollars {
    type: number
    sql: ${TABLE}.sale_dollars ;;
  }
  measure: count {
    type: count
  }
}
