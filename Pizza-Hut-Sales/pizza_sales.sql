-- Selecting all records from the 'orders' table to inspect the data.
select * from orders;

-- Selecting all records from the 'order_details' table, which likely contains details about each order.
select * from order_details;

-- Selecting all records from the 'pizzas' table, which likely holds information about the pizzas such as price and size.
select * from pizzas;

-- Selecting all records from the 'pizza_types' table, which categorizes pizzas (e.g., vegetarian, meat, etc.).
select * from pizza_types;

-- Query to get the maximum price for each pizza category. The result is rounded to 2 decimal places.
select pizza_types.category, round(max(pizzas.price), 2) as max_price
from pizzas
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
group by pizza_types.category;

-- Query to get the average price of pizzas based on the quantity ordered. The result is rounded to 2 decimal places.
select order_details.quantity, round(avg(pizzas.price), 2) as total_price
from pizzas
join order_details ON order_details.pizza_id = pizzas.pizza_id
group by order_details.quantity;

-- Query to count how many times each quantity of pizza has been ordered.
select order_details.quantity, count(*) as quantity_count
from order_details
join pizzas ON order_details.pizza_id = pizzas.pizza_id
group by order_details.quantity;

-- Query to get the total quantity of pizzas ordered by category, sorted by total quantity in descending order.
select pizza_types.category, sum(order_details.quantity) as total_quantity
from pizza_types
join pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details ON order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category
order by total_quantity DESC;

-- Query to get the total quantity of pizzas ordered by pizza size.
select pizzas.size, sum(order_details.quantity) as total_quantity
from pizzas
join order_details ON order_details.pizza_id = pizzas.pizza_id
group by pizzas.size;

-- Query to get the total quantity of pizzas ordered by both category and size, with results sorted by category and then by total quantity in descending order.
select pizza_types.category, pizzas.size, sum(order_details.quantity) as total_quantity
from pizza_types
join pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details ON order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category, pizzas.size
order by pizza_types.category, total_quantity DESC;

-- CTE (Common Table Expression) to create a temporary result set with aggregated pizza orders by category and size.
with aggegratedquery as (
    select pizza_types.category as category, pizzas.size as size, sum(order_details.quantity) as total_quantity
    from pizza_types
    join pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
    join order_details ON order_details.pizza_id = pizzas.pizza_id
    group by pizza_types.category, pizzas.size
)
-- Final query using the CTE above, ranking the results by total quantity within each pizza category.
select 
   category,
   size,
   total_quantity,
   RANK() OVER (PARTITION BY category ORDER BY total_quantity DESC) as rank_values
from aggegratedquery;
