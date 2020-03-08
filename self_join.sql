/*How many stops are in the database.*/
select count(*)
from stops
/*Find the id value for the stop 'Craiglockhart'*/
select id
from stops
where name='Craiglockhart'
/*Give the id and the name for the stops on the '4' 'LRT' service.*/
select s.id, s.name 
from route r
join stops s
on (r.stop=s.id)
where r.company='LRT'
and r.num='4'
/*The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.*/
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
having count(*)>1
/*Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.*/
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 and b.stop=149
/*The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'*/
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' and 
stopb.name='London Road'
/*Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')*/
SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=115 and b.stop=137
group by a.company, a.num
/*Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'*/
SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
join stops sa
on (a.stop=sa.id)
join stops sb
on (b.stop=sb.id)
WHERE sa.name='Craiglockhart' and sb.name='Tollcross'
group by a.company, a.num
/*Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.*/
SELECT sa.name, a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
join stops sa
on (a.stop=sa.id)
join stops sb
on (b.stop=sb.id)
WHERE sb.name='Craiglockhart'
order by a.num, a.pos
/*Find the routes involving two buses that can go from Craiglockhart to Lochend. Show the bus no. and company for the first bus, the name of the stop for the transfer, and the bus no. and company for the second bus.*/
select ra.num, ra.company, ra.name2, rb.num, rb.company from
(SELECT sa.name, a.company, a.num, b.stop, sb.name as 'name2'
FROM route a JOIN route b ON
  (select a.company=b.company AND a.num=b.num)
join stops sa
on (a.stop=sa.id)
join stops sb
on (b.stop=sb.id)
WHERE sa.name='Craiglockhart'
order by a.num, a.pos) as ra
join
(SELECT sa.name, a.company, a.num, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
join stops sa
on (a.stop=sa.id)
join stops sb
on (b.stop=sb.id)
WHERE sa.name='Lochend'
order by a.num, a.pos) as rb
on (ra.stop=rb.stop)
order by ra.num, ra.name2, rb.num