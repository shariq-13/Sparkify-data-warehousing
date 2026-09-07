WITH source AS (

    SELECT *
    FROM {{ source('raw', 'SONG_DATA_RAW') }}

),

transformed AS (

    SELECT
        RAW_DATA:artist_id::VARCHAR AS artist_id,
        RAW_DATA:artist_latitude::FLOAT AS artist_latitude,
        TRIM(RAW_DATA:artist_location::VARCHAR) AS artist_location,
        RAW_DATA:artist_longitude::FLOAT AS artist_longitude,
        TRIM(RAW_DATA:artist_name::VARCHAR) AS artist_name,
        RAW_DATA:duration::FLOAT AS duration,
        RAW_DATA:num_songs::INTEGER AS num_songs,
        TRIM(RAW_DATA:title::VARCHAR) AS title,
        RAW_DATA:year::INTEGER AS year,
        RAW_DATA:song_id::VARCHAR AS song_id

    FROM source

)

SELECT *
FROM transformed

WHERE song_id IS NOT NULL