-- inner joins are commands used to combine only the records that have matching values in both tables.

--1  In this example, the command is used to show the pet name and the owner's name only when the pet has a valid owner.
SELECT p.nome, c.nome
FROM pets p
INNER JOIN clientes c 
    ON c.id = p.cliente_id;
