-- 1.1 Select the names of all the products in the store.
select name 
from products;

-- 1.2 Select the names and the prices of all the products in the store.
select name, price 
from products;

-- 1.3 Select the name of the products with a price less than or equal to $200.
select name, price 
from products 
where price <= 200;

-- 1.4 Select all the products with a price between $60 and $120.
select * 
from products 
where price BETWEEN 60 and 120;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
select name, price*100 
from products;

-- 1.6 Compute the average price of all the products.
select avg(price) 
from products;

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
select avg(price) 
from products 
where manufacturer = 2;

-- 1.8 Compute the number of products with a price larger than or equal to $180.
select count(*) 
from products 
where price >= 180; 

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort 
--first by price (in descending order), and then by name (in ascending order).
select name, price 
from products 
where price >= 180 
order by price DESC, name ASC;

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
select * from products as p
join manufacturers as m 
on p.manufacturer = m.code;

-- 1.11 Select the product name, price, and manufacturer name of all the products.
select p.name as p_name, p.price as p_price, m.name as m_name
from products as p
join manufacturers as m
on p.manufacturer = m.code;

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
select avg(p.price), m.code
from products as p 
join manufacturers as m
on p.manufacturer = m.code
group by m.code;

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
select avg(p.price), m.name
from products as p 
join manufacturers as m
on p.manufacturer = m.code
group by m.name;

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to 
--$150.
select m.name
from manufacturers as m
join products as p
on m.code = p.manufacturer
group by m.name
having avg(p.price) >= 150;     

-- 1.15 Select the name and price of the cheapest product.
select name, price 
from products
order by price asc
limit 1;

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
select m.name, p.name, p.price
from manufacturers as m 
join products as p 
on m.code = p.manufacturer 
group by m.name  
order by p.price;

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
insert into products (Code, Name, Price, Manufacturer) values (11,'Loudspeakers', 70,2);

-- 1.18 Update the name of product 8 to "Laser Printer".
update products 
set name = 'Laser Printer'
where code = 8;

-- 1.19 Apply a 10% discount to all products.
update products
set price = price - (price * 10/100);

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
update products
set price = price - (price * 10/100)
where price >= 120;

