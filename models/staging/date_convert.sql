{{ config(materialized='ephemeral') }}

select
    PARSE_DATE('%b %d, %Y',  data) as dataFormatada,
    grupoUsuarios, 
    pais,
    cidade, 
    receita, 
    imposto, 
    frete, 
    quantidade
from {{ source('poc_looker', 'raw_dbt') }}