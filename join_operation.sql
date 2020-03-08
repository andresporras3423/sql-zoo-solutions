/*Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'*/
SELECT g.matchid, g.player 
FROM goal g 
  WHERE g.teamid = 'GER'
/*Show id, stadium, team1, team2 for just game 1012*/
SELECT id,stadium,team1,team2
  FROM game
where id=1012
/*Modify it to show the player, teamid, stadium and mdate for every German goal.*/
SELECT go.player, go.teamid ,ga.stadium, ga.mdate
  FROM game ga JOIN goal go ON (ga.id=go.matchid)
where go.teamid='GER'
/*Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'*/
select ga.team1, ga.team2, go.player
from game ga
 join goal go
 on (ga.id = go.matchid)
where go.player like 'Mario%'
/*Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10*/
SELECT go.player, go.teamid, et.coach, go.gtime 
  FROM goal go
join eteam et
on (go.teamid = et.id)
 WHERE go.gtime<=10
/*List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.*/
select ga.mdate, et.teamname
from game ga
join eteam et
on (ga.team1=et.id)
where et.coach='Fernando Santos'
/*List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'*/
select go.player
from goal go
join game ga
on (go.matchid=ga.id)
where ga.stadium = 'National Stadium, Warsaw'
/*Instead show the name of all players who scored a goal against Germany.*/
SELECT go.player
  FROM game ga JOIN goal go ON (go.matchid = ga.id) 
    WHERE go.teamid<>'GER' and (ga.team1='GER' OR ga.team2='GER')
group by go.player
order by ga.id
/*Show teamname and the total number of goals scored*/
SELECT et.teamname, count(go.player)
  FROM eteam et JOIN goal go ON et.id=go.teamid
 group by et.teamname
/*Show the stadium and the number of goals scored in each stadium.*/
select ga.stadium, count(go.player)
from game ga
join goal go
on ( ga.id= go.matchid)
group by ga.stadium
/*For every match involving 'POL', show the matchid, date and the number of goals scored.*/
SELECT go.matchid, ga.mdate, count(go.player)
  FROM game ga JOIN goal go ON go.matchid = ga.id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
group by go.matchid
/*For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'*/
select go.matchid, ga.mdate, count(go.player)
from game ga
join goal go
on (ga.id=go.matchid)
where go.teamid='GER'
group by go.matchid
/*List every match with the goals scored by each team*/
select A.mdate, A.team1, A.score1, B.team2, B.score2
from (select ga.id, ga.mdate, ga.team1, count(go.player) as 'score1'
from game ga
left join goal go
on (ga.id=go.matchid and ga.team1=go.teamid)
group by ga.id
) as A
join 
(select ga.id, ga.mdate, ga.team2, count(go.player) as 'score2'
from game ga
left join goal go
on (ga.id=go.matchid and ga.team2=go.teamid)
group by ga.id
) as B
on (A.id=B.id)
order by concat(A.mdate,''), A.id, A.team1, B.team2