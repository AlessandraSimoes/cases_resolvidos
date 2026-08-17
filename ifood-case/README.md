# 📘 Documentação Pipeline Táxi Amarelo (iFood)

## 🥈 Camada Silver
A camada **Silver** organiza e padroniza os dados brutos, preparando-os para análises.

### info_yellow_taxi
- **Entrada**: arquivos Parquet mensais (`yellow_tripdata_2023-01` até `2023-05`)
- **Processos**:
  - Seleção de colunas principais: `VendorID`, `passenger_count`, `total_amount`, `tpep_pickup_datetime`, `tpep_dropoff_datetime`
  - Criação de colunas derivadas: `id_month` (mês), `id_hour` (hora)
  - União dos DataFrames mensais
- **Saída**: `s3://alsimoes/empresas/ifood/silver/info_yellow_taxi.parquet`

### dim_hour
- Estrutura fixa de horas (0–24)
- **Saída**: `s3://alsimoes/empresas/ifood/gold/dim_hour.parquet`

### dim_month
- Estrutura fixa de meses (1–12, com nomes)
- **Saída**: `s3://alsimoes/empresas/ifood/gold/dim_month.parquet`

---

## 🥇 Camada Gold
A camada **Gold** agrega e estrutura os dados para análises de negócio.

### fat_yellow_taxi
- **Entrada**: `silver/info_yellow_taxi.parquet`
- **Processos**:
  - Agrupamento por `VendorID`, `id_month`, `id_hour`
  - Cálculo de métricas:
    - Soma de `passenger_count`
    - Soma de `total_amount`
- **Saída**: `s3://alsimoes/empresas/ifood/gold/fat_yellow_taxi`

---

## 🔗 Relação entre as camadas
- **Silver** → organiza dados brutos e cria dimensões auxiliares (hora e mês).
- **Gold** → usa os dados organizados para gerar fatos consolidados (quantidade de passageiros e valores por fornecedor, mês e hora).
