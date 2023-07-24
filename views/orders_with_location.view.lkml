view: orders_with_location {
  sql_table_name: `deft-scout-391412.project_new.Orders with Location` ;;

  dimension: city {
    type: string
    sql: ${TABLE}.City ;;
  }
  dimension: customer_name {
    type: string
    sql: ${TABLE}.CustomerName ;;
  }
  dimension: latitude {
    type: number
    sql: ${TABLE}.Latitude ;;
  }
  dimension: longitude {
    type: number
    sql: ${TABLE}.Longitude ;;
  }
  dimension_group: order {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Order_Date ;;
  }
  dimension: order_id {
    type: string
    sql: ${TABLE}.Order_ID ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }
  dimension: zip_code {
    type: zipcode
    sql: ${TABLE}.Zip_Code ;;
  }
  measure: count {
    type: count
    drill_fields: [customer_name]
  }
}
