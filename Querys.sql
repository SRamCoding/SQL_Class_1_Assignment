create database  if not exists module1;

use module1;

create table if not exists city
(
	id int primary key,
    name varchar(30),
    country_code varchar(10),
    district varchar(20),
    population int
);

create table if not exists station
(
	id int primary key,
    city varchar(30),
    state varchar(10),
    lat_n int, 
    long_w int
);

-- Q1: 
/**Query all columns for all American cities in 
the CITY table with populations larger than 100000.
The CountryCode for America is USA**/
select * from city where country_code="USA" and population>100000;

-- Q2: 
/**Query the NAME field for all American cities 
in the CITY table with populations larger than 120000.
The CountryCode for America is USA.**/
select name from city where country_code="USA" and population>120000;

-- Q3: 
/**Query all columns (attributes) for every row 
in the CITY table.**/
select * from city;

-- Q4: 
/**Query all columns for a city in CITY with 
the ID 1661.**/
select * from city where id=1661;

-- Q5: 
/**Query all attributes of every Japanese city 
in the CITY table. The COUNTRYCODE for Japan is
JPN.**/
select * from city where country_code="JPN";

-- Q6: 
/**Query the names of all the Japanese cities 
in the CITY table. The COUNTRYCODE for Japan is
JPN.**/
select name from city where country_code="JPN";

-- Q7: 
/**Query a list of CITY and STATE from the 
STATION table.**/
select city, state from station;

-- Q8: 
/**Query a list of CITY names from STATION for 
cities that have an even ID number. Print the 
results in any order, but exclude duplicates 
from the answer.**/
select distinct city from station where id%2=0;

-- Q9: 
/**Find the difference between the total number
of CITY entries in the table and the number of
distinct CITY entries in the table. (station table)**/
select count(*) - count(distinct city) as Result from station;

-- Q10: 
/**Query the two cities in STATION with the shortest 
and longest CITY names, as well as their respective 
lengths (i.e.: number of characters in the name). 
If there is more than one smallest or largest city, 
choose the one that comes first when ordered alphabetically.**/
(select city, length(city) as longitud from station order by length(city) asc, city asc limit 1)
union all
(select city, length(city) as longitud from station order by length(city) desc, city asc limit 1);
 
-- Q11: 
/**Query the list of CITY names starting with vowels 
(i.e., a, e, i, o, or u) from STATION. Your result
cannot contain duplicates.**/
select distinct city from station where city regexp '^[aeiouAEIOU]';

-- Q12: 
/**Query the list of CITY names ending with vowels 
(a, e, i, o, u) from STATION. Your result cannot
contain duplicates.**/
select distinct city from station where city regexp '[aeiouAEIOU]$';

-- Q13: 
/**Query the list of CITY names from STATION that 
do not start with vowels. Your result cannot
contain duplicates.**/
select distinct city from station where city not regexp '^[aeiouAEIOU]';

-- Q14: 
/**Query the list of CITY names from STATION that 
do not end with vowels. Your result cannot
contain duplicates.**/
select distinct city from station where city not regexp '[aeiouAEIOU]$';

-- Q15: 
/**Query the list of CITY names from STATION that 
either do not start with vowels or do not end
with vowels. Your result cannot contain duplicates.**/
select distinct city 
from station 
where city not regexp '[aeiouAEIOU]$' 
or city not regexp '[aeiouAEIOU]$';

-- Q16: 
/**Query the list of CITY names from STATION that 
do not start with vowels and do not end with
vowels. Your result cannot contain duplicates.**/
select distinct city 
from station 
where city not regexp '[aeiouAEIOU]$' 
and city not regexp '[aeiouAEIOU]$';

-- Q17: 
/**Write an SQL query that reports the products 
that were only sold in the first quarter of 2019. 
That is, between 2019-01-01 and 2019-03-31 inclusive.
Return the result table in any order.**/
select product_id, product_name 
from Q17_Product 
where product_id in (select product_id 
from Q17_Sales 
where sale_date between '2019-01-01' and '2019-03-31');

create table if not exists Q17_Product
(
	product_id int primary key,
	product_name varchar(30),
    unit_price int
);

create table if not exists Q17_Sales
(
	seller_id int,
    product_id int,
    buyer_id int,
    sale_date date,
	quantity int,
    price int,
    foreign key (product_id) references Q17_Product(product_id)
);

insert into Q17_Product (product_id, product_name, unit_price)
values   
(1, 'S8', 1000),
(2, 'G4', '800'),
(3, 'iPhone', 1400);

insert into Q17_Sales (seller_id, product_id, buyer_id, sale_date, quantity, price)
values   
(1, 1, 1, '2019-01-21', 2, 2000),
(1, 2, 2, '2019-02-17', 1, 800),
(2, 2, 3, '2019-06-02', 1, 800),
(3, 3, 4, '2019-05-13', 2, 2800);

-- Q18: 
/**Write an SQL query to find all the authors 
that viewed at least one of their own articles.
Return the result table sorted by id in 
ascending order.**/
select distinct author_id from Q18_views where author_id = viewer_id;

create table if not exists Q18_views
(
	article_id int,
    author_id int,
    viewer_id int,
    view_date date
);

insert into Q18_views (article_id, author_id, viewer_id, view_date)
values
(1, 3, 5, '2019-08-01'),
(1, 3, 6, '2019-08-02'),
(2, 7, 7, '2019-08-01'),
(2, 7, 6, '2019-08-02'),
(4, 7, 1, '2019-07-22'),
(3, 4, 4, '2019-07-21'),
(3, 4, 4, '2019-07-21');

