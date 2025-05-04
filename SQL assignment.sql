--  1. Create a table called employees with the following structure?
-- : emp_id (integer, should not be NULL and should be a primary key)
-- : emp_name (text, should not be NULL)
-- : age (integer, should have a check constraint to ensure the age is at least 18)
-- : email (text, should be unique for each employee)
-- : salary (decimal, with a default value of 30,000).

-- Write the SQL query to create the above table with all constraints.
CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(255) UNIQUE,
    salary DECIMAL(10,2) DEFAULT 30000.00
);
-- 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide 
-- examples of common types of constraints.

-- Constraints are rules applied to database columns to ensure the accuracy, consistency, and integrity of the data. 
-- They prevent invalid data from being inserted or modified, helping enforce the business rules at the database level — not just in application
--  code.
-- Constraint Type	Description	Example
-- PRIMARY KEY	Ensures each row has a unique identifier	emp_id INT PRIMARY KEY
-- NOT NULL	Prevents NULL (empty) values in a column	emp_name TEXT NOT NULL
-- UNIQUE	Ensures all values in a column are unique	email VARCHAR(255) UNIQUE
-- CHECK	Restricts the range of values allowed	age INT CHECK (age >= 18)
-- DEFAULT	Sets a default value if none is provided	salary DECIMAL(10,2) DEFAULT 30000.00
-- FOREIGN KEY	Enforces referential integrity between tables	dept_id INT, FOREIGN KEY (dept_id) REFERENCES departments(id)

-- 3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify  your answer.

-- The NOT NULL constraint ensures that a column must always contain a value — it cannot be left empty during insert or update operations.
-- A  primary key can never contain NULL values.
-- Justification:
-- A primary key uniquely identifies each row in a table.

-- NULL means "unknown" or "missing", and you cannot uniquely identify a row with an unknown value.

-- Additionally, the primary key constraint automatically implies NOT NULL on its columns.

-- 4. Explain the steps and SQL commands used to add or remove constraints on an existing table.
--  Provide an example for both adding and removing a constraint.

-- In MySQL (and most relational databases), you can modify existing tables to add or remove constraints using the ALTER TABLE statement. 
-- Steps to add a constraint:
-- Example – Add a CHECK constraint to ensure salary >= 30000:
-- ALTER TABLE employees
-- ADD CONSTRAINT chk_salary CHECK (salary >= 30000);
-- Steps to Remove a Constraint
--  Example – Drop a named CHECK constraint:
-- ALTER TABLE employees
-- DROP CHECK chk_salary;

-- 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.  
-- Provide an example of an error message that might occur when violating a constraint.

-- Constraints are designed to enforce rules on the data in a database. 
-- If you try to insert, update, or delete data that violates these rules, the database will reject the operation and return an error. 
-- This ensures data integrity is preserved.
-- Example: Action: Insert a value into a foreign key column that doesn't exist in the referenced table.
-- Consequence: The insert/update is rejected.
-- Example Error:
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails

-- 6. You created a products table without constraints as follows:

-- CREATE TABLE products (

--     product_id INT,

--     product_name VARCHAR(50),

--     price DECIMAL(10, 2));
-- Now, you realise that?
-- : The product_id should be a primary keyQ
-- : The price should have a default value of 50.00

CREATE TABLE products (
product_id INT,
product_name VARCHAR(50),
price DECIMAL(10, 2));
-- Modifying table constraints:

Alter table products
Add primary key (product_id);

Alter table products
MODIFY price DECIMAL(10,2) DEFAULT 50.00;

-- 7. You have two tables: Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

create table Classes(
class_id int primary key,
class_name varchar(50));

create table students(
student_id int primary key,
student_name varchar(50),
class_id INT,
foreign key (class_id) references classes(class_id));

select s.student_name, c.class_name
from students s
join classes c
on s.class_id= c.class_id;


-- 8. Consider the following three tables: Write a query that shows all order_id, customer_name, and product_name, ensuring that 
-- all products are listed even if they are not associated with an order 
create table orders1(
order_id int primary key,
order_date date,
customer_id int);

create table Customers1(
customer_id int primary key,
customer_name varchar(30));

create table products1(
product_id int primary key,
product_name varchar(50),
order_id int);


SELECT 
    o1.order_id,
    c1.customer_name,
    p1.product_name
FROM 
    products1 p1
LEFT JOIN orders1 o1 ON p1.order_id = o1.order_id
INNER JOIN customers1 c1 ON o1.customer_id = c1.customer_id;

-- 25 Given the following tables: Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.

create table sales1(
sale_id int primary key,
product_id int,
amount int);

