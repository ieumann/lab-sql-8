USE sakila;

# 1. Rank films by length (filter out the rows with nulls or zeros in length column). 
# Select only columns title, length and rank in your output.
SELECT title, length, RANK() OVER (ORDER BY length DESC) AS 'rank'
FROM film
WHERE length IS NOT NULL AND length > 0
ORDER BY length;

# 2. Rank films by length within the `rating` category (filter out the rows with nulls or zeros in length column). 
# In your output, only select the columns title, length, rating and rank.  
SELECT title, length, rating, RANK() OVER (PARTITION BY rating ORDER BY length) AS 'rank'
FROM film
WHERE length IS NOT NULL AND length > 0
ORDER BY rating, length;

# 3. How many films are there for each of the categories in the category table? **Hint**: Use appropriate join 
# between the tables "category" and "film_category".
SELECT C.category_id, COUNT(F.film_id) num_films
FROM category AS C
INNER JOIN film_category AS F
ON C.category_id = F.category_id
GROUP BY category_id
ORDER BY category_id;

# 4. Which actor has appeared in the most films? **Hint**: You can create a join between the 
# tables "actor" and "film actor" and count the number of times an actor appears.
SELECT CONCAT(A.first_name, ' ', A.last_name) AS actor, COUNT(F.film_id) AS appearances
FROM actor AS A
INNER JOIN film_actor AS F
ON A.actor_id = F.actor_id
GROUP BY actor
ORDER BY appearances DESC
LIMIT 1;

# 5. Which is the most active customer (the customer that has rented the most number of films)? 
# **Hint**: Use appropriate join between the tables "customer" and "rental" and count the `rental_id` for each customer.
SELECT CONCAT(C.first_name, ' ', C.last_name) AS customer, COUNT(R.rental_id) AS rentals
FROM customer AS C
INNER JOIN rental AS R
ON C.customer_id = R.customer_id
GROUP BY customer
ORDER BY rentals DESC
LIMIT 1;

# **Bonus**: Which is the most rented film? (The answer is Bucket Brotherhood).
# This query might require using more than one join statement. Give it a try. We will talk about queries with multiple 
# join statements later in the lessons.
# **Hint**: You can use join between three tables - "Film", "Inventory", and "Rental" and count the *rental ids* for each film.
SELECT F.title, COUNT(R.rental_id) AS rentals
FROM film AS F
INNER JOIN inventory AS I
ON F.film_id = I.film_id
INNER JOIN rental AS R
ON I.inventory_id = R.inventory_id
GROUP BY F.title
ORDER BY rentals DESC
LIMIT 1;
