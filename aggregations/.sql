-- in SQL, aggregate functions are functions that perform a calculation on a set of values to return a single summary value.
-- There are many operations that can be easily performed in SQL, the most known being: MIN(), MAX(), SUM(), COUNT(), AVG().
-- We will be ordering and arraging the data from those operations with GROUP BY or HAVING.

-- 1 In thix example, we use the MIN() function, which bring the smallest value of a selected column.
-- Its possible to see how we're bringing the smallest price from all products on the products table.
-- We also group this by id, meaning it will agreggate each line and its values as if they were their own column of values
select nome, descricao, min(p.preco) as smallest_price
from produtos p
group by p.id
