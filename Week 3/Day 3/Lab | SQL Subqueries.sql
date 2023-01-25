# 1. List all films whose length is longer than the average of all the films.
USE sakila;

SELECT title FROM film
WHERE length > (SELECT avg(length) FROM film);

# 2. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT count(inventory_id) FROM inventory
WHERE film_id IN (SELECT film_id FROM film
                  WHERE title = "HUNCHBACK IMPOSSIBLE");

# 3. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor
                   WHERE film_id = (SELECT film_id FROM film
                                    WHERE title LIKE "Alone Trip"));
                                    
# 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion.
# Identify all movies categorized as family films.

SELECT title FROM film
WHERE film_id IN (SELECT film_id FROM film_category
                  WHERE category_id IN (SELECT category_id FROM category
                                        WHERE `name` LIKE "Family"))
                                        LIMIT 10;
                                        
# 5. Get name and email from customers from Canada using subqueries. Do the same with joins.
#Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys,
#that will help you get the relevant information.

SELECT first_name, last_name, email FROM customer
WHERE address_id IN (SELECT address_id FROM address
                     WHERE city_id IN (SELECT city_id FROM city
                                       WHERE country_id IN (SELECT country_id FROM country
                                                            WHERE country LIKE "Canada")));
                                                            
SELECT first_name, last_name, email FROM customer
INNER JOIN address USING (address_id)
INNER JOIN city USING (city_id)
INNER JOIN country USING (country_id)
WHERE country LIKE "Canada";
                                                            
# 6. Which are films starred by the most prolific actor?
# Most prolific actor is defined as the actor that has acted in the most number of films.
# First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

SELECT title FROM film
WHERE film_id IN (SELECT film_id FROM film_actor
                  WHERE actor_id LIKE (SELECT actor_id FROM actor
                                       JOIN film_actor
                                       USING (actor_id)
                                       GROUP BY actor_id
                                       ORDER BY count(actor_id) DESC));

