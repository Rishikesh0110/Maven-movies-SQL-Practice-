/* 
1. My partner and I want to come by each of the stores in person and meet the managers. 
Please send over the managers’ names at each store, with the full address 
of each property (street address, district, city, and country please).  
*/ 
/*-names- Staff table
   street address- Address table
   districs,- Address table
   city,- City table
   country,- Country table
   */
   -- we can use inner join or left join to solve this question,
SELECT 
    S.first_name,
    S.last_name,
    A.address,
    A.district,
    C.city,
    CO.country
FROM
    staff AS S
        INNER JOIN
    store AS ST ON S.store_id = ST.store_id
        INNER JOIN
    address AS A ON ST.address_id = A.address_id
        INNER JOIN
    city AS C ON A.city_id = C.city_id
        INNER JOIN
    country AS CO ON C.country_id = CO.country_id;

-- Conclusion - so above query ill help tortreve all the mangers anme with addresses

	
/*
2.	I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, 
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost. 
*/

/* list of inventory item,
store -id number-inventory table
inventory id-inventory table
name of film-film table
film rating-film table
rental rate-fim table
replacement cost- film table
*/
select *from inventory;
select * from film;

SELECT 
    store_id,
    inventory_id,
    title,
    rating,
    rental_rate,
    replacement_cost
FROM
    inventory AS I
        LEFT JOIN
    film AS F ON I.film_id = F.film_id;
-- Conclusion -we will have the all details asked in question by this query




/* 
3.	From the same list of films you just pulled, please roll that data up and provide a summary level overview 
of your inventory. We would like to know how many inventory items you have with each rating at each store. 
*/
SELECT 
rating,
    count(inventory_id) as total_items_raatingwise
FROM
    inventory AS I
        LEFT JOIN
    film AS F ON I.film_id = F.film_id
    group by 1;
-- Conclusion: We have total numbers as PG= 924, G =91, NC-17 =944, PG-13=1018, R= 904



/* 
4. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement cost, 
sliced by store and film category. 
*/ 
select * from film;
SELECT 
store_id,
special_features,
    count(title) as total_no_of_films,
    avg(replacement_cost) as average_replacement_cost,
    sum(replacement_cost) as total_replacement_cost
FROM
    inventory AS I
        LEFT JOIN
    film AS F ON I.film_id = F.film_id
    group by 1,2;
-- conclusion from above query we will get total number of films,avg & total RC storewise and fetures wise


/*
5.	We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, 
and their full addresses – street address, city, and country. 
*/
/* customer_name- Customer table
   store - customer_table
   active_status - customer_table
   street_add--  address_table
   city-- city_table
   country - country_table
   */
   select * from customer;
SELECT 
    store_id,first_name, last_name, active,address,city,country
FROM
    customer AS C
        LEFT JOIN
    address AS A ON C.address_id = A.address_id
        LEFT JOIN
    city AS CT ON A.city_id = CT.city_id
        LEFT JOIN
    country AS CO ON CT.country_id = CO.country_id;
  -- Conclusion _ from above query we will have all customer details with store wisie.


/*
6.	We would like to understand how much your customers are spending with you, and also to know 
who your most valuable customers are. Please pull together a list of customer names, their total 
lifetime rentals, and the sum of all payments you have collected from them. It would be great to 
see this ordered on total lifetime value, with the most valuable customers at the top of the list. 
*/

/*customer_name-- customer table,
total-rental-- payment table, 
total payemnts-- payment table,
*/
SELECT 
    first_name,
    last_name,
    count(rental_id) as total_rent,
    sum(amount) as total_amount_paid
FROM
    customer AS C
        LEFT JOIN
    payment AS P ON C.customer_id = P.customer_id
    group by 1,2 
    order by 3 desc;

-- conclusion - from above query you will have top customers

    
/*
7. My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table? 
Could you please note whether they are an investor or an advisor, and for the investors, 
it would be good to include which company they work with. 
*/

/* advisors name,-advissor table
investors name,-investor table
staus advisor or investor,-
company_name for investors,-investor table 
*/
-- but  i am not find any relatioship b/w advisors and invvestors or not possible by bridging or join we need to do uniun.
    select * from advisor;
  SELECT 
    'advisor' AS type,
    advisor.first_name,
    advisor.last_name,
    'No need because advisor ' AS company_name_if_investor
FROM
    advisor 
UNION ALL SELECT 
    'investor' AS type,
    investor.first_name,
    investor.last_name,
    company_name
FROM
    investor;
    
-- Conclusion - we will have all the list of advisors and investors with names and investors with company names also

/*
8. We're interested in how well you have covered the most-awarded actors. 
Of all the actors with three types of awards, for what % of them do we carry a film?
And how about for actors with two types of awards? Same questions. 
Finally, how about actors with just one award? 
*/
/* most awarded actors 3 awards
actors with 2 awards
actors with only one award
*/

select * from actor_award;
-- so we have three types of awards emmy, oscrs, & tony we can aiign the case to each actors by creating a new columns with award status;
*
no. of actors with all 3 awards -- 7 
we have 4 of them  -- 4
% 4/7

no.of_awards_count    no. of total actors with award      no.of total actors with award we have   %_covered
3							7		                              4                                 (7/4)* 100 
2                           66                                    61
1                           84									  70								
*/

/*
case 
			when awards= "Emmy, Oscar, Tony "  then "three_awards" 
            when awards in ('Emmy, Oscar' , 'Emmy, Tony' , 'Oscar, Tony') then "two_awards"
            when awards in  ( 'Emmy', 'Oscar','Tony') then "one_award"
			else "other"
	end as  "no._of_awards",
*/

Select
	count( case 
				when awards= "Emmy, Oscar, Tony " and actor_id is not null then 1 
				else null
			end ) /
	count( case 
				when awards= "Emmy, Oscar, Tony " then 1 
				else null
			end ) * 100  as "%_covered_for_3_award_actors",
            
	count( case
				when awards in ('Emmy, Oscar' , 'Emmy, Tony' , 'Oscar, Tony') and actor_id is not null then 1
				else null
			end) /
	count( case
				when awards in ('Emmy, Oscar' , 'Emmy, Tony' , 'Oscar, Tony') then 1
				else null
			end) * 100 as "%_covered_for_2_award_actors",

	count( case
				when awards in  ( 'Emmy', 'Oscar','Tony')  and actor_id is not null then 1
                else null
			end) /
	count( case
				when awards in  ( 'Emmy', 'Oscar','Tony') then 1
                else null
			end) * 100 as "%_covered_for_1_award_actors"
from actor_award
	group by "no._of_awards";
-- Conclusion: 57.1429% covered with 3 awards actors, 92.4242% covered with 2 awards actors &	83.3333% covered with actor award with 1.
