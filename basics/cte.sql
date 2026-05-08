-- A CTE is a temporary result set created using WITH. CTEs help organize complex queries and improve readability.

--1 In this example, i am creating a CTE called pets_cachorros.
-- The CTE stores all dogs from the pets table, then the main query retrieves the information from the CTE.

with pets_cachorros as (
    select nome, raca, data_nascimento
    from pets
    where especie = 'cachorro'
)

select *
from pets_cachorros

--2 Here i create a CTE that calculates the total amount spent by each client.
-- Then, the main query only returns clients who spent more than R$ 300.

with total_clientes as (
    select
        cliente_id,
        sum(valor_total) as total_gasto
    from vendas
    group by cliente_id
)

select *
from total_clientes
where total_gasto > 300

--3 In this example, i create a CTE containing all future appointments.
-- Then i retrieve only the appointments that are still marked as scheduled.

with proximos_agendamentos as (
    select
        pet_id,
        servico_id,
        data_agendamento,
        status
    from agendamentos
    where data_agendamento > current_timestamp
)

select *
from proximos_agendamentos
where status = 'agendado'

--4 Here i create a CTE with the total quantity sold for each product.
-- After that, i retrieve the products ordered from the most sold to the least sold.

with produtos_vendidos as (
    select
        produto_id,
        sum(quantidade) as total_vendido
    from itens_venda
    group by produto_id
)

select *
from produtos_vendidos
order by total_vendido desc
