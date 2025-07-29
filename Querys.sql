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
select t.product_id, round(sum(t.price_total)/sum(t.units), 2) as average_price 
from 
(select t1.product_id, t1.units, t1.units*t2.price as price_total 
from Q23_UnitsSold t1 
join Q23_Prices t2 on t1.product_id = t2.product_id 
and t1.purchase_date between t2.start_date and t2.end_date) t
group by product_id;

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

-- Q24: 
/**Write an SQL query to report the 
first login date for each player.
Return the result table in any order.**/
select player_id, min(event_date) as first_login 
from Q24_Activity 
group by player_id;

create table if not exists Q24_Activity
(
	player_id int,
    device_id int,
    event_date date,
    games_played int,
    primary key (player_id, event_date)
);

insert into Q24_Activity (player_id, device_id, event_date, games_played) 
values
(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);

-- Q25: 
/**Write an SQL query to report the 
device that is first logged in for each player.
Return the result table in any order**/
select t1.player_id, t1.device_id
from Q24_Activity t1
join
(select player_id, min(event_date) as first_login 
from Q24_Activity 
group by player_id) t2
on t1.player_id = t2.player_id
and t1.event_date = t2.first_login;

-- Q26: 
/**Write an SQL query to get the names 
of products that have at least 100 units 
ordered in February 2020 and their amount.
Return result table in any order.**/
select t1.product_name, t2.unit
from Q26_Products t1
join
(select product_id, sum(unit) as unit
from Q26_Orders 
where year(order_date) = 2020 and month(order_date) = 2 
group by product_id having unit>=100) t2
on t1.product_id = t2.product_id;

create table if not exists Q26_Products
(
	product_id int primary key,
    product_name varchar(30),
    product_category varchar(10)
);

create table if not exists Q26_Orders
(
	product_id int,
    order_date date,
    unit int,
    foreign key(product_id) references Q26_Products(product_id)
);

insert into Q26_Products (product_id, product_name, product_category) 
values
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'),
(4, 'Lenovo', 'Laptop'),
(5, 'Leetcode Kit', 'T-shirt');

insert into Q26_Orders (product_id, order_date, unit) 
values
(1, '2020-02-05', 60),
(1, '2020-02-10', 70),
(2, '2020-01-18', 30),
(2, '2020-02-11', 80),
(3, '2020-02-17', 2),
(3, '2020-02-24', 3),
(4, '2020-03-01', 20),
(4, '2020-03-04', 30),
(4, '2020-03-04', 60),
(5, '2020-02-25', 50),
(5, '2020-02-27', 50),
(5, '2020-03-01', 50);

-- Q27: 
/**Write an SQL query to find the users 
who have valid emails. A valid e-mail has 
a prefix name and a domain where:
● The prefix name is a string that may 
contain letters (upper or lower case), digits, 
underscore '_', period '.', and/or dash '-'. 
The prefix name must start with a letter.
● The domain is '@leetcode.com'.
Return the result table in any order.**/
select *
from Q27_Users
where mail regexp '^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\\.com$';


create table if not exists Q27_Users
(
	user_id int primary key,
    name varchar(20),
    mail varchar(30)
);

insert into Q27_Users (user_id, name, mail) 
values
(1, 'Winston', 'winston@leetcode.com'),
(2, 'Jonathan', 'jonathanisgreat'),
(3, 'Annabelle', 'bella-@leetcode.com'),
(4, 'Sally', 'sally.come@leetcode.com'),
(5, 'Marwan', 'quarz#2020@leetcode.com'),
(6, 'David', 'david69@gmail.com'),
(7, 'Shapiro', '.shapo@leetcode.com');

