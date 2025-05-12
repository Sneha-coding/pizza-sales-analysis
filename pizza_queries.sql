create  database pizzahut;
use pizzahut; 

CREATE TABLE orders (
    order_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    PRIMARY KEY (order_id)
);

CREATE TABLE order_details (
    order_details_id INT NOT NULL,
    order_id INT NOT NULL,
    pizza_id TEXT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_details_id)
);
-- Retrieve the total number of orders placed
SELECT 
    COUNT(1) AS n_orders
FROM
    orders;

-- Calculate the total revenue generated from pizza sales
SELECT 
    ROUND(SUM(quantity * price), 2) AS total_revenue
FROM
    pizzas p
        JOIN
    order_details o ON p.pizza_id = o.pizza_id;

-- Identify the highest-priced pizza
SELECT 
    name, price
FROM
    pizzas p
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
WHERE
    price = (SELECT 
            MAX(price)
        FROM
            pizzas);
            
-- Identify the most common pizza size ordered
SELECT 
    size, COUNT(1) AS common_pizza_size
FROM
    pizzas p
        JOIN
    order_details o ON p.pizza_id = o.pizza_id
GROUP BY size
ORDER BY common_pizza_size DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities
SELECT 
    name, SUM(quantity) AS n_pizzas
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details o ON o.pizza_id = p.pizza_id
GROUP BY name
ORDER BY n_pizzas DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered
SELECT 
    category, SUM(quantity) AS pizza_quantity
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details o ON o.pizza_id = p.pizza_id
GROUP BY category;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS hour_of_the_day, COUNT(1) AS n_pizzas
FROM
    orders
GROUP BY HOUR(order_time);

-- Join relevant tables to find the category-wise distribution of pizzas
SELECT 
    category, COUNT(1) AS n_pizzas
FROM
    pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity), 0) AS avg_pizzas_ordered_per_day
FROM
    (SELECT 
        order_date, SUM(quantity) AS quantity
    FROM
        orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY order_date) AS order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    name, SUM(price * quantity) AS revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY name
ORDER BY revenue DESC
LIMIT 3; 

-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    category,
    (ROUND(SUM(price * quantity) / (SELECT 
                    ROUND(SUM(price * quantity), 2) AS total_sales
                FROM
                    order_details o
                        JOIN
                    pizzas p ON o.pizza_id = p.pizza_id) * 100,
            2)) AS revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details o ON o.pizza_id = p.pizza_id
GROUP BY category
ORDER BY revenue DESC;

-- Analyze the cumulative revenue generated over time.
select order_date, sum(revenue) over(order by order_date) as cummulative_revenue from 
(select order_date, sum(quantity*price) as revenue from orders o 
join order_details od on o.order_id = od.order_id join
pizzas p on p.pizza_id = od.pizza_id group by order_date) as sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
with cte as (select name ,category, sum(price * quantity) as revenue, 
dense_rank() over(partition by category order by sum(price * quantity) desc )as rnk 
from pizza_types pt join pizzas p on pt.pizza_type_id = p.pizza_type_id 
join order_details o on o.pizza_id = p.pizza_id group by 1, 2)
select name, category, revenue from cte where rnk <= 3;
