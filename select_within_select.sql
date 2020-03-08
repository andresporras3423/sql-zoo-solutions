/*List each country name where the population is larger than that of 'Russia'.*/
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia'limit 1)
/*Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.*/
select name
from world
where continent='Europe' 
and gdp/population > (select gdp/population 
from world 
where name ='United Kingdom')
/*List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.*/
select name, continent
from world where continent in (select continent
from world where name in ('Argentina','Australia'))
order by name
/*Which country has a population that is more than Canada but less than Poland? Show the name and the population.*/
select name, population 
from world
where population > (select population
from world
where name='Canada' limit 1)
and population < (select population
from world
where name='Poland' limit 1)
/*Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.*/
select name, 
concat(round(population*100/(select population
from world
where name='Germany' limit 1), 0), '%')
from world
where continent='Europe'
/*Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)*/
select name
from world
where gdp is not null
and gdp > ALL(select gdp
from world 
where
gdp is not null
 and continent='Europe')
/*Find the largest country (by area) in each continent, show the continent, the name and the area:*/
SELECT x.continent, x.name, x.area FROM world x
  WHERE x.area >= ALL
    (SELECT y.area FROM world y
        WHERE y.continent=x.continent)
order by x.name
/*List each continent and the name of the country that comes first alphabetically.*/
select x.continent, x.name
from world x
where x.name = (select y.name 
from world y
where y.continent=x.continent
order by name 
limit 1)
/*Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.*/
select name, continent, population
from world
where continent in 
(
select x.continent
from world x
where (
select count(*)
from world y
where y.continent=x.continent
and y.population>25000000
)=0
)
/*Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.*/
select x.name, x.continent
from world x
where (
select count(*)
from world y
where y.name<>x.name
and y.continent=x.continent
and y.population*3 >=x.population limit 1
)=0