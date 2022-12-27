{{ config(materialized='ephemeral') }}

with f_agg as (select * from {{ ref('first_agreggations')}} 
),

dim_GA as(
    select
        f_agg.mes_ano,
        f_agg.grupoUsuarios, 
        f_agg.totalreceita, 
        f_agg.totalImposto,
        f_agg.totalFrete, 
        f_agg.qtdTransacoes, 
        f_agg.receitaLiquida,
        (f_agg.receitaLiquida/f_agg.qtdTransacoes) as ticketMedio, 
        SAFE_DIVIDE(f_agg.receitaLiquida, f_agg.totalreceita) * 100 as margemLucro
    from f_agg
)

select * from dim_GA order by mes_ano