-- Q28: 
/**Write an SQL query to report the 
customer_id and customer_name of 
customers who have spent at least 
$100 in each month of June and July 2020.
Return the result table in any order.**/
select t3.customer_id, t3.name
from Q28_Customers t3
join
(select t2.customer_id, month(t2.order_date) as mes, sum(t1.price * t2.quantity) as total_price
from Q28_Product t1
join 
(select *
from Q28_Orders 
where order_date between '2020-06-01' and '2020-07-31') t2
on t1.product_id = t2.product_id
group by t2.customer_id, month(t2.order_date)
having total_price>=100) t4
on t3.customer_id = t4.customer_id
group by t3.customer_id, t3.name
having count(distinct t4.mes)=2;

create table if not exists Q28_Customers
(
	customer_id int primary key,
    name varchar(15),
    country varchar(15)
);

create table if not exists Q28_Product
(
	product_id int primary key,
    description varchar(20),
    price int
);

create table if not exists Q28_Orders
(
	order_id int primary key,
    customer_id int,
    product_id int,
    order_date date,
    quantity int
);

insert into Q28_Customers (customer_id, name, country)
values
(1, 'Winston', 'USA'),
(2, 'Jonathan', 'Peru'),
(3, 'Moustafa', 'Egypt');

insert into Q28_Product (product_id, description, price)
values
(10, 'LC Phone', 300),
(20, 'LC T-Shirt', 10),
(30, 'LC Book', 45),
(40, 'LC Keychain', 2);

insert into Q28_Orders (order_id, customer_id, product_id, order_date, quantity)
values
(1, 1, 10, '2020-06-10', 1),
(2, 1, 20, '2020-07-01', 1),
(3, 1, 30, '2020-07-08', 2),
(4, 2, 10, '2020-06-15', 2),
(5, 2, 40, '2020-07-01', 10),
(6, 3, 20, '2020-06-24', 2),
(7, 3, 30, '2020-06-25', 2),
(9, 3, 30, '2020-05-08', 3);

-- Q29: 
/**Write an SQL query to report the 
distinct titles of the kid-friendly 
movies streamed in June 2020.
Return the result table in any order.**/
select t2.title
from
(select content_id 
from Q29_TVProgram 
where month(program_date) = 6 and year(program_date) = 2020) t1
join
(select content_id, title 
from Q29_Content 
where Kids_content = 'Y') t2
on t1.content_id = t2.content_id;

create table if not exists Q29_TVProgram
(
	program_date datetime,
    content_id int,
    channel varchar(20),
    primary key (program_date, content_id)
);

create table if not exists Q29_Content
(
	content_id int primary key,
    title varchar(20),
    Kids_content enum('Y', 'N'),
    content_type varchar(10)
);

insert into Q29_TVProgram (program_date, content_id, channel)
values
('2020-06-10 08:00', 1, 'LC-Channel'),
('2020-05-11 12:00', 2, 'LC-Channel'),
('2020-05-12 12:00', 3, 'LC-Channel'),
('2020-05-13 14:00', 4, 'Disney Ch'),
('2020-06-18 14:00', 4, 'Disney Ch'),
('2020-07-15 16:00', 5, 'Disney Ch');

insert into Q29_Content (content_id, title, Kids_content, content_type)
values
(1, 'Leetcode Movie', 'N', 'Movies'),
(2, 'Alg. for Kids', 'Y', 'Series'),
(3, 'Database Sols', 'N', 'Series'),
(4, 'Aladdin', 'Y', 'Movies'),
(5, 'Cinderella', 'Y', 'Movies');

-- Q30: 
/**Write an SQL query to find the 
npv of each query of the Queries table.
Return the result table in any order**/
select  t1.id, t1.year, coalesce(t2.npv, 0) as npv
from Q30_Queries t1
left join Q30_NPV t2
on t1.id = t2.id and t1.year = t2.year;

create table if not exists Q30_NPV
(
	id int,
    year int,
    npv int,
    primary key (id, year)
);

create table if not exists Q30_Queries
(
	id int,
    year int,
    primary key (id, year)
);

insert into Q30_NPV (id, year, npv)
values
(1, 2018, 100),
(7, 2020, 30),
(13, 2019, 40),
(1, 2019, 113),
(2, 2008, 121),
(3, 2009, 12),
(11, 2020, 99),
(7, 2019, 0);