-- Q19: 
/**If the customer's preferred delivery date 
is the same as the order date, then the order 
is called immediately; otherwise, it is called 
scheduled.
Write an SQL query to find the percentage of 
immediate orders in the table, rounded to 2 decimal
places.**/
select round(sum(case when order_date=customer_pref_delivery_date then 1 else 0 end)*100/count(*) , 2) as immediate_percentage 
from Q19_delivery;

create table if not exists Q19_delivery
(
	delivery_id int primary key,
    customer_id int,
    order_date date,
    customer_pref_delivery_date date
);

insert into Q19_delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
values 
(1, 1, '2019-08-01', '2019-08-02'),
(2, 5, '2019-08-02', '2019-08-02'),
(3, 1, '2019-08-11', '2019-08-11'),
(4, 3, '2019-08-24', '2019-08-26'),
(5, 4, '2019-08-21', '2019-08-22'),
(6, 2, '2019-08-11', '2019-08-13');

-- Q20: 
/**Write an SQL query to find the ctr of each Ad. 
Round ctr to two decimal points.
Return the result table ordered by ctr in descending 
order and by ad_id in ascending order in case of a
tie.**/
select ad_id,
case 
	when (count(case when action='Clicked' then 1 /**cualquier numero se puede poner aqui, obedece solo a la condición el conteo si lo considera o no**/ end) + count(case when action='Viewed' then 1 end)) = 0 then 0 
else 
	round((count(case when action='Clicked' then 1 end)*100) / (count(case when action='Clicked' then 1 end) + count(case when action='Viewed' then 1 end)), 2)
end AS ctr
from Q20_ads group by ad_id;

create table if not exists Q20_ads
(
	ad_id int,
    user_id int,
    action enum ('Clicked', 'Viewed', 'Ignored'),
    primary key (ad_id, user_id) 
);

insert into Q20_ads (ad_id, user_id, action)
values 
(1, 1, 'Clicked'),
(2, 2, 'Clicked'),
(3, 3, 'Viewed'),
(5, 5, 'Ignored'),
(1, 7, 'Ignored'),
(2, 7, 'Viewed'),
(3, 5, 'Clicked'),
(1, 4, 'Viewed'),
(2, 11, 'Viewed'),
(1, 2, 'Clicked');

-- Q21: 
/**Write an SQL query to find the team size of 
each of the employees.
Return result table in any order.**/
select t1.employee_id, t2.team_size from Q21_Employee t1 
left join (select team_id, count(*) as team_size from Q21_Employee group by team_id) t2 
on t1.team_id = t2.team_id;

create table if not exists Q21_Employee	
(
	employee_id int primary key,
    team_id int
);

insert into Q21_Employee (employee_id, team_id)
values
(1, 8),
(2, 8),
(3, 8),
(4, 7),
(5, 9),
(6, 9);

-- Q22: 
/**Write an SQL query to find the type of weather 
in each country for November 2019.
The type of weather is:
● Cold if the average weather_state is less than or equal 15,
● Hot if the average weather_state is greater than or equal to 25, and
● Warm otherwise.
Return result table in any order.**/
select t1.country_name, t2.weather_type
from Q22_Countries t1 join 
(select country_id, case when avg(weather_state)<=15 then 'Cold' when avg(weather_state)>=25 then 'Hot' else 'Warm' end AS weather_type
from Q22_Weather
where year(day)=2019 and month(day)=11 
group by country_id) t2
on t1.country_id = t2.country_id;

create table if not exists Q22_Countries	
(
	country_id int primary key,
    country_name varchar(15)
);

create table if not exists Q22_Weather	
(
	country_id int,
    weather_state int,
    day date,
    primary key (country_id, day)
);

insert into Q22_Countries (country_id, country_name)
values 
(2, 'USA'),
(3, 'Australia'),
(7, 'Peru'),
(5, 'China'),
(8, 'Morocco'),
(9, 'Spain');

insert into Q22_Weather (country_id, weather_state, day)
values 
(2, 15, '2019-11-01'),
(2, 12, '2019-10-28'),
(2, 12, '2019-10-27'),
(3, -2, '2019-11-10'),
(3, 0, '2019-11-11'),
(3, 3, '2019-11-12'),
(5, 16, '2019-11-07'),
(5, 18, '2019-11-09'),
(5, 21, '2019-11-23'),
(7, 25, '2019-11-28'),
(7, 22, '2019-12-01'),
(7, 20, '2019-12-02'),
(8, 25, '2019-11-05'),
(8, 27, '2019-11-15'),
(8, 31, '2019-11-25'),
(9, 7, '2019-10-23'),
(9, 3, '2019-12-23');

-- Q23: 
/**Write an SQL query to find the 
average selling price for each product. 
average_price should be
rounded to 2 decimal places.
Return the result table in any order..**/
select * from Q23_Prices;
select * from Q23_UnitsSold;

select * from Q23_UnitsSold t1 join Q23_Prices t2 on t1.product_id = t2.product_id;

create table if not exists Q23_Prices
(
	product_id int,
    start_date date,
    end_date date,
    price int,
    primary key (product_id, start_date, end_date)
);

create table if not exists Q23_UnitsSold
(
	product_id int,
    purchase_date date,
    units int
);

insert into Q23_Prices (product_id, start_date, end_date, price) 
values
(1, '2019-02-17', '2019-02-28', 5),
(1, '2019-03-01', '2019-03-22', 20),
(2, '2019-02-01', '2019-02-20', 15),
(2, '2019-02-21', '2019-03-31', 30);

insert into Q23_UnitsSold (product_id, purchase_date, units) 
values
(1, '2019-02-25', 100),
(1, '2019-03-01', 15),
(2, '2019-02-10', 200),
(2, '2019-03-22', 30);































































