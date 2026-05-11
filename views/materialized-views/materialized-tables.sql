-- In SQL, a Materialized View is a database object that stores the result of a query physically on the disk.
-- Unlike a standard View, which re-runs the query every time it is accessed, a Materialized View provides significantly faster performance for complex queries because the data is pre-computed and ready for immediate retrieval.

-- 1 In this example, we use the CREATE MATERIALIZED VIEW statement to consolidate data from three distinct tables: appointments, pets, and customers.
-- Note how we perform multiple INNER JOIN operations to "flatten" the data. 
-- This allows us to access information such as the pet's name and the owner's contact details in a single location, 
-- without needing to join the original tables repeatedly during every search.
CREATE MATERIALIZED VIEW vw_info_agendamento AS 
SELECT 
    a.id AS agendamento_id,
    p.nome AS nome_pet, 
    p.raca AS raca_pet, 
    c.nome AS nome_cliente, 
    c.telefone, 
    c.email, 
    a.data_agendamento, 
    a.status, 
    a.observacoes
FROM agendamentos a 
INNER JOIN pets p ON p.id = a.pet_id
INNER JOIN clientes c ON c.id = p.cliente_id
-- 2 To view the stored data, we use the SELECT * FROM command. This reads directly from the saved "snapshot" on the disk, 
-- ensuring maximum efficiency even when dealing with high volumes of appointment records.
-- Because the data is stored physically, it is important to remember that it will not reflect new changes in the original tables until a REFRESH command is executed
select * from vw_info_agendamento
