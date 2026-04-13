{% set configs = [
    {
        "table": "silver_bookings",
        "alias": "silver_bookings"
    },
    {
        "table": "silver_listings",
        "alias": "silver_listings",
        "join_condition": "silver_listings.listing_id = silver_bookings.listing_id",
        "join_type": "INNER"
    },
    {
        "table": "silver_hosts",
        "alias": "silver_hosts",
        "join_condition": "silver_listings.host_id = silver_hosts.host_id",
        "join_type": "INNER"
    }
] %}

SELECT
    -- bookings
    silver_bookings.BOOKING_ID,
    silver_bookings.LISTING_ID as Bookings_listing_id,
    silver_bookings.BOOKING_DATE,
    silver_bookings.NIGHTS_BOOKED,
    silver_bookings.BOOKING_AMOUNT,
    silver_bookings.CLEANING_FEE,
    silver_bookings.SERVICE_FEE,
    silver_bookings.TOTAL_AMOUNT,
    silver_bookings.BOOKING_STATUS,
    silver_bookings.CREATED_AT as Bookings_created_at,

    -- listings
    silver_listings.LISTING_ID as Listings_listing_id,
    silver_listings.HOST_ID as Listings_host_id,
    silver_listings.PROPERTY_TYPE,
    silver_listings.ROOM_TYPE,
    silver_listings.CITY_NAME,
    silver_listings.COUNTRY_NAME,
    silver_listings.ACCOMMODATES,
    silver_listings.BEDROOMS,
    silver_listings.BATHROOMS,
    --silver_listings.PRICE_PER_NIGHT,
    silver_listings.PRICE_PER_NIGHT_TAG,
    silver_listings.CREATED_AT as Listings_created_at,

    -- hosts
    silver_hosts.host_id,  
    silver_hosts.host_name,
    silver_hosts.host_since,
    silver_hosts.is_superhost,
    silver_hosts.response_rate,
    silver_hosts.response_rate_category,
    silver_hosts.created_at           AS host_created_at

FROM {{ ref(configs[0]["table"]) }} AS {{ configs[0]["alias"] }}

{% for table_config in configs[1:] %}
    {{ table_config["join_type"] }} JOIN {{ ref(table_config["table"]) }} AS {{ table_config["alias"] }}
        ON {{ table_config["join_condition"] }}
{% endfor %}