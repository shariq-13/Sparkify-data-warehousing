WITH source AS (

    SELECT *
    FROM {{ source('raw', 'LOG_DATA_RAW') }}

),

transformed AS (

    SELECT
        TRIM(RAW_DATA:artist::VARCHAR) AS artist,
        RAW_DATA:auth::VARCHAR AS auth,
        TRIM(RAW_DATA:firstName::VARCHAR) AS first_name,
        RAW_DATA:gender::VARCHAR AS gender,
        RAW_DATA:itemInSession::INTEGER AS item_in_session,
        TRIM(RAW_DATA:lastName::VARCHAR) AS last_name,
        RAW_DATA:length::FLOAT AS length,
        RAW_DATA:level::VARCHAR AS level,
        TRIM(RAW_DATA:location::VARCHAR) AS location,
        RAW_DATA:method::VARCHAR AS method,
        RAW_DATA:page::VARCHAR AS page,
        RAW_DATA:registration::FLOAT AS registration,
        RAW_DATA:sessionId::INTEGER AS session_id,
        TRIM(RAW_DATA:song::VARCHAR) AS song,
        RAW_DATA:status::INTEGER AS status,

        TO_TIMESTAMP_NTZ(
            RAW_DATA:ts::BIGINT / 1000
        ) AS event_timestamp,

        RAW_DATA:userAgent::VARCHAR AS user_agent,
        RAW_DATA:userId::VARCHAR AS user_id

    FROM source

)

SELECT *
FROM transformed

WHERE user_id IS NOT NULL