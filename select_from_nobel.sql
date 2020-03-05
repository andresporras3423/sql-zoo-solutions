/*Change the query shown so that it displays Nobel prizes for 1950.*/
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950
/*Show who won the 1962 prize for Literature.*/
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'
/*Show the year and subject that won 'Albert Einstein' his prize.*/
select yr, subject
from nobel
where winner = 'Albert Einstein'
/*Give the name of the 'Peace' winners since the year 2000, including 2000.*/
select winner
from nobel
where yr>=2000 and subject='Peace'
/*Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.*/
select yr, subject, winner
from nobel
where yr>=1980 and yr <=1989 and subject='Literature'
/*Show all details of the presidential winners:
Theodore Roosevelt
Woodrow Wilson
Jimmy Carter
Barack Obama*/
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama')

/*Show the winners with first name John*/
select winner
from nobel
where winner like 'John%'
/*Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.*/
select yr, subject, winner
from nobel
where (yr=1980 and subject='Physics')
or (yr=1984 and subject='Chemistry')
/*Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine*/
select yr, subject, winner
from nobel
where subject not in ('Chemistry','Medicine')
and yr=1980
/*Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)*/
select yr, subject, winner
from nobel
where (subject='Medicine' and yr<1910)
or (subject='Literature' and yr>=2004)
/*Find all details of the prize won by PETER GRÜNBERG*/
select * from nobel
where winner = 'PETER GRÜNBERG'
/*Find all details of the prize won by EUGENE O'NEILL*/
select * from nobel where winner = "EUGENE O'NEILL"
/*List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.*/
select winner, yr, subject
from nobel
where winner like 'Sir%'
order by yr DESC, winner
/*Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.*/
select winner, subject 
from (SELECT winner, subject, subject IN ('Physics','Chemistry') as 'last'
  FROM nobel
 WHERE yr=1984) as A
ORDER BY last, subject,winner
/*List the winners, year and subject where the winner starts with Sir. Show in the first position the most recent winner, then order the next items by name.*/
select winner, yr, subject 
from ((select winner, yr, subject, 1 as temp
from nobel
where winner like'Sir%' 
order by yr desc
limit 1)
UNION 
(select winner, yr, subject, 2 as temp
from nobel
where winner like 'Sir%'
order by winner)) as C