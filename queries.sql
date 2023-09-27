-- PART 1: FILTERS ------------------------------------------

-- 1.1
-- Select all columns from the categories table.
-- Use an ORDER BY clause to sort the results by category_id.
-- Write your answer in the blank space below.
-- Make sure to test it against the northwind database, using
-- either pgAdmin or psql!
SELECT * FROM categories
ORDER BY category_id


-- 1.2
-- Select each city from the employees table without any duplicates
-- and order the results by descending order.
--
-- Hint: Use the DISTINCT keyword at the appropriate place in your query. 
SELECT DISTINCT city
FROM employees
ORDER BY city DESC;



-- 1.3
-- Select the product_id and product_name columns from the products table,
-- only selecting products that are discontinued.
-- Order the results by product_id.
--
-- Hint: To check if a product is discontinued, use the WHERE clause to
-- filter for rows/records where the discontinued field is equal to true. 
SELECT product_id, product_name
FROM products
WHERE product_id = 'discontinued'
ORDER BY product_id;



-- 1.4
-- Select the first_name and last_name from the employees table, of
-- employees who do not have anyone to report to
-- (i.e. those WHERE the reports_to field IS NULL).
-- Order the results by employee_id.
SELECT first_name, last_name
FROM employees
WHERE reports_to IS NULL
ORDER BY employee_id;


-- 1.5
-- Select the product_name of each product where the units_in_stock is 
-- less than or equal to the reorder_level.
-- You only need the products that are not discontinued.
-- Also, only include products that have more than 0 units_on_order.
-- Order the results by product_id.
--
-- Hint: Start simple. First, write and test your SELECT query for just
-- the product_name from the products table, without any restricting clauses,
-- and confirm you're getting the data that you expect.
-- Then add each of the clauses, one by one, testing after each one,
-- until you reach the final result.
SELECT product_name 
FROM products
WHERE units_in_stock <= reorder_level AND product_name != 'discontinued' AND units_on_order > 0
ORDER BY product_id;





-- PART 2: FUNCTIONS AND GROUPING ------------------------------------------

-- Here are some real queries you might be asked on a day-to-day basis.
-- Sometimes SQL is the fastest and most elegant way to get this data.



-- 2.1
-- How many orders have been made?
-- Write a SELECT query that will count all rows/records in the orders table.
SELECT COUNT(*) FROM orders;



-- 2.2
-- How many orders has each customer made?
-- To find this, select the customer_id and COUNT(order_id) AS order_count
-- from the orders table. Group the results by customer_id. 
-- Finally, order the results first by the order_count (descending),
-- then customer_id.
-- Think carefully about how this query answers the question, how many
-- orders has each customer made?
SELECT customer_id, COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
ORDER BY order_count DESC, customer_id DESC;



-- 2.3
-- Which ship_address are we shipping the most orders to?
-- From the orders table, select the ship_address and the count of all the 
-- orders as order_count.
-- Group the results by ship_address.
-- Order the results by order_count, descending.
-- Finally, use a LIMIT clause to limit the results to the
-- single topmost row only.
--
-- Note: consider how we might extend this query, applying it to each customer. 
-- Combined with a location-based mapping service, you could easily see 
-- where you're selling a lot of products,
-- and where you might want to focus more advertising - a great data
-- science application! We will take a closer look at data science and
-- data visualizations in a future lesson.
SELECT COUNT(orders) AS order_count, ship_address
FROM orders
GROUP BY ship_address
ORDER BY order_count DESC
LIMIT 31;



-- 2.4
-- Let's say we want to offer a new freight discount, but only to customers
-- who have spent more than $500 total across all of their orders.
-- Whom could we offer this new discount campaign to?
--
-- Select customer_id and SUM(freight) from the orders table.
-- SUM(freight) will give us a total of the freight cost across
-- all of each customer's orders.
-- Group the results by customer_id
-- Use the HAVING clause to only include results where the SUM(freight) 
-- is more than $500. 
-- Order the results by customer_id.

SELECT SUM(freight), customer_id
FROM orders
GROUP BY customer_id
HAVING SUM(freight) > 500
ORDER BY customer_id;



