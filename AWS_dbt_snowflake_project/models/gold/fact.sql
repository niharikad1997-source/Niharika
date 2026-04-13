{% set congigs = [
    {
        "table": "AIRBNB.GOLD.OBT",
        "columns": "GOLD_obt.BOOKING_ID,GOLD_obt.TOTAL_AMOUNT, GOLD_obt.SERVICE_FEE, GOLD_obt.CLEANING_FEE, GOLD_obt.ACCOMMODATES,GOLD_obt.BEDROOMS, 
                   GOLD_obt.BATHROOMS, GOLD_obt.RESPONSE_RATE, GOLD_obt.Listings_listing_id, GOLD_obt.HOST_ID",
        "alias": "GOLD_obt"
    },
    {
        "table": "AIRBNB.GOLD.DIM_LISTINGS",
        "columns":"",
        "alias": "DIM_listings",
        "join_condition": "GOLD_obt.Listings_listing_id= DIM_LISTINGS.LISTINGS_LISTING_ID",
        
    },
    {
        "table": "AIRBNB.GOLD.DIM_HOSTS",
        "columns":"",
        "alias": "DIM_hosts",
        "join_condition": "GOLD_obt.HOST_ID = DIM_hosts.HOST_ID",
        
    }
] %}

SELECT 
        {{ congigs[0]['columns' ]}}
FROM 
    {% for config in congigs %}
    {% if loop.first%}
        {{ config['table'] }} AS {{ config['alias'] }}
    {% else %}
        LEFT JOIN {{ config['table'] }} AS {{ config['alias'] }}
            ON {{ config['join_condition'] }}
    {% endif %}
    {% endfor %} 