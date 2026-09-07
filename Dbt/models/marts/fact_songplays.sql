WITH log_data AS (

    SELECT
        user_id,
        session_id,
        event_timestamp,
        item_in_session,
        level,
        location,
        user_agent,
        artist,
        song,
        length

    FROM {{ ref('stg_log_data') }}

    WHERE page = 'NextSong'
      AND user_id IS NOT NULL

),

song_data AS (

    SELECT
        song_id,
        title,
        artist_id,
        artist_name,
        duration

    FROM {{ ref('stg_song_data') }}

    WHERE song_id IS NOT NULL

),

songplays AS (

    SELECT
        l.user_id,
        l.session_id,
        l.event_timestamp,
        l.item_in_session,
        l.level,
        l.location,
        l.user_agent,

        s.song_id,
        s.artist_id,

        l.song AS song_title,
        l.artist AS artist_name,

        COALESCE(s.duration, l.length) AS duration

    FROM log_data l

    LEFT JOIN song_data s
        ON LOWER(TRIM(l.song)) = LOWER(TRIM(s.title))
       AND LOWER(TRIM(l.artist)) = LOWER(TRIM(s.artist_name))

)

SELECT
    MD5(
        CONCAT(
            user_id,
            '-',
            session_id,
            '-',
            event_timestamp,
            '-',
            item_in_session
        )
    ) AS songplay_id,

    user_id,
    session_id,
    event_timestamp,
    item_in_session,

    song_id,
    artist_id,

    level,
    location,
    user_agent,

    song_title,
    artist_name,
    duration

FROM songplays