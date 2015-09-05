## Week 2 Assignment By Nabila Hossain

## Please use the tables in the flights database. Your deliverable should include the SQL queries that you write in support of your conclusions. 
## You may use multiple queries to answer questions.

## 1. How many airplanes have listed speeds? What is the minimum listed speed and the maximum listed speed?

SELECT count(tailnum) as 'number of planes with listed speed' FROM planes where speed <> 'NULL';
-- There are 23 airplanes with listed speed.


SELECT speed FROM planes where speed <> 'NULL' order by speed asc limit 1;
-- The minimum listed speed is 90.


SELECT speed FROM planes where speed <> 'NULL' order by speed desc limit 1;
-- The maximum listed speed is 432.



## 2. What is the total distance flown by all of the planes in January 2013? What is the total distance flown by all of the planes in January 2013 
## where the tailnum is missing?

SELECT sum(distance) as 'Total Distance Traveled' FROM flights where year = 2013 and month = 1;

-- The Total distance flown by all of the planes in January 2013 is 27,188,805.


SELECT sum(distance) as 'Total Distance Traveled' FROM flights 
WHERE year = 2013 and month = 1 and tailnum is NULL;
-- The Total distance flown by all of the planes where the tailnum is missing in January 2013 is 81,763.



## 3. What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? Write this statement first using an 
## INNER JOIN, then using a LEFT OUTER JOIN. How do your results compare?

-- Answer for the inner join:
SELECT 
  p.manufacturer as 'Manufacturer', 
  sum(f.distance) as 'Total Distance Traveled' 
FROM flights f INNER JOIN planes p
ON 
  f.tailnum = p.tailnum
where f.year = 2013 and f.month = 7 and f.day = 5 group by p.manufacturer order by p.manufacturer asc;


-- Answer for the left join:
SELECT 
  p.manufacturer as 'Manufacturer', 
  sum(f.distance) as 'Total Distance Traveled' 
FROM flights f LEFT JOIN planes p
ON 
  f.tailnum = p.tailnum
where f.year = '2013' and f.month = 7 and f.day = 5 group by p.manufacturer order by p.manufacturer asc;


-- The difference between inner join and left join between flights and planes tables is that one includes null numbers while the other does not. 
-- The left join, shows all the flights that is on flights table that flew on July 5th 2013, including the ones that does not have a tail number.
-- Since left joins will show all entries on the first table. While the inner join only lists the flights that have tail number and is listed on 
-- both table (since the tables are linked through the tail numbers).


## 4. Write and answer at least one question of your own choosing that joins information from at least three of the tables in the flights database.

-- Question: Which airline company's and manufacturer's plane flew the most on May 2013? Limit top 10 distance.

	-- Answer:
 SELECT 
  a.name as 'Airline',
  p.manufacturer as 'Manufacturer', 
  sum(f.distance) as 'Total Distance Traveled' 
FROM flights f 
LEFT JOIN planes p ON f.tailnum = p.tailnum
LEFT JOIN airlines a ON f.carrier = a.carrier
where f.year = '2013' and f.month = 5 group by p.manufacturer, a.name order by sum(f.distance) desc limit 10;
