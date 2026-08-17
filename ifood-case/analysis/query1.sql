#Qual a média de valor total (total_amount) recebido em um mês considerando todos os yellow táxis da frota?
select
    dimm.id_month,
    dimm.ds_month,
    avg(fatyt.total_amount) as total_amount
from fat_yellow_taxi fatyt
inner join dim_month_parquet dimm on (dimm.id_month = fatyt.id_month)
group by
    dimm.id_month,
    dimm.ds_month
order by 1;
