-- A SQL view is virtual table created based on the result of an SQL statement.

-- 1 Now we are creating a simple view called Cachorros, in this view i will return the names of the pets, their breeds and their owners's names.

create view Cachorros as 
select p.nome as nome_pet, p.raca, c.nome as nome_cliente
from pets p
inner join clientes c on c.id = p.cliente_id
where p.especie = 'cachorro';

-- 2 After being created, the view is stored in our database, so we simply need to call it whenever we need to search for all the dogs in our database
select * from Cachorros

-- 3 This time, we will create a complex view with aggregation!
-- 4 As you can see, we name our view "vw_total_por_raca", here, we shall be returning the total of registred animals per breed.
create view vw_total_por_raca as 
SELECT 
    raca, 
    COUNT(*) AS total_por_raca
FROM pets
GROUP BY raca
order by total_por_raca desc;
-- 5 Then, we simply call our created view.
select * from vw_total_por_raca
