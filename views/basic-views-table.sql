-- A SQL view is virtual table created based on the result of an SQL statement.

-- 1 Now we are creating a simple view called Cachorros, in this view i will return the names of the pets, their breeds and their owners's names.

create view Cachorros as 
select p.nome as nome_pet, p.raca, c.nome as nome_cliente
from pets p
inner join clientes c on c.id = p.cliente_id
where p.especie = 'cachorro';

-- 2 After being created, the view is stored in our database, so we simply need to call it whenever we need to search for all the dogs in our database
select * from Cachorros
