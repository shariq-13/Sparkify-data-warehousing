WITH source AS (

    SELECT *
    FROM {{ ref('stg_song_data') }}

),

songs AS (

    SELECT
        song_id,
        title,
        artist_id,
        artist_name,
        duration,
        year,
        artist_location,
        artist_latitude,
        artist_longitude,

        ROW_NUMBER() OVER (
            PARTITION BY song_id
            ORDER BY song_id
        ) AS row_num

    FROM source

    WHERE song_id IS NOT NULL

)

SELECT
    song_id,
    title,
    artist_id,
    artist_name,
    duration,
    year,
    artist_location,
    artist_latitude,
    artist_longitude

FROM songs

WHERE row_num = 1