alter table products1
drop column order_id;

SELECT 
    p1.product_name,
    sum(s.amount) AS total_sales
FROM 
    products1 p1
INNER JOIN sales1 s ON p1.product_id = s.product_id
GROUP BY 
    p1.product_id, p1.product_name;
    
-- 10. You are given three tables: Write a query to display the order_id, customer_name, and the quantity of products ordered by each
-- customer using an INNER JOIN between all three tables.
create table order_details1(
order_id int,
product_id int,
quantity int);
insert into order_details1
values (2, 101, 3);
select * from customers1;

select o1.order_id, c1.customer_name, od.quantity from
orders1 o1 inner join customers1 c1 on o1.customer_id = c1.customer_id
inner join order_details1 od on o1.order_id = od.order_id;

-- SQL Commands
-- 1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences 
-- Table Name	Primary Key(s)	Foreign Key(s)
-- actor	      actor_id	     —
-- film        	film_id	language_id, original_language_id → language(language_id)
-- film_actor	Composite (film_id, actor_id)	film_id → film, actor_id → actor
-- category	category_id	—
-- film_category	Composite (film_id, category_id)	film_id → film, category_id → category
-- language	    language_id	—
-- customer	     customer_id	       store_id → store, address_id → address
-- store	    store_id address_id, 	manager_staff_id → staff
-- staff	staff_id address_id,		 store_id → store
-- address		address_id			city_id → city
-- city			city_id				country_id → country
-- country		country_id	—
-- rental	rental_id	inventory_id → inventory, customer_id → customer, staff_id → staff
-- inventory	inventory_id	film_id → film, store_id → store
-- payment	payment_id	customer_id, staff_id, rental_id
-- film_text	film_id	(same as film, no foreign key)
-- Difference between primary and foreign key:
-- A primary key uniquely identifies each row in a table and cannot contain NULL values.
--  A foreign key is a column that refers to the primary key of another table to establish a relationship between the two tables. 
-- While a table can have only one primary key, it can have multiple foreign keys.

-- 2. List all details of actors
select * from actor;

 -- 3. List all customer information from DB.
 select * from customer;
 
 -- 4 -List different countries.
select * from country;

-- 5 -Display all active customers.
select * from customer
where active = 1; 

-- 6 -List of all rental IDs for customer with ID 1.
select rental_id from rental
where customer_id = 1;

-- 7 - Display all the films whose rental duration is greater than 5 .
select title from film
where rental_duration > 5; 

-- 8 - List the total number of films whose replacement cost is greater than $15 and less than $20
SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;

 -- 9 - Display the count of unique first names of actors.
 select count(distinct first_name) from actor;
 
 -- 10- Display the first 10 records from the customer table .
 SELECT * FROM customer
LIMIT 10;

-- 11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
select * from customer
where first_name LIKE 'B%'
LIMIT 3;

-- 12 -Display the names of the first 5 movies which are rated as ‘G’.
SELECT title FROM film WHERE rating = 'G'
LIMIT 5; 

-- 13-Find all customers whose first name starts with "a".
select * from customer where first_name like 'a%'; 

--  14- Find all customers whose first name ends with "a".
 select * from customer where first_name like '%a'; 
 
 -- 15- Display the list of first 4 cities which start and end with ‘a’ .
 select * from city
 where city like 'a%a' limit 4;
 
--  16- Find all customers whose first name have "NI" in any position.
select * from customer where first_name like '%ni%';

-- 17- Find all customers whose first name have "r" in the second position .
SELECT * FROM customer
WHERE first_name LIKE '_r%';

-- 18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.

SELECT * FROM customer
WHERE first_name LIKE 'A%' 
AND CHAR_LENGTH(first_name) >= 5;
 
 -- 19- Find all customers whose first name starts with "a" and ends with "o".
 select * from customer
 where first_name like 'a%o';
 
 -- 20 - Get the films with pg and pg-13 rating using IN operator.
 SELECT * FROM film WHERE rating IN ('PG', 'PG-13');
 
 -- 21 - Get the films with length between 50 to 100 using between operator. 
 SELECT * FROM film
WHERE length BETWEEN 50 AND 100;

-- 22 - Get the top 50 actors using limit operator.
select * from actor limit 50;

-- 23 - Get the distinct film ids from inventory table.
select distinct film_id from inventory; 

-- Functions
-- Basic Aggregate Functions:
-- Question 1: Retrieve the total number of rentals made in the Sakila database.

select count(*) from rental;

-- Question 2:
-- Find the average rental duration (in days) of movies rented from the Sakila database.
SELECT AVG(DATEDIFF(return_date, rental_date)) AS average_rental_duration FROM rental
WHERE return_date IS NOT NULL;

