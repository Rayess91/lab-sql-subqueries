USE Sakila;

#1-Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film
WHERE title = 'Hunchback Impossible');


#2-List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT * FROM film 
WHERE length > (SELECT AVG(length) 
FROM film);

#3- Use a subquery to display all actors who appear in the film "Alone Trip".


SELECT first_name, last_name FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor
WHERE film_id = (SELECT film_id FROM film
WHERE title = 'Alone Trip'));

#BONUS: 
#4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT title FROM film
WHERE film_id IN (SELECT film_id FROM film_category
WHERE category_id = (SELECT category_id FROM category
WHERE name = 'Family'));

#5- Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT * FROM customer;
SELECT * FROM country;
SELECT * FROM city;
SELECT * FROM address;

SELECT first_name, last_name, email 
FROM customer c
JOIN address a ON a.address_id = c.address_id
WHERE city_id IN (SELECT city_id FROM city
WHERE country_id = (SELECT country_id FROM country
WHERE country = 'Canada'));

#6-Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT * FROM film;
SELECT * FROM film_text;

#finding most prolific actor
SELECT fa.actor_id, a.first_name, a.last_name, COUNT(*) AS Number_of_acts
FROM film_actor fa
JOIN actor a ON a.actor_id = fa.actor_id
GROUP BY actor_id
ORDER BY COUNT(*) DESC;

#most prolific actor_id is 107

SELECT f.title, concat(a.first_name,' ', a.last_name) as starred_by
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON a.actor_id = fa.actor_id
WHERE fa.actor_id = '107';






