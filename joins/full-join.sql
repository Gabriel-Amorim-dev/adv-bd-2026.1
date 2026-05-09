-- full joins returns all records from BOTH tables.
-- Matching rows are combined.
-- Non-matching rows from either side receive NULL values.


-- This example shows all pets and all clients, even when no relationship exists between them.

SELECT p.nome, c.nome
FROM pets p
FULL OUTER JOIN clientes c
    ON c.id = p.cliente_id;