insert into Q30_Queries (id, year)
values
(1, 2019),
(2, 2008),
(3, 2009),
(7, 2018),
(7, 2019),
(7, 2020),
(13, 2019);

-- Q31: 
/**Write an SQL query to find the 
npv of each query of the Queries table.
Return the result table in any order.**/
select  t1.id, t1.year, coalesce(t2.npv, 0) as npv
from Q30_Queries t1
left join Q30_NPV t2
on t1.id = t2.id and t1.year = t2.year;

-- Q32: 
/**Write an SQL query to show the 
unique ID of each user, If a user 
does not have a unique ID replace just
show null.
Return the result table in any order.**/
select coalesce(t2.unique_id, null) as unique_id, t1.name
from Q32_Employees t1 
left join Q32_EmployeeUNI t2
on t1.id = t2.id;

create table if not exists Q32_Employees
(
	id int primary key,
    name varchar(15)
);

create table if not exists Q32_EmployeeUNI
(
	id int,
    unique_id int,
    primary key (id, unique_id)
);

insert into Q32_Employees (id, name) 
values
(1, 'Alice'),
(7, 'Bob'),
(11, 'Meir'),
(90, 'Winston'),
(3, 'Jonathan');

insert into Q32_EmployeeUNI (id, unique_id) 
values
(3, 1),
(11, 2),
(90, 3);

-- Q33: 
/**Write an SQL query to report the 
distance travelled by each user.
Return the result table ordered by 
travelled_distance in descending order, 
if two or more users travelled the 
same distance, order them by their 
name in ascending order.**/
select t1.name, coalesce(t2.travelled_distance, 0) as travelled_distance
from Q33_Users t1
left join
(select user_id, sum(distance) as travelled_distance 
from Q33_Rides 
group by user_id) t2
on t1.id = t2.user_id
order by t2.travelled_distance desc, t1.name asc;

create table if not exists Q33_Users
(
	id int primary key,
    name varchar(15)
);

create table if not exists Q33_Rides
(
	id int primary key,
    user_id int,
    distance int
);

insert into Q33_Users (id, name) 
values
(1, 'Alice'),
(2, 'Bob'),
(3, 'Alex'),
(4, 'Donald'),
(7, 'Lee'),
(13, 'Jonathan'),
(19, 'Elvis');

insert into Q33_Rides (id, user_id, distance) 
values
(1, 1, 120),
(2, 2, 317),
(3, 3, 222),
(4, 7, 100),
(5, 13, 312),
(6, 19, 50),
(7, 7, 120),
(8, 19, 400),
(9, 7, 230);

-- Q34: 
/**Write an SQL query to get the 
names of products that have at 
least 100 units ordered in February 
2020 and their amount.
Return result table in any order.**/
select product_id, sum(unit) as total_units 
from Q26_Orders 
where year(order_date)=2020 and month(order_date)=2
group by product_id
having total_units >= 100;

-- Q35: 
/**Write an SQL query to:
● Find the name of the user who has 
rated the greatest number of movies. 
In case of a tie,
return the lexicographically smaller 
user name.
● Find the movie name with the highest 
average rating in February 2020. In 
case of a tie, return the 
lexicographically smaller movie name.**/
(SELECT t1.name as results
FROM Q35_Users t1
JOIN
(select user_id, count(distinct movie_id) as total_movies
from Q35_MovieRating 
group by user_id) t2
ON t1.user_id = t2.user_id
WHERE t2.total_movies IN 
(select max(t3.total_movies) 
from 
(select count(distinct movie_id) as total_movies
from Q35_MovieRating 
group by user_id) t3)
ORDER BY results ASC
LIMIT 1)

union all

(SELECT t1.title as results
FROM Q35_Movies t1
JOIN 
(select movie_id, avg(rating) as average_rating
from Q35_MovieRating
where year(created_at) = 2020 and month(created_at) = 2 
group by movie_id) t2
ON t1.movie_id = t2.movie_id
WHERE t2.average_rating IN 
(select max(t2.average_rating) 
from 
(select avg(rating) as average_rating
from Q35_MovieRating
group by movie_id) t2)
ORDER BY t1.title ASC
LIMIT 1);

