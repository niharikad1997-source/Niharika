{{ 
    config (
        materialized = "ephemeral"
    )
}}

with hosts AS
(
    SELECT
    HOST_ID,
    HOST_NAME,
    HOST_SINCE,
    IS_SUPERHOST,
    RESPONSE_RATE_CATEGORY,
    HOST_CREATED_AT
    FROM {{ ref('obt') }}
)
select * from hosts
