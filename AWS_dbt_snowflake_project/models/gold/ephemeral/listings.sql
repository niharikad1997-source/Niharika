{{ 
    config (
        materialized = "ephemeral"
    )
}}

with listings AS
(
    SELECT
    LISTINGS_LISTING_ID,
    PROPERTY_TYPE,
    ROOM_TYPE,
    CITY_NAME,
    COUNTRY_NAME,
    PRICE_PER_NIGHT_TAG,
    Listings_created_at
    FROM {{ ref('obt') }}
)
select * from listings
