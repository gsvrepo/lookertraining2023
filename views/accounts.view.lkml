view: accounts {
  sql_table_name: `deft-scout-391412.SFData.Accounts` ;;
  drill_fields: [parent_account_id]

  dimension: parent_account_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Parent_Account_ID ;;
  }
  dimension: account_description {
    type: string
    sql: ${TABLE}.Account_Description ;;
  }
  dimension: account_fax {
    type: string
    sql: ${TABLE}.Account_Fax ;;
  }
  dimension: account_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.Account_ID ;;
  }
  dimension: account_name {
    type: string
    sql: ${TABLE}.Account_Name ;;
  }
  dimension: account_number {
    type: string
    sql: ${TABLE}.Account_Number ;;
  }
  dimension: account_priority {
    type: string
    sql: ${TABLE}.Account_Priority ;;
  }
  dimension: account_source {
    type: string
    sql: ${TABLE}.Account_Source ;;
  }
  dimension: account_status {
    type: string
    sql: ${TABLE}.Account_Status ;;
  }
  dimension: account_type {
    type: string
    sql: ${TABLE}.Account_Type ;;
  }
  dimension: annual_revenue {
    type: number
    sql: ${TABLE}.Annual_Revenue ;;
  }
  measure: Annual_Revenue {
    type:  sum
    sql: ${annual_revenue} ;;
  }
  dimension: billing_country {
    type: string
    sql: ${TABLE}.Billing_Country ;;
  }
  dimension: billing_state_province {
    type: string
    sql: ${TABLE}.Billing_State_Province ;;
  }
  dimension: billing_zip_postal_code {
    type: string
    sql: ${TABLE}.Billing_Zip_Postal_Code ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Created_Date ;;
  }
# YTD Filter

  filter: ytd {
    type: date
    sql: ${created_date} >= {% condition %}date_trunc('year', current_date()){% endcondition %}
  }

# MTD Filter
  filter: mtd {
    type: date
    sql: ${created_date} >= {% condition %}date_trunc('month', current_date()){% endcondition %}
  }

# WTD Filter
  filter: wtd {
    type: date
    sql: ${created_date} >= {% condition %}date_trunc('week', current_date()){% endcondition %}
  }

# QTD Filter
  filter: qtd {
    type: date
    sql: ${created_date} >= {% condition %}date_trunc('quarter', current_date()){% endcondition %}
  }

  dimension: current_year_revenue_goal {
    type: number
    sql: ${TABLE}.Current_Year_Revenue_Goal ;;
  }
 # measure: Current_Year_Revenue_Goal {
  #  type: sum
   # sql: ${Current_Year_Revenue_Goal} ;;
  #}
  dimension: employees {
    type: number
    sql: ${TABLE}.Employees ;;
  }
  dimension: industry {
    type: string
    sql: ${TABLE}.Industry ;;
  }
  dimension_group: last_modified {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Last_Modified_Date ;;
  }
  dimension: owner_id {
    type: string
    sql: ${TABLE}.Owner_ID ;;
  }
  dimension: shipping_country {
    type: string
    sql: ${TABLE}.Shipping_Country ;;
  }
  dimension: Shipping_Country {
    type: string
    map_layer_name: countries
    sql: ${shipping_country} ;;
  }
  dimension: shipping_zip_postal_code {
    type: string
    sql: ${TABLE}.Shipping_Zip_Postal_Code ;;
  }
  dimension: total___of_activities {
    type: number
    sql: ${TABLE}.Total___of_Activities ;;
  }
  measure:  Total_Number_of_Activities{
    type:  sum
    sql: ${total___of_activities} ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  parent_account_id,
  account_name,
  accounts.parent_account_id,
  accounts.account_name,
  accounts.count,
  opportunities.count
  ]
  }

}
