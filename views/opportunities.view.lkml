view: opportunities {
  sql_table_name: `deft-scout-391412.SFData.Opportunities` ;;
  drill_fields: [opportunity_id]

  dimension: opportunity_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Opportunity_ID ;;
  }

  dimension: account_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.Account_ID ;;
  }
  dimension: account_region {
    type: string
    sql: ${TABLE}.Account_Region ;;
  }
  dimension: amount {
    type: number
    sql: ${TABLE}.Amount ;;
  }
  measure: Amount {
    type: sum
    sql: ${amount} ;;
  }
  dimension: campaign_id {
    type: string
    sql: ${TABLE}.Campaign_ID ;;
  }
  dimension_group: close {
    type: time
    timeframes: [raw, date, week, month, month_num, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Close_Date ;;
  }
  measure: Last_Close_Date{
    type:  date
    sql: max(${close_date}) ;;
  }
  parameter: Selected_Time_Period {
    allowed_value: {
      label: "YTD"
      value: "YTD"
    }
    allowed_value: {
      label: "MTD"
      value: "MTD"
    }
    allowed_value: {
      label: "WTD"
      value: "WTD"
    }
    allowed_value: {
      label: "QTD"
      value: "QTD"
    }
  }
  dimension: Selected_Metric {
    label_from_parameter: Selected_Time_Period
    sql: {% if Selected_Time_Period._parameter_value == "'YTD'"%}
    then ${YTD}
    {%elsif Selected_Time_Period._parameter_value == "'MTD'"%}
    then ${MTD}
    {%elsif Selected_Time_Period._parameter_value == "'WTD'"%}
    then ${WTD}
    {%elsif Selected_Time_Period._parameter_value == "'QTD'"%}
    then ${QTD}
    {%endif%} ;;
  }

  dimension: YTD {
    type: yesno
    sql: ${close_date} >= DATE_TRUNC(current_date(), YEAR) and ${close_date} <= current_date() ;;
    #sql: extract(year from current_date) = ${close_year} and extract(month from current_date) <= ${close_month_num} ;;
  }
  dimension: MTD {
    type: yesno
    sql: ${close_date} >= DATE_TRUNC(current_date(), MONTH) and ${close_date} <= current_date() ;;
    #sql: extract(month from current_date) = ${close_year} and extract(month from current_date) <= ${close_month_num} ;;

  }
  dimension: WTD {
    type: yesno
    sql: ${close_date} >= DATE_TRUNC(current_date(), WEEK) and ${close_date} <= current_date() ;;
  }
  dimension: QTD {
    type:  yesno
    sql: ${close_date} >= DATE_TRUNC(current_date(), QUARTER) and ${close_date} <= current_date() ;;
  }
  measure: year_to_date {
    label: "Year to Date"
    type: sum
    sql: ${amount} ;;
    filters: [year_range: "Yes"]
    drill_fields: [amount,close_year,close_month]
    html: {{linked_value}} ;;
    value_format_name: usd
  }
  dimension: year_range {
    type: yesno
    sql:  ${close_date} >= DATE_TRUNC(current_date(), YEAR) and ${close_date} <= current_date() ;;
  }
  measure: month_to_date {
    label: "Month to Date"
    type: sum
    sql: ${amount} ;;
    filters: [month_range: "Yes"]
    drill_fields: [amount,close_year,close_month]
    html: {{linked_value}} ;;
    value_format_name: usd
  }
  dimension: month_range {
    type: yesno
    sql:  ${close_date} >= DATE_TRUNC(current_date(), MONTH) and ${close_date} <= current_date() ;;
  }
  measure: week_to_date {
    label: "Week to Date"
    type: sum
    sql: ${amount} ;;
    filters: [year_range: "Yes"]
    drill_fields: [amount,close_year,close_month]
    html: {{linked_value}} ;;
    value_format_name: usd
  }
  dimension: week_range {
    type: yesno
    sql:  ${close_date} >= DATE_TRUNC(current_date(), WEEK) and ${close_date} <= current_date() ;;
  }
  measure: quarter_to_date {
    label: "Quarter to Date"
    type: sum
    sql: ${amount} ;;
    filters: [year_range: "Yes"]
    drill_fields: [amount,close_year,close_month]
    html: {{linked_value}} ;;
    value_format_name: usd
  }
  dimension: quarter_range {
    type: yesno
    sql:  ${close_date} >= DATE_TRUNC(current_date(), QUARTER) and ${close_date} <= current_date() ;;
  }
  dimension: combined_yes_no {
    type: yesno
    sql: ${year_range} OR ${month_range} OR ${week_range} OR ${quarter_range};;
  }
  dimension_group: CloseDate {
    type: time
    timeframes: [date, raw]
  }
dimension: Stage_Filter{
  link: {
    label: "Filter by the selected Stage Value"
    url: "https://springmllook.cloud.looker.com/dashboards/59?Stage={{ _filters['stage'] | url_encode }}"
  }
}
measure: Last_Year_Amount {
  type:  sum
  sql: CASE
  WHEN ${close_date} >= (DATE_TRUNC(${close_date}, YEAR) - INTERVAL 1 YEAR)
           AND ${close_date} < DATE_TRUNC(${close_date}, YEAR)
          THEN ${amount}
          ELSE NULL
          END ;;
}
measure: ytd_amount  {
  type: sum
  sql: CASE WHEN ${close_date} >= DATE_TRUNC(${close_date}, YEAR)
      THEN ${amount}
      ELSE NULL
      END  ;;
}

  dimension: contact_id {
    type: string
    sql: ${TABLE}.Contact_ID ;;
  }
  dimension: created_by_id {
    type: string
    sql: ${TABLE}.Created_By_ID ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Created_Date ;;
  }
  dimension: expected_amount {
    type: number
    sql: ${TABLE}.Expected_Amount ;;
  }
  measure: Expected_Amount{
    type: sum
    sql: ${expected_amount} ;;
  }
  dimension: fiscal_quarter {
    type: number
    sql: ${TABLE}.Fiscal_Quarter ;;
  }
  dimension: fiscal_year {
    type: number
    sql: ${TABLE}.Fiscal_Year ;;
  }
  dimension: forecast_category {
    type: string
    sql: ${TABLE}.Forecast_Category ;;
  }
  dimension: has_line_item {
    type: yesno
    sql: ${TABLE}.Has_Line_Item ;;
  }
  dimension: has_open_activity {
    type: yesno
    sql: ${TABLE}.Has_Open_Activity ;;
  }
  dimension_group: last_activity {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Last_Activity ;;
  }
  dimension_group: last_modified {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Last_Modified_Date ;;
  }
  dimension_group: last_stage_change {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Last_Stage_Change_Date ;;
  }
  dimension: lead_source {
    type: string
    sql: ${TABLE}.Lead_Source ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}.Name ;;
  }
  dimension: opportunity_type {
    type: string
    sql: ${TABLE}.Opportunity_Type ;;
  }
  dimension: probability____ {
    type: number
    sql: ${TABLE}.Probability____ ;;
  }
  measure: Average_Probability {
    type: average
    sql: ${probability____} ;;
  }
  dimension: quantity {
    type: number
    sql: ${TABLE}.Quantity ;;
  }
  measure: Quantity  {
    type: sum
    sql: ${quantity} ;;
  }
  dimension: stage {
    type: string
    sql: ${TABLE}.Stage ;;
  }
  dimension: Stage_Name {
    type: string
    sql: ${stage} ;;
    link: {
      label: "Stage Name"
      url: "https://springmllook.cloud.looker.com/dashboards/59?=Stage{{ value }}"
    }
  }
  dimension: won {
    type: yesno
    sql: ${TABLE}.Won ;;
  }
  measure: count {
    type: count
    drill_fields: [opportunity_id, name, accounts.parent_account_id, accounts.account_name]
  }
}