-- String Functions:
-- Question 3:
-- Display the first name and last name of customers in uppercase.
select upper(first_name), upper(last_name) from customer;

-- Question 4:
-- Extract the month from the rental date and display it alongside the rental ID.
select rental_id, month(rental_date) from rental;

-- GROUP BY:
-- Question 5:
-- Retrieve the count of rentals for each customer (display customer ID and the count of rentals)
SELECT customer_id, COUNT(*) 
FROM rental
GROUP BY customer_id;

-- Question 6:
-- Find the total revenue generated by each store.
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN staff s ON p.staff_id = s.staff_id
GROUP BY s.store_id;

-- Question 7:
-- Determine the total number of rentals for each category of movies.
SELECT c.name AS category, COUNT(*) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_rentals DESC;

-- Question 8:
-- Find the average rental rate of movies in each language.
-- Hint: JOIN film and language tables, then use AVG () and GROUP BY.
SELECT l.name AS language, AVG(f.rental_rate) AS average_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name
ORDER BY average_rental_rate DESC;

-- Joins
-- Questions 9 -
-- Display the title of the movie, customer s first name, and last name who rented it.

SELECT 
    film.title AS movie_title,
    customer.first_name,
    customer.last_name
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN customer ON rental.customer_id = customer.customer_id;

-- Question 10:
-- Retrieve the names of all actors who have appeared in the film "Gone with the Wind."

SELECT actor.first_name, actor.last_name
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE film.title = 'Gone with the Wind';

-- Question 11:
-- Retrieve the customer names along with the total amount they've spent on rentals.
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS total_spent
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
JOIN rental ON payment.rental_id = rental.rental_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total_spent DESC;

-- Question 12:
-- List the titles of movies rented by each customer in a particular city (e.g., 'London').

SELECT city.city, customer.first_name, customer.last_name,film.title AS rented_movie
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE city.city = 'YourCityName'
ORDER BY customer.last_name, customer.first_name, film.title;

-- Advanced Joins and GROUP BY:
-- Question 13:
-- Display the top 5 rented movies along with the number of times they've been rented.
SELECT film.title, COUNT(rental.rental_id) AS times_rented
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id, film.title
ORDER BY times_rented DESC LIMIT 5;

-- Question 14:
-- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).

SELECT customer.customer_id, customer.first_name, customer.last_name
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
HAVING COUNT(DISTINCT inventory.store_id) = 2;

-- Windows Function:
-- 1. Rank the customers based on the total amount they've spent on rentals.

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(payment.amount) DESC) AS spending_rank
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY spending_rank;

-- 2. Calculate the cumulative revenue generated by each film over time.
SELECT 
    f.title AS film_title,
    DATE(r.rental_date) AS rental_date,
    SUM(p.amount) AS daily_revenue,
    SUM(SUM(p.amount)) OVER (PARTITION BY f.film_id ORDER BY DATE(r.rental_date)) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.film_id, f.title, DATE(r.rental_date)
ORDER BY f.title, rental_date;

-- 3. Determine the average rental duration for each film, considering films with similar lengths.
SELECT 
    f.title AS film_title,
    f.length AS film_length,
    AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_rental_duration_days
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NOT NULL
GROUP BY f.film_id, f.title, f.length
ORDER BY avg_rental_duration_days DESC;
 
--  4. Identify the top 3 films in each category based on their rental counts.
WITH RankedFilms AS (
    SELECT 
        c.name AS category_name,
        f.title AS film_title,
        COUNT(r.rental_id) AS rental_count,
        ROW_NUMBER() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS film_rank
    FROM film f
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY c.category_id, c.name, f.film_id, f.title
)
SELECT 
    category_name,
    film_title,
    rental_count
FROM RankedFilms
WHERE film_rank <= 3
ORDER BY category_name, film_rank;

-- 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
WITH CustomerRentals AS (
    SELECT r.customer_id,
        COUNT(r.rental_id) AS total_rentals
    FROM rental r
    GROUP BY r.customer_id),
AverageRentals AS (SELECT 
        AVG(total_rentals) AS avg_rentals
    FROM CustomerRentals)
SELECT 
    cr.customer_id,
    cr.total_rentals,
    ar.avg_rentals,
    cr.total_rentals - ar.avg_rentals AS rental_difference
FROM CustomerRentals cr
JOIN AverageRentals ar
ORDER BY rental_difference DESC;

-- 6. Find the monthly revenue trend for the entire rental store over time.

