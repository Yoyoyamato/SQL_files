-- (1) Create a database called movie_sample;
CREATE DATABASE movie_sample;

-- (2) Write the SQL needed to create an actors, directors, movies table from the ERD.
CREATE TABLE actors (
    actor_id serial PRIMARY KEY,
    first_name VARCHAR(150),
    last_name VARCHAR(150)
);

CREATE TABLE directors (
    director_id serial PRIMARY KEY,
    first_name VARCHAR(150),
    last_name VARCHAR(150)
);

ALTER TABLE directors
ADD COLUMN date_of_birth DATE,
ADD COLUMN nationality VARCHAR(120),


CREATE TABLE movies (
    movie_id serial PRIMARY KEY,
    movie_name VARCHAR NOT NULL,
    movie_length INT,
    release_date DATE,
	movie_lang VARCHAR(30),
    age_certificate VARCHAR(30),
    director_id INT REFERENCES directors(director_id)
);

-- if I want to drop a table
-- DROP TABLE movies

ALTER TABLE movies 
ADD COLUMN language VARCHAR(150);

ALTER TABLE movies
-- RENAME COLUMN language TO m_lang;
ADD Constraint movie_length CHECK(movie_length > 0);
	
ALTER TABLE actors
-- ADD COLUMN gender VARCHAR(10)
ADD COLUMN date_of_birth DATE;