{{ config(materialized='incremental') }}

with dim_GA_ as (select * from {{ ref('dim_GA_LTV')}}
),

LTV_final as(
    select
        dim_GA_.mes_ano,
        dim_GA_.grupoUsuarios, 
        dim_GA_.totalreceita, 
        dim_GA_.totalImposto,
        dim_GA_.totalFrete, 
        dim_GA_.qtdTransacoes, 
        dim_GA_.receitaLiquida,
        dim_GA_.ticketMedio, 
        dim_GA_.margemLucro, 
        (dim_GA_.receitaLiquida/0.15) * dim_GA_.margemLucro as LTV
    from dim_GA_
)

select * from LTV_final order by mes_ano


