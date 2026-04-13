{{ config(materialized='incremental') }}

SELECT *
FROM {{ source('staging', 'hosts') }}

{% if is_incremental() %}
    WHERE HOST_ID > (SELECT COALESCE(MAX(HOST_ID), '1990-01-01') FROM {{ this }})
{% endif %}