create database project;
use project;
show tables;
select * from order_details;
select * from pizzas;
select * from pizza_types;
select count(*) from orders;
describe  orders;
create table orders (
order_id int not null , 
order_date date not null , 
order_time time not null, 
primary key(order_id));
describe orders;