create table if not exists Q35_Movies
(
	movie_id int primary key,
    title varchar(15)
);

create table if not exists Q35_Users
(
	user_id int primary key,
    name varchar(15)
);

create table if not exists Q35_MovieRating
(
	movie_id int,
    user_id int,
    rating int,
    created_at date,
    primary key (movie_id, user_id)
);

insert into Q35_Movies (movie_id, title) 
values
(1, 'Avengers'),
(2, 'Frozen 2'),
(3, 'Joker');

insert into Q35_Users (user_id, name) 
values
(1, 'Daniel'),
(2, 'Monica'),
(3, 'Maria'),
(4, 'James');

insert into Q35_MovieRating (movie_id, user_id, rating, created_at) 
values
(1, 1, 3, '2020-01-12'),
(1, 2, 4, '2020-02-11'),
(1, 3, 2, '2020-02-12'),
(1, 4, 1, '2020-01-01'),
(2, 1, 5, '2020-02-17'),
(2, 2, 2, '2020-02-01'),
(2, 3, 2, '2020-03-01'),
(3, 1, 3, '2020-02-22'),
(3, 2, 4, '2020-02-25');

-- Q36: 
/**Write an SQL query to report 
the distance travelled by each user.
Return the result table ordered 
by travelled_distance in descending 
order, if two or more users
travelled the same distance, order 
them by their name in ascending order.**/
select t1.name, coalesce(t2.travelled_distance, 0) as travelled_distance
from Q33_Users t1 
left join
(select user_id, sum(distance) as travelled_distance 
from Q33_Rides
group by user_id) t2
on t1.id = t2.user_id
order by travelled_distance desc, t1.name asc;

-- Q37: 
/**Write an SQL query to show the 
unique ID of each user, If a user 
does not have a unique ID replace 
just show null.
Return the result table in any order.**/
select t2.unique_id, t1.name
from Q32_Employees t1
left join Q32_EmployeeUNI t2
on t1.id = t2.id;

-- Q38: 
/**Write an SQL query to find 
the id and the name of all 
students who are enrolled in 
departments that no
longer exist.
Return the result table in any 
order.**/
select id, name 
from Q38_Students 
where department_id not in 
(select id from Q38_Departments); 

create table if not exists Q38_Departments
(
	id int primary key,
    name varchar(30)
);

create table if not exists Q38_Students
(
	id int primary key,
    name varchar(15),
    department_id int 
);

insert into Q38_Departments (id, name) 
values
(1, 'Electrical Engineering'),
(7, 'Computer Engineering'),
(13, 'Business Administration');

insert into Q38_Students (id, name, department_id) 
values
(23, 'Alice', 1),
(1, 'Bob', 7),
(5, 'Jennifer', 13),
(2, 'John', 14),
(4, 'Jasmine', 77),
(3, 'Steve', 74),
(6, 'Luis', 1),
(8, 'Jonathan', 7),
(7, 'Daiana', 33),
(11, 'Madelynn', 1);

-- Q39: 
/**Write an SQL query to report 
the number of calls and the total 
call duration between each pair 
of distinct persons (person1, person2) 
where person1 < person2.
Return the result table in any order**/
select 
least(from_id, to_id) as person1, 
greatest(from_id, to_id) as person2,
count(*) as call_count,
sum(duration) as total_duration
from Q39_Calls
group by 
least(from_id, to_id),
greatest(from_id, to_id)
having person1<> person2; 

create table if not exists Q39_Calls
(
	from_id int,
    to_id int,
    duration int 
);

insert into Q39_Calls (from_id, to_id, duration) 
values
(1, 2, 59),
(2, 1, 11),
(1, 3, 20),
(3, 4, 100),
(3, 4, 200),
(3, 4, 200),
(4, 3, 499);