-- 2.5
-- Let's say we want to analyze possibly consolidating the shippers we use.
-- To do this, we need to consider: 
-- How many different shippers does each customer deal with on average?
-- 
-- This is a complex query. We can use the WITH keyword to create a CTE
-- (Common Table Expression), which is a temporary table that helps us to
-- break a complex query down into simpler parts. 
--
-- Below, part of the WITH query has been provided for you. The WITH 
-- keyword is used to create a CTE named shippers_per_customer.
-- Your first task: Inside the parentheses that follow, where indicated
-- by the comment, replace the comment with your first SELECT query.
-- This query should select COUNT(DISTINCT ship_via), aliased as 
-- shipper_count, from the orders table.
-- Group the results by customer_id. 
-- The result set from this query comprises the CTE. 
-- 
-- Then, where indicated below that, replace the second comment with 
-- your second SELECT query. This query should select the average of the
-- shipper_count fields from the shippers_per_customer table (the CTE that
-- was created by the WITH query).

WITH shippers_per_customer AS (SELECT COUNT(DISTINCT ship_via) AS shipper_count
FROM orders
GROUP BY customer_id)
SELECT AVG(shipper_count)
FROM shippers_per_customer;




-- PART 3: MIX AND MATCH ------------------------------------------

-- 3.1
-- How can we list each product_name and its corresponding category_name?
-- We only want to include products that have a non-null category_id.
--
-- For this, you can use an inner JOIN on two tables: products and
-- categories. Remember that you don't actually need to use the INNER
-- keyword, you can just use JOIN, as INNER is the default type of JOIN. 
--
-- The first two lines of the query have been provided for you below. 
-- Notice that the products table has been aliased as the letter 'p'
-- in the FROM line.

-- After that line, write a JOIN statement that joins the 
-- categories table (aliasing it as the letter 'c'), selecting only the
-- records where the category_id field in the products table is equal to
-- the category_id field in the categories table.
-- Order the results by the product_id of the products table.  

SELECT p.product_name, c.category_name 
FROM products p 
INNER JOIN categories c ON p.category_id = c.category_id
ORDER BY product_id;



-- 3.2
-- HR wants to do a staff audit across the regions.
-- They want the region_description, territory_description, employee last_name,
-- and employee first_name for each territory and region an employee works in.
-- To make it easier for them, we will remove duplicate results and also sort first by
-- region_description, then territory_description, then last_name, and finally first_name.
--
-- You will need to make joins across four different tables for this: employees,
-- employees_territories, territories, and regions. Joins can only take two tables at a
-- time, but you can use multiple joins in one query by listing each JOIN after the other.
-- 
-- The first three lines of this query have been provided for you below. 
-- The DISTINCT clause in the first line will cause duplicate records to be removed.
-- The provided first JOIN for the employees_territories table finds records with matching
-- values ON employee_id in the employees and employees_territories tables.
--
-- Notice that the employees table has been aliased as 'e' and the 
-- employees_territories table has been aliased as 'et'.
-- 
-- Below this, write a second JOIN for the territories table. This JOIN should 
-- find records with matching values ON territory_id in the employees_territories
-- table (aliased as 'et') and territory_id in the territories table (aliased as 't').
--
-- Below the second JOIN, write a third and final JOIN for the regions table.
-- This JOIN should find records with matching values ON region_id in the territories
-- table (aliased as 't') and region_id in the regions table (aliased as 'r').
-- 
-- Finally, order the results by region description, territory description, employee 
-- last name, and employee first name. Use the table aliases before each column name.

SELECT DISTINCT r.region_description, t.territory_description, e.last_name, e.first_name
FROM employees e
JOIN employees_territories et ON e.employee_id = et.employee_id
JOIN territories t ON et.territory_id = t.territory_id
JOIN regions r ON t.region_id = r.region_id
ORDER BY r.region_description, t.territory_description, e.last_name, e.first_name;



