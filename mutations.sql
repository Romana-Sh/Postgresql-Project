-- Part 4: Mutations

-- Management has decided it would like to designate employees as experts of 
-- zero or more categories, and they want the database to keep track of who is
-- an expert in what. 
-- Q: How will you satisfy this new requirement? 
-- A: By using Update statement
-- Q: What type of relationship is this? (e.g. 1-1, 1-many, or many-to-many?)
-- A: 1-many
-- Fill in your answer above. 



-- 4.1: Create table
-- Write a SQL statement that creates a new table meeting the following criteria:
--   1. It is named employees_categories
--   2. It has a employee_id column of type INTEGER
--   3. It has a category_id column of type INTEGER
--   4. Its primary key is a tuple of (employee_id, category_id) pairs



--
-- Test your answer by running it in pgAdmin or psql. Afterward, verify
-- that the employees_categories has been created with the expected columns
-- and primary key. Place your answer in the blank space below. 
CREATE TABLE employees_categories(
    employee_id INT, 
    category_id INT,
    PRIMARY KEY(employee_id, category_id)
);


-- 4.2: Alter table
-- Write ALTER TABLE statement on the employees_categories table. Use it to add
-- a foreign key constraint that creates a relationship between it and the
-- employees table. Name the constraint fk_ec_employees.
-- For the foreign key column, use employee_id from the employees_categories 
-- table. It should reference the primary key of the employees table.
--
-- Test your answer in pgAdmin or psql and verify that it worked correctly, then
-- place it in the blank space below.


ALTER TABLE employees_categories
ADD CONSTRAINT fk_ec_employees
FOREIGN KEY (employee_id) 
REFERENCES employees (employee_id);

-- 4.3: Alter table
-- Write an ALTER TABLE statement on the employees_categories table. Use it to add
-- a foreign key constraint that creates a relationship between it and the categories
-- table. Name the constraint fk_ec_categories.
-- For the foreign key column, use category_id from the employees_categories table.
-- It should reference the primary key of the categories table. 
--
-- Test your answer in pgAdmin or psql and verify that it worked correctly, then
-- place it in the blank space below.

ALTER TABLE employees_categories
ADD CONSTRAINT fk_ec_categories
FOREIGN KEY (category_id) 
REFERENCES categories (category_id);

-- 4.4: Insert records
-- Write an INSERT statement that inserts the following employee ID, category ID pairs 
-- pairs as VALUES into employees_categories:
-- (1,2), (3,4), (4,3), (4,4), (8,2), (1,8), (1,3), (1,6)
--
-- Test your answer in pgAdmin or psql and verify that it worked correctly, then
-- place it in the blank space below.
INSERT INTO employees_categories (employee_id, category_id)
VALUES(1,2), (3,4), (4,3), (4,4), (8,2), (1,8), (1,3), (1,6);


-- 4.5: Remove records
-- Write a statement that deletes all records from employees_categories but does not 
-- delete the employees_categories table itself.
-- Hint: This will only require a single line. Review the different ways 
-- to delete data from a table.
-- 
-- Test your answer in pgAdmin or psql and verify that it worked correctly, then
-- place it in the blank space below.

DELETE FROM employees_categories;

-- Bonus Task (optional)
-- Refer to the new management decision at the top of this file.  
-- Write a query that assigns all employees of the London office to be 
-- experts in the Dairy Products category.
-- Hint: This can be accomplished using an INSERT INTO statement on the
-- employees_categories table, along with two SELECT queries: one from
-- the categories table, and one from the employees table.
--
-- Test your answer in pgAdmin or psql and verify that it worked correctly, then
-- place it in the blank space below.



-- 4.6: Delete table
-- Write a query to delete the employees_categories table entirely,
-- so that it no longer exists in the database at all. Only test this
-- query in pgAdmin or psql after you have completed all the other
-- tasks!
--
-- Test your answer in pgAdmin or psql and verify that it worked correctly, then
-- place it in the blank space below.