-- Q40: 
/**Write an SQL query to find the 
average selling price for each 
product. average_price should be
rounded to 2 decimal places.
Return the result table in any order.**/
select t2.product_id, sum(t1.units*t2.price) * 1 / sum(t1.units) as average_price 
from Q23_UnitsSold t1
join Q23_Prices t2
on t1.product_id = t2.product_id
and t1.purchase_date between t2.start_date and end_date
group by t2.product_id;

-- Q41: 
/**Write an SQL query to report the 
number of cubic feet of volume the 
inventory occupies in each warehouse.
Return the result table in any order.**/
select t1.name as warehouse_name, sum(t1.units* t2.Width * t2.Length * t2.Height) as volume
from Q41_Warehouse t1
join Q41_Products t2
on t1.product_id = t2.product_id
group by t1.name;

create table if not exists Q41_Warehouse
(
	name varchar(15),
    product_id int,
    units int,
    primary key(name, product_id)
);

create table if not exists Q41_Products
(
    product_id int primary key,
    product_name varchar(15),
    Width int,
    Length int,
    Height int
);

insert into Q41_Warehouse (name, product_id, units) 
values
('LCHouse1', 1, 1),
('LCHouse1', 2, 10),
('LCHouse1', 3, 5),
('LCHouse2', 1, 2),
('LCHouse2', 2, 2),
('LCHouse3', 4, 1);

insert into Q41_Products (product_id, product_name, Width, Length, Height) 
values
(1, 'LC-TV', 5, 50, 40),
(2, 'LC-KeyChain', 5, 5, 5),
(3, 'LC-Phone', 2, 10, 10),
(4, 'LC-T-Shirt', 4, 10, 20);

-- Q42: 
/**Write an SQL query to report the 
difference between the number of 
apples and oranges sold each day.
Return the result table ordered by 
sale_date.**/
select sale_date, 
sum(case when fruit = "apples" then sold_num end) 
					    - 
sum(case when fruit = "oranges" then sold_num end) as diff
from Q42_Sales
group by sale_date;

create table if not exists Q42_Sales
(
    sale_date date,
    fruit enum("apples", "oranges"),
    sold_num int,
    primary key(sale_date, fruit)
);

insert into Q42_Sales (sale_date, fruit, sold_num) 
values
('2020-05-01', 'apples', 10),
('2020-05-01', 'oranges', 8),
('2020-05-02', 'apples', 15),
('2020-05-02', 'oranges', 15),
('2020-05-03', 'apples', 20),
('2020-05-03', 'oranges', 0),
('2020-05-04', 'apples', 15),
('2020-05-04', 'oranges', 16);

-- Q43: 
/**Write an SQL query to report the fraction 
of players that logged in again on the day 
after the day they first logged in, rounded 
to 2 decimal places. In other words, you 
need to count the number of players that 
logged in for at least two consecutive days 
starting from their first login date, then 
divide that number by the total number of 
players.**/
SELECT round(a.a / b.b, 2) AS fraction
FROM

(select count(*) as a
from Q24_Activity t1
join
(select player_id, min(event_date) as first_login
from Q24_Activity
group by player_id) t2
on t1.player_id = t2.player_id
where datediff(t1.event_date, t2.first_login) = 1) a,
  
(select count(distinct player_id) as b
from Q24_Activity) b;

-- Q44: 
/**Write an SQL query to report the 
managers with at least five direct reports.
Return the result table in any order..**/
select name
from Q44_Employee t1
join
(select managerId, count(*) as total_reports
from Q44_Employee
group by managerId
having total_reports >= 5) t2
on t1.id = t2.managerId;

create table if not exists Q44_Employee
(
    id int primary key,
    name varchar(15),
    department varchar(1),
    managerId int
);

insert into Q44_Employee (id, name, department, managerId) 
values
(101, 'John', 'A', NULL),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101);

