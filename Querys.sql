







describe city_table;
use assigment1;
select * from city_table
where POPULATION > 100000;

select NAME_ from city_table
where POPULATION > 120000;

select * from city_table;

select * from city_table
where ID=1661;

select * from city_table
where COUNTRYCODE= "JPN";

select NAME_ from city_table
where COUNTRYCODE= "JPN";

CREATE TABLE STATION (
    ID int,
    CITY VARCHAR(21),
    STATE VARCHAR(2),
    LAT_N numeric,
    LONG_W numeric
);

select * from station;

select id, city from station where ID in 
(select ID from station group by id having count(id) = 1);

select count(*) from (select state from station group by state having count(state) = 1) AS unique_ids;

select count(*) from station;