SELECT 
    YEAR(p.payment_date) AS year,
    MONTH(p.payment_date) AS month,
    SUM(p.amount) AS monthly_revenue
FROM payment p
GROUP BY YEAR(p.payment_date), MONTH(p.payment_date)
ORDER BY year, month;

-- 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
WITH CustomerSpending AS (SELECT 
        p.customer_id,
        SUM(p.amount) AS total_spent
    FROM payment p
    GROUP BY p.customer_id),
RankedCustomers AS (SELECT 
        cs.customer_id,
        cs.total_spent,
        NTILE(5) OVER (ORDER BY cs.total_spent DESC) AS spending_percentile
    FROM CustomerSpending cs)
SELECT 
    customer_id,
    total_spent
FROM RankedCustomers
WHERE spending_percentile = 1  -- This selects the top 20% of customers
ORDER BY total_spent DESC;

-- 8. Calculate the running total of rentals per category, ordered by rental count.

WITH CategoryRentalCounts AS (
    SELECT 
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM 
category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.category_id, c.name)
SELECT 
    category_name,
    rental_count,
    SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total_rentals
FROM CategoryRentalCounts
ORDER BY rental_count DESC;

-- 9. Find the films that have been rented less than the average rental count for their respective categories.

WITH CategoryRentalCounts AS (
    SELECT 
        c.category_id,
        c.name AS category_name,
        f.film_id,
        f.title AS film_title,
        COUNT(r.rental_id) AS rental_count
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.category_id, f.film_id, f.title),
CategoryAverageRentals AS (
    SELECT 
        category_id,
        AVG(rental_count) AS avg_rental_count
    FROM CategoryRentalCounts
    GROUP BY category_id)
SELECT 
    crc.category_name,
    crc.film_title,
    crc.rental_count,
    car.avg_rental_count
FROM CategoryRentalCounts crc
JOIN CategoryAverageRentals car ON crc.category_id = car.category_id
WHERE crc.rental_count < car.avg_rental_count
ORDER BY crc.category_name, crc.rental_count;

-- 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.
SELECT 
    YEAR(p.payment_date) AS year,
    MONTH(p.payment_date) AS month,
    SUM(p.amount) AS monthly_revenue
FROM payment p
GROUP BY YEAR(p.payment_date), MONTH(p.payment_date)
ORDER BY monthly_revenue DESC
LIMIT 5;

-- Normalisation & CTE
-- 1. First Normal Form (1NF):
-- a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF

-- A table in the Sakila database that could violate 1NF is the rental table if it stored multiple inventory_id values in a single column
--  (e.g., comma-separated). This would violate 1NF because the column would contain non-atomic (multi-valued) data.
--  To normalize it to 1NF, we would split the multiple inventory_id values into separate rows, ensuring each column contains only atomic values
--  and each row is unique. This ensures that each rental corresponds to a single film, adhering to 1NF.

-- 2. Second Normal Form (2NF):
-- a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
-- If it violates 2NF, explain the steps to normalize it.

-- To determine if a table is in 2NF, first ensure it's in 1NF and then check for partial dependencies 
-- (where non-key attributes depend only on part of a composite primary key). For example, in the rental table,
--  if the primary key was a composite of customer_id and inventory_id, and attributes like staff_id only depended on 
--  store_id (part of the key), this would violate 2NF. To normalize, we would remove partial dependencies by creating a 
--  separate staff table and linking it via a foreign key, ensuring all non-key attributes depend on the full primary key.

-- 3. Third Normal Form (3NF):
-- a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the 

-- In the Sakila database, the film table could violate 3NF due to transitive dependencies. For example, the film table might have 
-- attributes like language_id, which references the language table, and language table might contain information like language_name.
--  This creates a transitive dependency, where film.language_id indirectly determines language_name through the language table.
-- To normalize it to 3NF, we would remove the transitive dependency by eliminating the language_name from the film table and ensuring 
-- it's only in the language table, keeping only the language_id in the film table.

-- 4. Normalization Process:
-- a. Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.

-- Let's take the rental table in the Sakila database and guide through the normalization process.
-- Unnormalized Form (UNF): In the unnormalized form, we might have a single row containing multiple rental details for a customer, 
-- like multiple inventory_id values (films rented) and payment_id values in one column.
-- 1NF: To bring the table to 1NF, we split any repeating groups (e.g., multiple inventory_id values) into separate rows, ensuring 
-- each column contains atomic values. This gives us one row per rental.
-- 2NF: If the table had a composite primary key (e.g., customer_id and inventory_id), we would check for partial dependencies. 
-- Any attribute not fully dependent on the entire composite key (like staff_id depending only on the store_id) would be moved to a 
-- separate table. After this, the table would contain only attributes fully dependent on the whole primary key.
-- By following these steps, we can normalize the rental table from an unnormalized form to 2NF.

