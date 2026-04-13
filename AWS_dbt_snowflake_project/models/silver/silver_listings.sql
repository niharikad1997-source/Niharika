

{{ config(
    materialized='incremental',
    unique_key='LISTING_ID')
}}

select
    LISTING_ID,
    HOST_ID,
    PROPERTY_TYPE,
    ROOM_TYPE,
    {{trimmer('CITY') }} as CITY_NAME,
    {{trimmer('COUNTRY') }} as COUNTRY_NAME,
    ACCOMMODATES,
    BEDROOMS,
    BATHROOMS,
    ---PRICE_PER_NIGHT,
    {{ tag('PRICE_PER_NIGHT') }} as PRICE_PER_NIGHT_TAG,
    CREATED_AT 
from {{ ref('bronze_listings') }}