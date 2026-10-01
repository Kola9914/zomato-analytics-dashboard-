create database zomato_analytics;
use zomato_analytics;
describe main;

-- total number of restaurants
select count(*) as total_restaurants from main;

-- total no of cities
select count(distinct city) as total_cities
from main;

-- total no of countries
select count(distinct countrycode) as total_countries
from main;

-- overall average cost for two in usd
select concat('$',format(avg(cast( replace(replace(average_cost_for_two, '$', ''),
  ',', '') as decimal(12,2))),2)) as avg_cost_for_two
  from main;
  
  ## OR ##
  
  select round(avg(cast(replace(replace(replace(average_cost_for_two,'₹',''),
  '$',''), ',','')as decimal(10,2))),2) 
  as avg_cost_for_two
from main;
    
-- average rating of all
select round(avg(rating), 2) as average_rating
from main
where rating > 0;

-- number of restaurants by city
SELECT city, COUNT(*) restaurant_count FROM main WHERE city IS NOT NULL GROUP BY 1 ORDER BY 2 DESC;

-- number of restaurants by country
SELECT c.countryname country, COUNT(*) restaurant_count
FROM main m LEFT JOIN country c ON m.countrycode=c.countryid
GROUP BY 1 ORDER BY 2 DESC;

-- restaurants opening by year
SELECT YEAR(opening_date) opening_year, COUNT(*) restaurant_count
FROM main
WHERE opening_date IS NOT NULL
GROUP BY 1
ORDER BY 1;

-- restaurants opening by quarter
SELECT
    YEAR(opening_date) AS opening_year,
    CONCAT('Q', QUARTER(opening_date)) AS quarter,
    COUNT(*) AS restaurant_count
FROM main
WHERE opening_date IS NOT NULL
GROUP BY 1, 2
ORDER BY 1, 2;

-- restaurants opening by month
select   year(opening_date) as opening_year,
         month(opening_date) as month_no,
		monthname(opening_date) as month_name,
        count(*) as restaurant_count
from main where opening_date is not null
group by  year(opening_date),
		month(opening_date),
        monthname(opening_date)
order by opening_year,month_no;

-- number of restaurants based on rating
select round(avg(rating),1),count(restaurantid) from main group by rating;

-- count of restaurant by price bucket 
select  `price bucket`,count(restaurantid) as restaurant_count
from main
group by 1
order by 1;

-- percentage of restaurants with table booking
select has_table_booking, count(*) restaurant_count, round(count(*)*100/(select count(*) from main),2) percentage
from main group by 1;
    
    -- percentage of restaurants with online delivery
select has_online_delivery, count(*) restaurant_count, round(count(*)*100/(select count(*) from main),2) percentage
from main group by 1;

-- cuisine wise restaurant count
select cuisines,count(*) as restaurant_count from main
where cuisines is not null group by 1 order by 2 desc;

-- top 10 cities by restaurant count
select city,
count(*) as restaurant_count from main
where city is not null group by 1
order by 2 desc limit 10;

-- rating distribution
select rating,count(*) as restaurant_count from main
where rating is not null group by 1 order by 1;

-- most popular restaurants
SELECT restaurantname,city,rating,votes,average_cost_for_two,cuisines
FROM main ORDER BY votes DESC
LIMIT 10;





