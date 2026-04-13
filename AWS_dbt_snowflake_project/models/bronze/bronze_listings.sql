
{{ config(materialized='incremental') }}

SELECT *
FROM {{ source('staging', 'listings') }}  --- source table AIRBNB.STAGGING.LISTINGS(raw data)

{% if is_incremental() %}
    WHERE CREATED_AT > (SELECT COALESCE(MAX(CREATED_AT), '1990-01-01') FROM {{ this }}) ---this target AIRBNB.BRONZE.listings (snowflake table )
{% endif %}



