select * from pizza_types;
select * from pizzas;
select * from orders;
select * from order_details;



-- Task 1: List the top 5 most ordered pizza types along with their quantities.

-- option 2-->
SELECT 
    pt.name, sum(o.quantity) AS quantity
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details o ON o.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY quantity DESC
LIMIT 5;

-- have to solve
-- Task 2: Determine the distribution of orders by hour of the day.
select hour(order_time) from orders;
-- distribution -- > hourly orders / total_orders-- wrong 

SELECT 
    HOUR(order_time) AS orderHour,
    COUNT(order_id) AS total_count
FROM
    orders
GROUP BY HOUR(order_time)
ORDER BY orderHour;

-- Task 3: Determine the top 3 most ordered pizza types based on revenue.
select * from pizza_types;
select * from pizzas;
select * from order_details;

select  pt.name, sum((p.price*o.quantity) )as cost
from pizzas p 
join order_details o on o.pizza_id =p.pizza_id
join pizza_types pt on pt.pizza_type_id=p.pizza_type_id
group by pt.name
order by cost desc
limit 3;







