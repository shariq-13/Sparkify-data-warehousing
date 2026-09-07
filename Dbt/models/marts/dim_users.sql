WITH source AS (

    SELECT *
    FROM {{ ref('stg_log_data') }}

),

users AS (

    SELECT
        user_id,
        first_name,
        last_name,
        gender,
        level,
        location,
        event_timestamp,

        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY event_timestamp DESC
        ) AS row_num

    FROM source

    WHERE user_id IS NOT NULL

)

SELECT
    user_id,
    first_name,
    last_name,
    gender,
    level,
    location

FROM users

WHERE row_num = 1

-- This gives one record per user, using the latest event to determine their current subscription level.