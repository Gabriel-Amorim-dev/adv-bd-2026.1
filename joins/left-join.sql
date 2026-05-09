--left joins returns ALL records from the left table, 
-- even when there is no matching record in the right table.
-- Non-matching values from the right table become NULL.


--1 Here we show all pets, including pets without registered owners.

SELECT p.nome, c.nome
FROM pets p
LEFT JOIN clientes c
    ON c.id = p.cliente_id;
