use mavenmovies;

/*
1.	We will need a list of all staff members, including their first and last names, 
email addresses, and the store identification number where they work. 
*/ 
select * from staff;
SELECT 
    first_name, last_name, email, store_id
FROM
    staff;
    -- from above query we can have the list
    

/*
2.	We will need separate counts of inventory items held at each of your two stores. 
*/ 
select * from inventory;
SELECT 
    store_id, COUNT(inventory_id) AS total_inventory_items
FROM
    inventory
GROUP BY 1;
-- at store 1 there are total 2,270 inventories items available and store 2 has 2,311 items.


/*
3.	We will need a count of active customers for each of your stores. Separately, please. 
*/
SELECT * FROM customer;
SELECT 
    store_id, COUNT(first_name)
FROM
    customer
WHERE
    active = 1
GROUP BY store_id;
-- Concluson Each stores have total active customers Are AS: for store 1 -318 & for store 2 266.

/*
4.	In order to assess the liability of a data breach, we will need you to provide a count 
of all customer email addresses stored in the database. 
*/
SELECT 
    COUNT(email)
FROM
    customer;
    -- Total 599 email adresses are found in the database.

/*
5.	We are interested in how diverse your film offering is as a means of understanding how likely 
you are to keep customers engaged in the future. Please provide a count of unique film titles 
you have in inventory at each store and then provide a count of the unique categories of films you provide. 
*/
select * from film;
SELECT 
    COUNT(DISTINCT title) AS total_unique_films_titles
FROM
    film;
    -- Total unique film titles are 1000 .

SELECT 
    COUNT(DISTINCT special_features)
FROM
    film;
    -- In inventory films have total 15 nummbers are unique categories 


/*
6.	We would like to understand the replacement cost of your films. 
Please provide the replacement cost for the film that is least expensive to replace, 
the most expensive to replace, and the average of all films you carry. ``	
*/
-- Lets assume if replacement cost is  < 15 than less expensive if bw 15 to 25 avg. expensive and above 25 very expensive for replacement
CREATE VIEW list_of_expense_film_status_view AS
    SELECT 
        title,
        replacement_cost,
        CASE
            WHEN replacement_cost < 15 THEN 'Least expensive to replace'
            WHEN replacement_cost BETWEEN 15 AND 25 THEN 'Average expensive to replace'
            WHEN replacement_cost > 25 THEN 'Most expensive to replace'
            ELSE 'Not replacable'
        END AS Replacement_status_of_films
    FROM
        film;
SELECT 
    *
     FROM list_of_expense_film_status_view;
 
 
/*
7.	We are interested in having you put payment monitoring systems and maximum payment 
processing restrictions in place in order to minimize the future risk of fraud by your staff. 
Please provide the average payment you process, as well as the maximum payment you have processed.
*/
select * from payment;
SELECT 
    AVG(amount) AS average_payment,
    max(amount),
    min(amount)
FROM
    payment;
    -- cconclusion- Avg. payment made for rental are  amt-4.20 and maximum payment collected till is amt-11.99



/*
8.	We would like to better understand what your customer base looks like. 
Please provide a list of all customer identification values, with a count of rentals 
they have made all-time, with your highest volume customers at the top of the list.
*/
select * from rental;
SELECT 
    customer_id, COUNT(rental_date) AS total_rental_till
FROM
    rental
GROUP BY customer_id
ORDER BY 2 DESC;
-- so the customer with customer_id 148 is at top with total rents 46.


