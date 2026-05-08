-- Queries are commands or instructions that allow you to interact with the data inside a relational database.
-- Using SQL, you are able to perform many different actions with said data, like retrieving info, changing info, adding info, besides many other types of data manipulation.

--1  In this first example, the query is used to select the name, species, race and date of birth from all pets in the pets table
select nome, especie, raca, data_nascimento
from pets
--2 Now i am performing the same thing, but i am giving it a condition that only returns me the info for cats
select nome, especie, raca, data_nascimento
from pets
where especie = 'gato'
--3 Now im performing a query on all the pets on the table, but i am ordering by the date of birth, from the youngest to the oldest
select * 
from pets
order by data_nascimento desc
--4 Now i am inserting another pet for the client with the id = 1. Notice how i state the parameters i want to insert and then proceed to name the values
insert into pets (nome, especie, raca, data_nascimento, cliente_id) 
values ('Floflo', 'gato', 'Vira-Lata', '2023-02-10', 1)
--5 Now i am updating Floflo's client_id, now, the client_id registred for the cat floflo is the client of id = 2
update pets 
set cliente_id = 2 
where nome = 'Floflo'
--6 But, for now, i want to delete Floflo from our petshop system.
delete from pets 
where id = 21
