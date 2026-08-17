#Qual a média de passageiros (passenger_count) por cada hora do dia que pegaram táxi no mês de maio considerando todos os táxis da frota?
select
    dimh.id_hour,
    dimh.ds_hour,
    avg(fatyt.passenger_count) as passenger_count
from fat_yellow_taxi fatyt
inner join dim_hour_parquet dimh on (dimh.id_hour = fatyt.id_hour)
inner join dim_month_parquet dimm on (dimm.id_month = fatyt.id_month)
where
    dimm.id_month = 5
group by
    dimh.id_hour,
    dimh.ds_hour
order by 1;