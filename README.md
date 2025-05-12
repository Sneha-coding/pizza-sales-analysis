# 🍕 Pizza Hut Sales Analysis Using SQL

This project explores a fictional Pizza Hut sales database using SQL. It covers various insights such as total orders, revenue trends, best-selling pizzas, hourly ordering behavior, and category-wise sales performance.

## 📌 Objective

The goal of this analysis is to:

- Understand sales and revenue trends
- Identify the most popular and profitable pizzas
- Analyze order behavior by size, category, and time of day
- Gain insights useful for operational and marketing decisions

## 🧰 Technologies Used
- SQL (Group By, Order By, Subqueries, Joins, Aggregates, CTEs, Window Functions)

## 🗃️ Database Schema

The project is based on the following tables:

- **orders**: order_id, order_date, order_time
- **order_details**: order_details_id, order_id, pizza_id, quantity
- **pizzas**: pizza_id, pizza_type_id, size, price
- **pizza_types**: pizza_type_id, name, category, ingredients

## 📊 Key SQL Analyses

- Retrieve the total number of orders placed.
- Calculate the total revenue generated from pizza sales.
- Identify the highest-priced pizza.
- Identify the most common pizza size ordered.
- List the top 5 most ordered pizza types along with their quantities.
- Join the necessary tables to find the total quantity of each pizza category ordered.
- Determine the distribution of orders by hour of the day.
- Join relevant tables to find the category-wise distribution of pizzas.
- Group the orders by date and calculate the average number of pizzas ordered per day.
- Determine the top 3 most ordered pizza types based on revenue.
- Calculate the percentage contribution of each pizza type to total revenue.
- Analyze the cumulative revenue generated over time.
- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

