{{ config(materialized='ephemeral') }}

select
    FORMAT_DATE('%Y-%m',  dataFormatada) as mes_ano,
    grupoUsuarios, 
    pais,
    cidade, 
    receita, 
    imposto, 
    frete, 
    quantidade
from {{ ref('date_convert') }}