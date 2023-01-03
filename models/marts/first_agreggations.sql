{{ config(materialized='ephemeral') }}

with date_convertsql as (select * from {{ ref('date_convert1')}} 
),

f_agreggations as(
    select
        date_convertsql.mes_ano,
        sum(date_convertsql.receita) as totalreceita, 
        sum(date_convertsql.imposto) as totalImposto,
        sum(date_convertsql.frete) as totalFrete, 
        count(date_convertsql.quantidade) as qtdTransacoes, 
        (sum(date_convertsql.receita) - sum(date_convertsql.imposto)) - sum(date_convertsql.frete) as receitaLiquida,
    from date_convertsql
    group by mes_ano
)
select * from f_agreggations order by mes_ano ASC