-- Q45: 
/**Write an SQL query to report the 
respective department name and number 
of students majoring in each department 
for all departments in the Department 
table (even ones with no current students).
Return the result table ordered by 
student_number in descending order. 
In case of a tie, order them by
dept_name alphabetically.**/
select * from Q45_Department;
select t2.dept_name, coalesce(count(distinct t1.student_id), 0) as student_number
from Q45_Student t1 
right join Q45_Department t2
on t1.dept_id = t2.dept_id
group by t2.dept_name
order by student_number desc, dept_name asc;

create table if not exists Q45_Department
(
    dept_id int primary key,
    dept_name varchar(15)
);

create table if not exists Q45_Student
(
    student_id int primary key,
    student_name varchar(10),
    gender varchar(1),
    dept_id int,
    foreign key(dept_id) references Q45_Department(dept_id)
);

insert into Q45_Department (dept_id, dept_name) 
values
(1, 'Engineering'),
(2, 'Science'),
(3, 'Law');

insert into Q45_Student (student_id, student_name, gender, dept_id) 
values
(1, 'Jack', 'M', 1),
(2, 'Jane', 'F', 1),
(3, 'Mark', 'M', 2);

-- Q46: 
/**Write an SQL query to report the 
customer ids from the Customer table 
that bought all the products in the 
Product table.
Return the result table in any order.**/
SELECT t3.customer_id
FROM
(select t1.customer_id, count(distinct t1.product_key) as total_keys
from Q46_Customer t1
join Q46_Product t2
on t1.product_key = t2.product_key
group by t1.customer_id
having total_keys = (select count(distinct product_key) from Q46_Product)) t3;

create table if not exists Q46_Product
(
    product_key int primary key
);

create table if not exists Q46_Customer
(
    customer_id int,
    product_key int,
    foreign key(product_key) references Q46_Product(product_key)
);

insert into Q46_Product (product_key) 
values
(5),
(6);

insert into Q46_Customer (customer_id, product_key) 
values
(1, 5),
(2, 6),
(3, 5),
(3, 6),
(1, 6);

-- Q47: 
/**Write an SQL query that reports 
the most experienced employees in 
each project. In case of a tie,
report all employees with the maximum 
number of experience years.
Return the result table in any order.**/
SELECT t3.project_id, t3.employee_id
FROM
(select t1.project_id, t1.employee_id, t2.experience_years
from Q47_Project t1 
join Q47_Employee t2
on t1.employee_id = t2.employee_id) t3
JOIN
(select t1.project_id, max(t2.experience_years) as t
from Q47_Project t1 
join Q47_Employee t2
on t1.employee_id = t2.employee_id
group by t1.project_id) t4
ON
t3.project_id = t4.project_id
and t3.experience_years = t4.t;

create table if not exists Q47_Employee
(
    employee_id int primary key,
    name varchar(10),
    experience_years int
);

create table if not exists Q47_Project
(
    project_id int,
    employee_id int,
    primary key(project_id, employee_id),
    foreign key(employee_id) references Q47_Employee(employee_id)
);

insert into Q47_Employee (employee_id, name, experience_years)
values
(1, 'Khaled', 3),
(2, 'Ali', 2),
(3, 'John', 3),
(4, 'Doe', 2);

insert into Q47_Project (project_id, employee_id)
values
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 4);

-- Q48: 
/**Write an SQL query that reports 
the books that have sold less than 
10 copies in the last year, excluding 
books that have been available for 
less than one month from today. 
Assume today is 2019-06-23.
Return the result table in any order.**/
select t2.name, sum(t1.quantity) as total
from Q48_Orders t1
join Q48_Books t2
on t1.book_id = t2.book_id
where t1.dispatch_date between '2018-06-23' and '2019-06-23'
and t2.available_from < '2019-05-23'
group by t2.name
having total < 10;

create table if not exists Q48_Books
(
    book_id int primary key,
    name varchar(25),
    available_from date
);

create table if not exists Q48_Orders
(
    order_id int primary key,
    book_id int,
    quantity int,
    dispatch_date date,
    foreign key(book_id) references Q48_Books(book_id)
);

