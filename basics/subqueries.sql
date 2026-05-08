-- Subqueries are queries nested inside another query. They are useful when you need the result of one query to help execute another query.


--1 In this example, i want to retrieve the names of all pets that belong to the client named 'Ana Costa'.
-- First, the subquery searches for Ana Costa's id inside clientes, then the outer query uses that id to search inside pets.

select nome, especie, raca
from pets
where cliente_id = (
    select id
    from clientes
    where nome = 'Ana Costa'
)

--2 In this query, i want to retrieve all products whose price is above the average product price.
-- The subquery calculates the average price, while the outer query compares each product price against it.

select nome, preco
from produtos
where preco > (
    select avg(preco)
    from produtos
)

--3 Here i want to retrieve all clients that have made at least one purchase.
-- The subquery returns all client ids found in vendas, and the outer query retrieves the client information.

select nome, email
from clientes
where id in (
    select cliente_id
    from vendas
)

--4 Now, i want to retrieve the most expensive product in the system.
-- The subquery finds the highest product price, and the outer query returns the product associated with it.

select nome, preco
from produtos
where preco = (
    select max(preco)
    from produtos
)
