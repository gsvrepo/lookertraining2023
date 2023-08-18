view: opportunities_with_location_info {
  sql_table_name: `deft-scout-391412.SFData.Opportunities with Location Info` ;;

  dimension: city {
    type: string
    sql: ${TABLE}.City ;;
  }
  dimension: latitude {
    type: number
    sql: ${TABLE}.Latitude ;;
  }
  dimension: longitude {
    type: number
    sql: ${TABLE}.Longitude ;;
  }
  dimension: location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }
  parameter: customcity {
    type: string
    allowed_value: {
      label: "Miami"
      value: "miami"
    }
    allowed_value: {
      label: "Tampa"
      value: "tampa"
    }
    allowed_value: {
      label: "Houston"
      value: "houston"
    }
    allowed_value: {
      label: "Austin"
      value: "austin"
    }
    allowed_value: {
      label: "Tucson"
      value: "tucson"
    }
  }
  dimension: distance_city_lat {
    hidden: yes
    type: number
    sql:  CASE  WHEN {% parameter ${customcity} %} = 'miami' THEN 25.7617
              WHEN {% parameter ${customcity} %} = 'tampa' THEN 27.9506
              WHEN {% parameter ${customcity} %} = 'houston' THEN 29.7604
              WHEN {% parameter ${customcity} %} = 'austin' THEN 30.2672
              WHEN {% parameter ${customcity} %} = 'tucson' THEN 32.2226
              ELSE 25.7617 END ;;
  }
  dimension: distance_city_long {
    hidden:  yes
    type: number
    sql: CASE WHEN {% parameter ${customcity} %} = 'miami' THEN -80.1918
              WHEN {% parameter ${customcity} %} = 'tampa' THEN -82.4572
              WHEN {% parameter ${customcity} %} = 'houston' THEN -95.3698
              WHEN {% parameter ${customcity} %} = 'austin' THEN -97.7431
              WHEN {% parameter ${customcity} %} = 'tucson' THEN -110.9747
              ELSE -80.1918 END ;;
  }
  dimension: location_of_selected_city {
    hidden: yes
    type: location
    sql_latitude: ${distance_city_lat} ;;
    sql_longitude: ${distance_city_long} ;;
  }
  dimension: distance_between_selected_city_and_user {
    label: "Distance in km"
    type: distance
    start_location_field: location
    end_location_field: location_of_selected_city
    units: kilometers
    }
  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.Opportunity_Name ;;
  }
  dimension: stage {
    type: string
    sql: ${TABLE}.Stage ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }
  measure: count {
    type: count
    drill_fields: [opportunity_name]
  }
}
