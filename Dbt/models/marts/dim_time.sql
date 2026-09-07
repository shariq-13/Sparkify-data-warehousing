WITH source AS (

    SELECT DISTINCT
        event_timestamp
    FROM {{ ref('stg_log_data') }}

    WHERE event_timestamp IS NOT NULL

)

SELECT
    event_timestamp,

    EXTRACT(HOUR FROM event_timestamp) AS hour,
    EXTRACT(DAY FROM event_timestamp) AS day,
    EXTRACT(WEEK FROM event_timestamp) AS week,
    EXTRACT(MONTH FROM event_timestamp) AS month,
    EXTRACT(QUARTER FROM event_timestamp) AS quarter,
    EXTRACT(YEAR FROM event_timestamp) AS year,

    DAYOFWEEK(event_timestamp) AS weekday,
    DAYNAME(event_timestamp) AS weekday_name,
    MONTHNAME(event_timestamp) AS month_name

FROM source