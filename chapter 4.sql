-- Task 1: Calculate the percentage contribution of each pizza type to total revenue.


with pizza_revenue as (select pt.name as name  , sum(p.price*o.quantity) as total_revenue_per_pizza
						from pizzas p 
						join order_details o on o.pizza_id = p.pizza_id 
						join pizza_types pt on pt.pizza_type_id=p.pizza_type_id
						group by pt.name ), 
total_revenue as ( select sum(total_revenue_per_pizza) as total 
					from pizza_revenue)
select  pr.name , round((pr.total_revenue_per_pizza/t.total)*100,2) as revenue_percentage
from pizza_revenue pr , total_revenue t;
-- with category-->
with pizza_revenue as (select pt.category as category  , sum(p.price*o.quantity) as total_revenue_per_pizza
						from pizzas p 
						join order_details o on o.pizza_id = p.pizza_id 
						join pizza_types pt on pt.pizza_type_id=p.pizza_type_id
						group by pt.category ), 
total_revenue as ( select sum(total_revenue_per_pizza) as total 
					from pizza_revenue)
select  pr.category , concat(round((pr.total_revenue_per_pizza/t.total)*100,2), " ","%")  as revenue_percentage
from pizza_revenue pr , total_revenue t;

-- Task 2: Analyze the cumulative revenue generated over time.
-- cumulative revenue -->revenue per day and increase in revenue next day 
-- eg if 200 , 300, 400 then cumulative will be 200,(220+300=)500,(500+400=)900 ie 200,500,900
select * from orders;
select * from order_details;

	select order_date , revenue,
	sum(revenue) over(order by order_date) as cumulative_revenue
	from
	(select o2.order_date  as order_date, sum(o.quantity*p.price) as revenue 
	from pizzas p 
	join order_details o on o.pizza_id=p.pizza_id
	join orders o2 on o2.order_id =o.order_id
	group by o2.order_date) as revenue_table;


-- Task 3: Determine the top 3 most ordered pizza types based on revenue for each pizza category
select * 
from (
select * , 
dense_rank() over(partition by category order by revenue desc) as ranking
from (
select  pt.name , pt.category , 
sum(od.quantity * p.price) as revenue
from pizza_types pt 
join pizzas p on pt.pizza_type_id = p.pizza_type_id 
join order_details od on od.pizza_id =p.pizza_id
group by pt.name , pt.category ) as a) as b
where ranking <=3 ;