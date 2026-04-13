{{ 
    config (
        materialized = "ephemeral"
    )
}}

with bookings AS
(
    SELECT
    BOOKING_ID,
    BOOKING_DATE,
    BOOKINGS_CREATED_AT
    FROM {{ ref('obt') }}
)
select * from bookings