-- 3.3
-- Finance is doing an audit and has requested a list of each customer in the 
-- different states.
-- They want the state_name, state_abbr, and company_name for all customers in the U.S.
-- 
-- If a state has no customers, still include it in the result with a NULL
-- placeholder for the company_name.
-- In this case, the us_states table will be the left-side table, and the
-- customers table will be the right-side table. 
-- Consider what type of JOIN you will need in order to include results where the
-- right-side table has NULL values. (It's not an inner JOIN this time!)
--
-- The first two lines have been provided for you. 
-- After the provided FROM line, write the appropriate type of JOIN statement to
-- join the customers table, aliased as 'c', to the us_states table, which has
-- been aliased for you as 's'. 
-- This JOIN should find records with matching values ON state_abbr in the us_states 
-- table and region in the customers table. This is because in the customers table,
-- for customers in the U.S., the region fields contain state abbreviations,
-- i.e. AZ or NY. 
-- 
-- Finally, order the results by state_name.

SELECT s.state_name, s.state_abbr, c.company_name
FROM us_states s
LEFT JOIN customers c ON s.state_abbr = c.region
ORDER BY state_name;



-- 3.4
-- The Talent Acquisition team is looking to fill some open positions.
-- They want you to get them the territory_description and region_description
-- for territories that do not have any employees, sorted by territory_id.
--
-- Let's tackle this one piece at a time. 
-- In order to achieve this result set, we will need to join the territories
-- and regions table together.
-- So first, select the territory_description column of the territories table,
-- aliased as t, and the region_description of the regions table, aliased as r.
-- Write a FROM statement for the territories table. Alias it as 't' as you do so. 
-- Then, write a JOIN statement, joining the regions table, aliasing it as 'r'. 
-- This JOIN should find records with matching values ON region_id in the
-- territories and regions tables. 
--
-- If you run the query you've constructed at this point, you should see a result
-- set that contains territory descriptions and corresponding region descriptions.
-- But we're not done! We want only records WHERE the territories do not have any
-- employees. 
-- 
-- Below the JOIN statement, write a WHERE statement to create a subquery.
-- Find WHERE the territory_id in the territories table is NOT IN the result set
-- from a subquery that selects the territory_id from the employee_territories table. 

-- Finally, take the final result set and order by territory_id.

SELECT t.territory_description, r.region_description
FROM territories t
JOIN regions r ON r.region_id = t.region_id
WHERE territory_id NOT IN (SELECT territory_id FROM employee_territories)
ORDER BY territory_id;

-- 3.5
-- Management needs a list of all suppliers' and customers' contact information 
-- for the holiday greeting cards!
-- Select company_name, address, city, region, postal_code, and country 
-- from all suppliers and all customers. 
-- Order the result set by company_name.
--
-- Hint: While there are other ways, this is a good chance to use the UNION
-- operator, as demonstrated in the lesson SQL Set Operations.

SELECT company_name, address, city, region, postal_code, country
FROM suppliers
UNION ALL
SELECT company_name, address, city, region, postal_code, country
FROM customers
ORDER BY company_name;




-- BONUS (optional)
-- 3.6
-- And of course, our famous holiday gift baskets go out to our best customers.
-- We want to figure out which customers have ordered a total of 500 or more
-- in quantity. 
--
-- This will require two JOINs. You will first need to JOIN the order_details
-- table with the orders table. Then, you will need to join the orders table
-- with the customers table. It's up to you to determine which JOIN type.
--
-- To begin, select the company_name of the customers table, and the SUM of
-- the quantity of the order_details table. Use aliases as you feel appropriate.
-- The order_details table will be the left side of the first join. Thus, write
-- a FROM for the order_details table.
-- Below this, write a JOIN to join the orders table, finding the records with
-- matching values ON order_id in the order_details and orders tables. 
-- Below this, write a second JOIN to join the customers table, finding the 
-- records with matching values ON customer_id in the orders and customers 
-- tables.
-- 
-- Group the result by the customer_id column of the customers table. 
-- Filter out only those HAVING a SUM of the quantity of the order_details table
-- that is greater than or equal to 500. 
--
-- Finally, order by the SUM of the quantity of the order_details table, 
-- in descending order.