-- 5. CTE Basics:
-- a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they  have acted in from the act

WITH ActorFilmCount AS (
    SELECT 
        a.actor_id, 
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name, 
        COUNT(f.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    JOIN film f ON fa.film_id = f.film_id
    GROUP BY a.actor_id, actor_name)
SELECT actor_name, film_count
FROM ActorFilmCount
ORDER BY film_count DESC;

-- 6. CTE with Joins:
-- a. Create a CTE that combines information from the film and language tables to display the film title, language name, and rental rate.
WITH FilmLanguageInfo AS (
    SELECT 
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id)
SELECT 
    film_title,
    language_name,
    rental_rate
FROM FilmLanguageInfo;

-- 7. CTE for Aggregation:
-- a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables.

WITH CustomerRevenue AS (
    SELECT 
        p.customer_id, 
        SUM(p.amount) AS total_revenue
    FROM payment p
    GROUP BY p.customer_id)
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    cr.total_revenue
FROM customer c
JOIN CustomerRevenue cr ON c.customer_id = cr.customer_id
ORDER BY cr.total_revenue DESC;

-- 8. CTE with Window Functions:
-- a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.

WITH FilmRentalRank AS (
    SELECT 
        f.film_id,
        f.title AS film_title,
        f.rental_duration,
        RANK() OVER (ORDER BY f.rental_duration DESC) AS rental_rank
    FROM film f)
SELECT 
    film_id,
    film_title,
    rental_duration,
    rental_rank
FROM FilmRentalRank
ORDER BY rental_rank;

-- 9.CTE and Filtering:
-- a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional 

WITH CustomerRentalCount AS (
    SELECT 
        r.customer_id, 
        COUNT(r.rental_id) AS rental_count
    FROM rental r
    GROUP BY r.customer_id
    HAVING COUNT(r.rental_id) > 2)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    crc.rental_count
FROM customer c
JOIN CustomerRentalCount crc ON c.customer_id = crc.customer_id
ORDER BY crc.rental_count DESC;

-- 10. CTE for Date Calculations: 
-- a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table

WITH MonthlyRentalCount AS (
    SELECT 
        YEAR(r.rental_date) AS rental_year,
        MONTH(r.rental_date) AS rental_month,
        COUNT(r.rental_id) AS total_rentals
    FROM rental r
    GROUP BY rental_year, rental_month)
SELECT 
    rental_year,
    rental_month,
    total_rentals
FROM MonthlyRentalCount
ORDER BY rental_year DESC, rental_month DESC;

-- 11. CTE and Self-Join: 
-- a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.
WITH ActorPairs AS (
    SELECT 
        fa1.actor_id AS actor1_id, 
        fa2.actor_id AS actor2_id, 
        fa1.film_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE fa1.actor_id < fa2.actor_id  -- Avoids duplicating pairs like (1,2) and (2,1)
        )
SELECT 
    a1.first_name AS actor1_first_name, 
    a1.last_name AS actor1_last_name, 
    a2.first_name AS actor2_first_name, 
    a2.last_name AS actor2_last_name, 
    ap.film_id
FROM ActorPairs ap
JOIN actor a1 ON ap.actor1_id = a1.actor_id
JOIN actor a2 ON ap.actor2_id = a2.actor_id
ORDER BY ap.film_id;

-- 12. CTE for Recursive Search:
--  a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to colum
WITH RECURSIVE EmployeeHierarchy AS (
    -- Anchor member: Select the manager (e.g., manager_id = 1)
    SELECT 
        s.staff_id, 
        s.first_name, 
        s.last_name, 
        s.manager_id  -- Assuming manager_id is the correct column name
    FROM 
        staff s
    WHERE 
        s.staff_id = 1  -- Replace with the manager's staff_id (e.g., manager_id = 1)
    
    UNION ALL
    
    -- Recursive member: Find employees who report to the selected staff member
    SELECT 
        s.staff_id, 
        s.first_name, 
        s.last_name, 
        s.manager_id  -- Assuming manager_id is the correct column name
    FROM 
        staff s
    JOIN 
        EmployeeHierarchy eh ON s.manager_id = eh.staff_id  -- Adjusted for manager_id
)
-- Final query to retrieve all employees who report to the specific manager
SELECT 
    staff_id, 
    first_name, 
    last_name, 
    manager_id  -- Assuming manager_id is the correct column name
FROM 
    EmployeeHierarchy;  -- Corrected reference to CTE (not table)




