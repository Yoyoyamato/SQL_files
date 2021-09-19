--  13) In the actors table, return the youngest actor (using the date_of_birth field) and that actor's
-- first_name, last_name, date_of_birth dob, the age of the actor as "age". Sort by last_name descending.
-- ** AGE calculates the difference in years, months, days between field and current date

select
    first_name, last_name, date_of_birth dob,
    age(date_of_birth)  age
FROM
    actors
ORDER BY 
    4, 2 desc
limit 1


-- 14) For each actor's age by their age in years (e.g. 20, 21, 23 years old...),
-- return the first actor in each year grouping sorted by the year, 
-- the age and the last_name ascending. Return the actors age as years, first_name,
-- last_name, and age() given the actor's date_of_birth as age. Filter out for any age
-- that is equal to 22, 26, 28, and 32. To extract year from the actor's age,
-- use the age() function on the actor's date_of_birth.
-- Then, use the DATE_PART(field,source) operator where the field
-- is "year" and the source is the the result of the age() function.

-- DATE_PART(field,source)
-- i.e. what field to extract
 
SELECT
    distinct on ( DATE_PART('year', age(date_of_birth)))
    DATE_PART('year', age(date_of_birth)) year,
    first_name, last_name, age(date_of_birth) age
FROM
    actors
WHERE
    DATE_PART('year', age(date_of_birth)) not in (22, 26, 28, 32)
ORDER BY
    years, age, last_name

-- 15) From the movies_revenues table, return the rows where the floor of the revenues_domestic 
-- is equal to the ceiling of the revenues_international

SELECT
	*
FROM
	movies_revenues
WHERE
	floor(revenues_domestic) = ceiling(revenues_international)


-- 16) From the movies table, return the following fields:
-- 1. round the result of calculating the movie_length in hours as "hours" to 0 decimal places. Use the 
-- 		round(value/field, # of decimal places) operator. Call the field "~ # of hours"
-- 2. movie_name as name 
-- 3. concatenate the movie_length in hours with ' hours and ' 
-- 	  and leftover minutes of the movie_length followed by the phrase
-- 	  ' minutes' . Call this field movie_time
-- 4. movie_length as minutes
-- 5. return how old the movie is in terms of years, months, and days given the release_date
-- call this field "years old"
-- 6. Sort by "~ # of hours" descending and movie_name ascending

SELECT
	round(movie_length/60) as "~ # of hours",
	movie_name as "name",
	round(movie_length/60) || ' hours and ' || movie_length%60 || ' minutes' as movie_time,
	movie_length as minutes,
	age(release_date) as "years old"
FROM
	movies 
ORDER BY
	round(movie_length/60) desc,
	movie_name asc




-- 17) From the movies table, select the first row of each grouping of movies based on the first letter that the 
-- movie_name begins with using the SUBSTRING(field/value,string position, # of characters to extract) 
-- operator and call the field alphabetical. Return the movie_name, movie_length and 
-- release_date fields. Filter out any movies where the alphabetical field does 
-- not have a value in 'E' or 'F'. Order by alphabetical ascending,
-- release_date descending and movie_length descending. Limit to 13 results.





-- 18) Return movies from movies table where movie_length is either 139 or 150 and the movie_name contains the
-- word "Star" in it. Sort by movie_length desc.
	
SELECT
	*
FROM
	movies
WHERE
	movie_length in (139, 150) and
	movie_name like '%Star%'
ORDER BY
	movie_length desc

-- NORTHWIND DATASET ---



-- 19) From the suppliers table, return the
-- contact_name, contact_title, company_name, length of company_name as cname_length, country 
-- fields in the results where the following are true:
-- contact_title does not contain the word 'Manager' anywhere in it OR 
-- the country is in either 'Canada' or 'Denmark' AND the length of the company_name
-- is between 9 and 18
-- Sort by length of the company_name, contact_name, and country. Limit to 2 results.

-- LENGTH(field)
 
SELECT
	contact_name, 
	contact_title, 
	company_name, 
	LENGTH(company_name) as cname_length, 
	country
FROM
	suppliers
WHERE
	(contact_title not like '%Manager%' or
	country in ('Canada', 'Denmark')) and
	LENGTH(company_name) between 9 and 18
ORDER BY
	LENGTH(company_name), 
	contact_name,
	country
LIMIT 2



-- 20) From suppliers table, return the company_name and 
-- length of the company_name as complength where the
-- company name is exactly 9 letters long. Sort by complength 
-- and company_name ascending. What are the different ways of
-- writing this?

SELECT
	company_name,
	LENGTH(company_name) as complength
FROM
	suppliers
WHERE
	LENGTH(company_name) = 9
ORDER BY
	LENGTH(company_name),
	company_name asc