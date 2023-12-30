

-- 1. List all customers who live in Texas (use JOINs) 
-- Jennifer Davis, Kim Cruz, Richard Mccrary, Bryan Hardison, and Ian Still
SELECT  first_name, last_name, address, district
FROM customer 
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district LIKE 'Texas';


-- 2. Get all payments above $6.99 with the Customer's Full Name 
SELECT customer.first_name, customer.last_name, payment.amount
FROM customer 
FULL JOIN payment
ON customer.customer_id = payment.customer_id  
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries) 
SELECT first_name, last_name 
FROM customer 
WHERE customer_id in (
	SELECT customer_id 
	FROM payment 
	WHERE amount > 175.00
);


-- 4. List all customers that live in Nepal (use the city table) 
-- There are no customers that live in Nepal in this database. And I am positive
--based on these 2 queries:

SELECT first_name, last_name
FROM customer
WHERE address_id IN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE city = 'Nepal' -- produced NO results, swapped OUT city TO another city AND got results 
    )
);

SELECT * FROM city c WHERE city = 'Nepal' -- NO results


5. Which staff member had the most 
transactions? 
-- Jon Stephens at 181 mil

SELECT payment.staff_id, SUM(payment_id), first_name, last_name -- used sum OF payment id since ALL transcations have their own id
FROM payment
INNER JOIN staff
ON payment.staff_id = staff.staff_id 
GROUP BY payment.staff_id, first_name, last_name   -- note to self: list ALL COLUMNS that dont have FUNCTIONS, GROUP goes BEFORE ORDER BY 
ORDER BY staff_id


6. How many movies of each rating are 
there? 
-- NC-17 209 MOVIES, G - 178 MOVIES, PG-13 224 MOVIES, PG 194 MOVIES, R 196 MOVIES
SELECT * FROM film
SELECT rating, count(title)
FROM film
GROUP BY rating 


7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

SELECT first_name, last_name 
FROM customer 
WHERE customer_id IN ( 
	SELECT customer_id
	FROM payment 
	WHERE amount > 6.99
);


--8. Howmanyfreerentalsdidourstoresgive away?
--There are no rentals that are priced 0.00, however there is 14,562 rentals with payments of negative values

SELECT count(*)
FROM payment
WHERE amount < 0.00

