-- Task 1: Join the necessary tables to find the total quantity of each pizza category ordered.
select distinct category from pizza_types;
-- pizza_types --category 
-- quantity -- order_details

SELECT 
    pt.category, SUM(quantity) AS total_quantity
FROM
    order_details o
        JOIN
    pizzas p ON p.pizza_id = o.pizza_id
        JOIN
    pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category;



-- Task 2: Join relevant tables to find the category-wise distribution of pizzas.
with final as (
SELECT 
    pt.category, SUM(quantity) AS total_quantity
FROM
    order_details o
        JOIN
    pizzas p ON p.pizza_id = o.pizza_id
        JOIN
    pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category)
select * , 
total_quantity*100/sum(total_quantity) over() as distribution 
from final;


-- Task 3: Group the orders by the date and calculate the average number of pizzas 
--  ordered per day.

SELECT 
    ROUND(AVG(perDayOrdered), 2) AS avg_order_per_day
FROM
    (SELECT 
        o.order_date, SUM(od.quantity) AS perDayOrdered
    FROM
        orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.order_date) AS table1;
    

