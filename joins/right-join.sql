-- right join returns ALL records from the right table,
-- even when there is no matching record in the left table.
-- Non-matching values from the left table become NULL.

--1 Here it shows all clients, including clients who do not own pets.

SELECT p.nome, c.nome
FROM pets p
RIGHT JOIN clientes c
    ON c.id = p.cliente_id;