insert into Q48_Books (book_id, name, available_from)
values
(1, 'Kalila And Demna', '2010-01-01'),
(2, '28 Letters', '2012-05-12'),
(3, 'The Hobbit', '2019-06-10'),
(4, '13 Reasons Why', '2019-06-01'),
(5, 'The Hunger Games', '2008-09-21');

insert into Q48_Orders (order_id, book_id, quantity, dispatch_date)
values
(1, 1, 3, '2024-01-15'),
(2, 2, 1, '2024-01-20'),
(3, 3, 2, '2024-02-05'),
(4, 4, 5, '2024-02-10'),
(5, 5, 4, '2024-02-18'),
(6, 1, 2, '2024-03-01'),
(7, 2, 6, '2024-03-03'),
(8, 3, 1, '2024-03-07'),
(9, 4, 2, '2024-03-12'),
(10, 5, 3, '2024-03-15'),
(11, 1, 2, '2018-07-05'),
(12, 2, 1, '2018-08-12'),
(13, 3, 3, '2018-09-23'),
(14, 4, 2, '2018-11-01'),
(15, 5, 1, '2019-01-15'),
(16, 1, 1, '2019-03-22'),
(17, 2, 2, '2019-04-10'),
(18, 3, 1, '2019-05-09'),
(19, 4, 4, '2019-06-01'),
(20, 5, 3, '2019-06-20'),
(21, 1, 1, '2019-04-01'), 
(22, 2, 2, '2019-06-15'), 
(23, 3, 3, '2019-06-22'), 
(24, 1, 3, '2018-01-01'),
(25, 4, 5, '2019-06-10'),  
(26, 5, 2, '2019-06-23'); 

-- Q49: 
/**Write a SQL query to find the 
highest grade with its corresponding 
course for each student. In case of
a tie, you should find the course 
with the smallest course_id.
Return the result table ordered by 
student_id in ascending order.**/
SELECT student_id, course_id, grade
FROM 
(select *, 
row_number() over (partition by student_id order by grade desc, course_id asc) as rn
from Q49_Enrollments) as t1
WHERE rn = 1;

create table if not exists Q49_Enrollments
(
    student_id int,
    course_id int,
    grade int,
    primary key(student_id, course_id)
);

insert into Q49_Enrollments (student_id, course_id, grade)
values
(2, 2, 95),
(2, 3, 95),
(1, 1, 90),
(1, 2, 99),
(3, 1, 80),
(3, 2, 75),
(3, 3, 82);

-- Q50: 
/**The winner in each group is the 
player who scored the maximum total 
points within the group. In the case 
of a tie, the lowest player_id wins.
Write an SQL query to find the winner 
in each group.
Return the result table in any order.**/
SELECT final.group_id, final.player_id
FROM
(select 
	t3.group_id, 
	t3.player_id,
	row_number() over (partition by t3.group_id order by t3.total desc, t3.player_id asc) as rn
from
(select t1.group_id, t1.player_id, t2.total 
from Q50_Players t1
join
(select player_id, sum(score) as total
from
(select first_player as player_id, first_score as score 
from Q50_Matches
union all
select second_player as player_id, second_score as score 
from Q50_Matches) as combined_scores
group by player_id) t2
on t1.player_id = t2.player_id) as t3) as final
where rn = 1;

create table if not exists Q50_Players
(
    player_id int,
    group_id int
);

create table if not exists Q50_Matches
(
    match_id int primary key,
    first_player int,
    second_player int,
    first_score int,
    second_score int
);

insert into Q50_Players (player_id, group_id)
values 
(15, 1),
(25, 1),
(30, 1),
(45, 1),
(10, 2),
(35, 2),
(50, 2),
(20, 3),
(40, 3);

insert into Q50_Matches (match_id, first_player, second_player, first_score, second_score)
values 
(1, 15, 45, 3, 0),
(2, 30, 25, 1, 2),
(3, 30, 15, 2, 0),
(4, 40, 20, 5, 2),
(5, 35, 50, 1, 1);