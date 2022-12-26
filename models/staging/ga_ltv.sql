{{ config(materialized='table') }}

select
    FORMAT_DATE('%Y-%m',  PARSE_DATE('%b %d, %Y',  data)) as mes_ano
    grupoUsuarios, 
    sum(receita) as totalreceita, 
    sum(imposto) as totalImposto,
    sum(frete) as totalFrete, 
    count(quantidade) as qtdTransacoes, 
    /*ReceitaLiquida*/ (sum(receita) - sum(imposto)) - sum(frete) as receitaLiquida,
    /*TicketMedio*/ (receitaLiquida/qtdTransacoes) as ticketMedio, 
    /*MargemLucro*/(receitaLiquida/receita) * 100 as margemLucro, 
    /*LTV*/(receitaLiquida / 0.15) * margemLucro as LTV
from {{ source('LTV_GA', 'LTV_GA_teste') }}
group by grupoUsuarios
order by mes_ano