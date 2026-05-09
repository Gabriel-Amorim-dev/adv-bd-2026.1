-- in SQL, aggregate functions are functions that perform a calculation on a set of values to return a single summary value.
-- There are many operations that can be easily performed in SQL, the most known being: MIN(), MAX(), SUM(), COUNT(), AVG().
-- We will be ordering and arraging the data from those operations with GROUP BY, HAVING or ORDER BY.

-- 1 In this example, we use the MIN() function, which bring the smallest value of a selected column.
-- Its possible to see how we're bringing the smallest price from all products on the products table.
-- We also group this by id, meaning it will agreggate each line and its values as if they were their own column of values
select nome, descricao, min(p.preco) as smallest_price
from produtos p
group by p.id

-- 2 Now, we use the MAX() function, which brings the biggest value of a selected column.
-- It's possible to notice the same logic as the MIN() function, with it bringing the biggest price.
-- But differently of what's done when you use solely group by, the use of order by makes the order in which our info appears
-- follow a specific order.
-- Here, we're ordering them from the priciest product to the cheapest.
select nome, descricao, max(p.preco) as biggest_price
from produtos p
group by p.id
order by biggest_price desc

-- 3 In this example, we use the COUNT() function, which returns the number of rows that matches a specified criterion
-- Here, we can see break the logic of our SQL query in parts.
--3.1 At first, i am selecting the name of the clients and counting each pet_id
SELECT 
    clientes.nome, 
    COUNT(pets.id) AS total_pets
FROM pets
-- 3.2 Then, we apply the inner join to make sure the return relates to the 'cliente_id' on pets that matches clientes.id
INNER JOIN clientes ON clientes.id = pets.cliente_id
--3.3 Now, we are grouping them by the clients id and name, we're also parsing another condition, that i want only owners who have more than 1 pet
GROUP BY clientes.id, clientes.nome
HAVING COUNT(pets.id) > 1;

-- 4 Here we're gonna use the SUM() function, which we use to calculate the sum of values within a numeric column.
-- Again, lets divide our code in blocks and see what's happening in each of them.

-- 4.1 We select the name of the client and the sum of their expenses.
SELECT 
    clientes.nome, 
    SUM(vendas.valor_total) AS gasto_total_historico
FROM vendas
-- 4.2 We join the sales id with their respective clients.
INNER JOIN clientes ON clientes.id = vendas.cliente_id
-- 4.3 We arrange those clients and filter only those who spent more than 300 R$ on products.
GROUP BY clientes.id, clientes.nome
HAVING SUM(vendas.valor_total) > 300
ORDER BY gasto_total_historico DESC;


-- 5 Finally, we use the AVG() function, which returns the average value of a column.
-- 5.1 We select the pet breed and count the total pets per breed.
SELECT 
    raca, 
    COUNT(*) AS total_por_raca
FROM pets
GROUP BY raca
-- 5.2 Now we apply a complex filter:
-- We compare the count of each breed against the global average of pets-per-breed.
-- The subquery calculates the average of all breed counts first.
HAVING COUNT(*) > (
    SELECT AVG(contagem) 
    FROM (SELECT COUNT(*) AS contagem FROM pets GROUP BY raca) AS subconsulta
)
-- 5.3 We then order the results by the count in descending order.
ORDER BY total_por_raca DESC;
