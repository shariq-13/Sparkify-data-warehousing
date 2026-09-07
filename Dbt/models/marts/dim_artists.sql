WITH source AS (

    SELECT *
    FROM {{ ref('stg_song_data') }}

),

artists AS (

    SELECT
        artist_id,
        artist_name,
        artist_location,
        artist_latitude,
        artist_longitude,

        ROW_NUMBER() OVER (
            PARTITION BY artist_id
            ORDER BY artist_id
        ) AS row_num

    FROM source

    WHERE artist_id IS NOT NULL

)

SELECT
    artist_id,
    artist_name,
    artist_location,
    artist_latitude,
    artist_longitude

FROM artists

WHERE row_num = 1