use project;
select * from pizza_types;
select * from pizzas;
select * from orders;
select * from order_details;

-- Task 1: Retrieve the total number of orders placed
select count(order_id) as total_orders_placed 
from orders;

-- Task 2: Calculate the total revenue generated from pizza sales.
-- total revenue = quantity * price 
with quantity as (
select pizza_id , sum(quantity)  as pizza_quantity
from order_details
group by pizza_id) ,
costing as (select t2.price*t1.pizza_quantity as cost 
from quantity t1
join pizzas  t2 on t1.pizza_id = t2.pizza_id )
select round(sum(cost),2) as total_revenue 
from costing;


-- or option 2--> 
SELECT 
    ROUND(SUM(o.quantity * p.price), 2) AS total_sales
FROM
    order_details o
        JOIN
    pizzas p ON p.pizza_id = o.pizza_id;

-- Task 3: Identify the highest-priced pizza.
SELECT 
    pt.name, p.size, p.price
FROM
    pizzas p
        JOIN
    pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
WHERE
    price = (SELECT 
            MAX(price) AS highest_price
        FROM
            pizzas);
            
-- option 2
SELECT 
    pt.name, p.size, p.price
FROM
    pizza_types pt
    right    JOIN
    pizzas p ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

-- Task 4: Identify the most common pizza size ordered

SELECT 
    p.size, COUNT(o.order_details_id) AS total_count
FROM
    order_details o
     Right   JOIN
    pizzas p ON o.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_count DESC
LIMIT 1;
