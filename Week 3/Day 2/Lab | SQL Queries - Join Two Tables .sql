USE sakila;

# 1. Which actor has appeared in the most films?
SELECT first_name, last_name, count(film_id) FROM actor
INNER JOIN film_actor
USING (actor_id)
GROUP BY actor_id
ORDER BY count(film_id) DESC
LIMIT 1;

# 2. Most active customer (the customer that has rented the most number of films)
SELECT first_name, last_name, count(customer_id) FROM rental
INNER JOIN customer USING (customer_id)
GROUP BY customer_id
ORDER BY count(customer_id) DESC
LIMIT 1;

# 3. List number of films per category.
SELECT `name`, count(category_id) FROM category
INNER JOIN film_category USING (category_id)
GROUP BY category_id;

# 4. Display the first and last names, as well as the address, of each staff member.
SELECT first_name, last_name, address FROM staff
INNER JOIN address USING (address_id);

# 5. get films titles where the film language is either English or italian,
# and whose titles starts with letter "M" , sorted by title descending.
SELECT title, `name` FROM film
INNER JOIN `language` USING (language_id)
WHERE `name` = 'English' OR `name` = 'Italian' AND title LIKE 'M%';

# 6. Display the total amount rung up by each staff member in August of 2005.
SELECT first_name, last_name, sum(amount) AS total_amount FROM staff
INNER JOIN payment USING (staff_id)
WHERE payment_date LIKE '2005-08%'
GROUP BY staff_id
ORDER BY total_amount DESC;

# 7. List each film and the number of actors who are listed for that film.
SELECT title, count(actor_id) FROM film_actor
INNER JOIN film USING (film_id)
GROUP BY film_id
ORDER BY count(actor_id) DESC
LIMIT 10;

# 8. Using the tables payment and customer and the JOIN command, list the total paid by each customer.
# List the customers alphabetically by last name.
SELECT first_name, last_name, sum(amount) AS total_paid FROM payment
INNER JOIN customer USING (customer_id)
GROUP BY customer_id
ORDER BY last_name ASC
LIMIT 10;

# 9. Write sql statement to check if you can find any actor who never particiapted in any film.
SELECT * FROM film_actor
LEFT JOIN film USING (film_id)
WHERE film_id IS NULL;

# 10. get the addresses that have NO customers, and ends with the letter "e"
SELECT * FROM address
LEFT JOIN customer USING (address_id)
WHERE customer_id is null and address LIKE "%e";

# Optional: what is the most rented film?
SELECT title, count(film_id) FROM rental
INNER JOIN inventory USING (inventory_id)
INNER JOIN film USING (film_id)
GROUP BY title
ORDER BY count(film_id) DESC
LIMIT 1;

