use bra;
SELECT * FROM bra;
# 1. Find the total matches played in season 2024?
select season, count(*) as Total_Matches, count(distinct Home) as Home_Teams, count(distinct Away) as Away_Teams
from bra
where season = 2024
group by season;

# 2. Find the total matches played by each team in season 2024?
select team, count(*) as Matches_Played
from(
select Home as Team 
from bra
where season = 2024
union all
select away as Team 
from bra
where season = 2024) as ALL_Teams
group by Team;

# 3. Combining Home and Away Performance

select Home as Team, HG as Goals_For, AG as Goals_Against
from bra
where Season = 2024
union all
select Away as Team, AG as Goals_For, HG as Goals_Against
from bra
where Season = 2024;

select Team, count(*) as MP, sum(case when Goals_For > Goals_Against then 1 else 0 end) as Wins,
			sum(case when Goals_For = Goals_Against then 1 else 0 end) as Draws,
            sum(case when Goals_For < Goals_Against then 1 else 0 end) as Losses,
            sum(Goals_For) as GF, sum(Goals_Against) as GA, sum(Goals_For)  - sum(Goals_Against) as GD,
            sum(case when Goals_For > Goals_Against then 3 
					when Goals_For = Goals_Against then 1 else 0 end) as Pts
            from(select Home as Team, HG as Goals_For, AG as Goals_Against
from bra
where Season = 2024
union all
select Away as Team, AG as Goals_For, HG as Goals_Against
from bra
where Season = 2024) as All_Matches
group by Team
order by 
Pts desc,
GD desc,
GF desc
limit 5;

select Home, count(*) as H_Results
from
	(select Home,
	HG,
	AG from bra
where Season = 2024 and Home = 'Botafogo RJ') as mp_Botafogo_RJ
group by Home;

select Home, count(*) as H_Results
from
	(select Home,
	HG,
	AG from bra
where Season = 2024 and Home = 'Botafogo RJ' and HG = AG) as mp_Botafogo_RJ
group by Home;

select Away, count(*) as H_Results
from
	(select Away,
	HG,
	AG from bra
where Season = 2024 and Away = 'Botafogo RJ' and AG > HG ) as mp_Botafogo_RJ
group by Away;

select sum(case when HG > AG then 3
			when HG = AG then 1 else 0 end) as Home_Points
from bra
where Season = 2024 and Home = 'Botafogo RJ';

select sum(case when AG > HG then 3
			when AG = HG then 1 else 0 end) as Away_Points
from bra
where Season = 2024 and Away = 'Botafogo RJ';

Select Home, sum(case when HG > AG then 3
			when HG = AG then 1 else 0 end)  as Home_points
from bra
where Season = 2024
group by Home
order by Home_points desc
limit 5;

Select Away, sum(case when AG > HG then 3
			when AG = HG then 1 else 0 end)  as Away_points
from bra
where Season = 2024
group by Away
order by Away_points desc
limit 5;

Select H.Team, H.Home_points, A.Away_points, H.Home_points + A.Away_points as Total_Points,
H.Home_points - A.Away_points as Home_Advantage, round((H.Home_points/(H.Home_points + A.Away_points))*100,2 )  as Home_Points_Percentage,
abs(H.Home_points - A.Away_points) as Home_Away_Gap
from (
	Select Home as Team, sum(case when HG > AG then 3
			when HG = AG then 1 else 0 end)  as Home_points
from bra
where Season = 2024
group by Home) as H
join (
	Select Away as Team, sum(case when AG > HG then 3
			when AG = HG then 1 else 0 end)  as Away_points
from bra
where Season = 2024
group by Away) as A
on H.Team = A.Team
order by Home_Away_Gap 
limit 5;


# Measuring Consistency
Select 
Team, Home_Points, Away_Points,Total_Points, Home_Away_Gap,
CASE
    WHEN Home_Away_Gap <= 5 THEN 'Very Balanced'
    WHEN Home_Away_Gap <= 10 THEN 'Fairly Balanced'
    WHEN Home_Away_Gap <= 20 THEN 'Home/Away Dependent'
    ELSE 'Highly Dependent'
END AS Performance_Class
from	 
(SELECT
H.Team,
H.Home_Points,
A.Away_Points,

H.Home_Points + A.Away_Points AS Total_Points,  

ABS(H.Home_Points - A.Away_Points) AS Home_Away_Gap


from (
Select Home as Team, sum(case when HG > AG then 3
when HG = AG then 1 else 0 end)  as Home_points
from bra
where Season = 2024
group by Home) as H
join (
Select Away as Team, sum(case when AG > HG then 3
when AG = HG then 1 else 0 end)  as Away_points
from bra
where Season = 2024
group by Away) as A
on H.Team = A.Team) as Team_Analysis
order by Home_Away_Gap asc;

select Performance_Class, Count(*) as Total_Num from
(Select 
Team, Home_Points, Away_Points,Total_Points, Home_Away_Gap,
CASE
    WHEN Home_Away_Gap <= 5 THEN 'Very Balanced'
    WHEN Home_Away_Gap <= 10 THEN 'Fairly Balanced'
    WHEN Home_Away_Gap <= 20 THEN 'Home/Away Dependent'
    ELSE 'Highly Dependent'
END AS Performance_Class
from	 
(SELECT
H.Team,
H.Home_Points,
A.Away_Points,

H.Home_Points + A.Away_Points AS Total_Points,  

ABS(H.Home_Points - A.Away_Points) AS Home_Away_Gap


from (
Select Home as Team, sum(case when HG > AG then 3
when HG = AG then 1 else 0 end)  as Home_points
from bra
where Season = 2024
group by Home) as H
join (
Select Away as Team, sum(case when AG > HG then 3
when AG = HG then 1 else 0 end)  as Away_points
from bra
where Season = 2024
group by Away) as A
on H.Team = A.Team) as Team_Analysis
order by Home_Away_Gap asc) as Classified_Team
Group by Performance_Class
order by Total_Num asc;

# Performance beyond points
select Home, sum(HG) as Home_Goals_Scored
from bra
where Season = 2024 and Home = 'Botafogo RJ'
group by Home;

select Away, sum(AG) as Home_Goals_Scored
from bra
where Season = 2024 and Away = 'Botafogo RJ'
group by Away;

select Home, sum(AG) as Home_Goals_Conceded
from bra
where Season = 2024 and Home = 'Botafogo RJ'
group by Home;

select Away, sum(HG) as Away_Goals_Conceded
from bra
where Season = 2024 and Away = 'Botafogo RJ'
group by Away;

select Home as Team, sum(HG) as Home_Goals_Scored
from bra
where Season = 2024 
group by Home
order by Home_Goals_Scored desc
limit 5;

select Home as Team, sum(AG) as Home_Goals_Conceded
from bra
where Season = 2024 
group by Home
order by Home_Goals_Conceded asc
limit 5;

select Away as Team, sum(AG) as Away_Goals_Scored
from bra
where Season = 2024 
group by Away
order by Away_Goals_Scored desc
limit 5;

select Away as Team, sum(HG) as Away_Goals_Conceded
from bra
where Season = 2024 
group by Away
order by  Away_Goals_Conceded
limit 5;
# Overall attacking strength
select 
H.Team,H.Home_GF,H.Home_GA,H.Home_GF - H.Home_GA as Home_GD,ROUND(
    (H.Home_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Home_Attack_Per,
ROUND(
    (H.Home_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Home_Defense_Contr,
A.Away_GF,A.Away_GA,
A.Away_GF - A.Away_GA as Away_GD,
ROUND(
    (A.Away_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Away_Attack_Contr,
ROUND(
    (A.Away_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Away_Defense_Contr,
A.Away_GF + H.Home_GF as Total_GF,
A.Away_GA + H.Home_GA as Total_GA,
(A.Away_GF - A.Away_GA) + (H.Home_GF - H.Home_GA) as Total_GD

from
(
SELECT
    Home AS Team,
    SUM(HG) AS Home_GF,
    SUM(AG) AS Home_GA
FROM bra
WHERE Season = 2024
GROUP BY Home) as H
join (

SELECT
    Away AS Team,
    SUM(AG) AS Away_GF,
    SUM(HG) AS Away_GA
FROM bra
WHERE Season = 2024
GROUP BY Away) as A
on H.Team = A.Team
order by Total_GF desc,
 Total_GD desc
 limit 5;

# overall goal performance
select 
H.Team,H.Home_GF,H.Home_GA,H.Home_GF - H.Home_GA as Home_GD,ROUND(
    (H.Home_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Home_Attack_Per,
ROUND(
    (H.Home_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Home_Defense_Contr,
A.Away_GF,A.Away_GA,
A.Away_GF - A.Away_GA as Away_GD,
ROUND(
    (A.Away_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Away_Attack_Contr,
ROUND(
    (A.Away_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Away_Defense_Contr,
A.Away_GF + H.Home_GF as Total_GF,
A.Away_GA + H.Home_GA as Total_GA,
(A.Away_GF - A.Away_GA) + (H.Home_GF - H.Home_GA) as Total_GD

from
(
SELECT
    Home AS Team,
    SUM(HG) AS Home_GF,
    SUM(AG) AS Home_GA
FROM bra
WHERE Season = 2024
GROUP BY Home) as H
join (

SELECT
    Away AS Team,
    SUM(AG) AS Away_GF,
    SUM(HG) AS Away_GA
FROM bra
WHERE Season = 2024
GROUP BY Away) as A
on H.Team = A.Team
order by Total_GD desc,
 Total_GF desc
 limit 5;
 
 # overall defensive strength
select 
H.Team,H.Home_GF,H.Home_GA,H.Home_GF - H.Home_GA as Home_GD,ROUND(
    (H.Home_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Home_Attack_Per,
ROUND(
    (H.Home_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Home_Defense_Contr,
A.Away_GF,A.Away_GA,
A.Away_GF - A.Away_GA as Away_GD,
ROUND(
    (A.Away_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Away_Attack_Contr,
ROUND(
    (A.Away_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Away_Defense_Contr,
A.Away_GF + H.Home_GF as Total_GF,
A.Away_GA + H.Home_GA as Total_GA,
(A.Away_GF - A.Away_GA) + (H.Home_GF - H.Home_GA) as Total_GD
from
(
SELECT
    Home AS Team,
    SUM(HG) AS Home_GF,
    SUM(AG) AS Home_GA
FROM bra
WHERE Season = 2024
GROUP BY Home) as H
join (

SELECT
    Away AS Team,
    SUM(AG) AS Away_GF,
    SUM(HG) AS Away_GA
FROM bra
WHERE Season = 2024
GROUP BY Away) as A
on H.Team = A.Team
order by Total_GA asc,
 Total_GD desc
 limit 5;
 
 # goal per match
 -- Home Attacking Ranking
 select T.Team,T.Home_GD, T.Away_GD,T.Total_GD, ROUND(T.Home_GF / 19, 2) AS Home_GF_Per_Match,
 ROUND(T.Away_GF / 19, 2) AS Away_GF_Per_Match,
ROUND(T.Home_GA / 19, 2) AS Home_GA_Per_Match,
ROUND(T.Away_GA / 19, 2) AS Away_GA_Per_Match
 from
(select 
H.Team,H.Home_GF,H.Home_GA,H.Home_GF - H.Home_GA as Home_GD,ROUND(
    (H.Home_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Home_Attack_Per,
ROUND(
    (H.Home_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Home_Defense_Contr,
A.Away_GF,A.Away_GA,
A.Away_GF - A.Away_GA as Away_GD,
ROUND(
    (A.Away_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Away_Attack_Contr,
ROUND(
    (A.Away_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Away_Defense_Contr,
A.Away_GF + H.Home_GF as Total_GF,
A.Away_GA + H.Home_GA as Total_GA,
(A.Away_GF - A.Away_GA) + (H.Home_GF - H.Home_GA) as Total_GD

from
(
SELECT
    Home AS Team,
    SUM(HG) AS Home_GF,
    SUM(AG) AS Home_GA
FROM bra
WHERE Season = 2024
GROUP BY Home) as H
join (

SELECT
    Away AS Team,
    SUM(AG) AS Away_GF,
    SUM(HG) AS Away_GA
FROM bra
WHERE Season = 2024
GROUP BY Away) as A
on H.Team = A.Team
order by Total_GD desc,
 Total_GF desc) as T
 ORDER by Home_GF_Per_Match desc
 limit 5;
 
 -- Away Attacking Ranking
  select T.Team,T.Home_GD, T.Away_GD,T.Total_GD, ROUND(T.Home_GF / 19, 2) AS Home_GF_Per_Match,
 ROUND(T.Away_GF / 19, 2) AS Away_GF_Per_Match,
ROUND(T.Home_GA / 19, 2) AS Home_GA_Per_Match,
ROUND(T.Away_GA / 19, 2) AS Away_GA_Per_Match
 from
(select 
H.Team,H.Home_GF,H.Home_GA,H.Home_GF - H.Home_GA as Home_GD,ROUND(
    (H.Home_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Home_Attack_Per,
ROUND(
    (H.Home_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Home_Defense_Contr,
A.Away_GF,A.Away_GA,
A.Away_GF - A.Away_GA as Away_GD,
ROUND(
    (A.Away_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Away_Attack_Contr,
ROUND(
    (A.Away_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Away_Defense_Contr,
A.Away_GF + H.Home_GF as Total_GF,
A.Away_GA + H.Home_GA as Total_GA,
(A.Away_GF - A.Away_GA) + (H.Home_GF - H.Home_GA) as Total_GD

from
(
SELECT
    Home AS Team,
    SUM(HG) AS Home_GF,
    SUM(AG) AS Home_GA
FROM bra
WHERE Season = 2024
GROUP BY Home) as H
join (

SELECT
    Away AS Team,
    SUM(AG) AS Away_GF,
    SUM(HG) AS Away_GA
FROM bra
WHERE Season = 2024
GROUP BY Away) as A
on H.Team = A.Team
order by Total_GD desc,
 Total_GF desc) as T
 ORDER by Away_GF_Per_Match desc
 limit 5;
 
 # best home defence
 select T.Team,T.Home_GD, T.Away_GD,T.Total_GD, ROUND(T.Home_GF / 19, 2) AS Home_GF_Per_Match,
 ROUND(T.Away_GF / 19, 2) AS Away_GF_Per_Match,
ROUND(T.Home_GA / 19, 2) AS Home_GA_Per_Match,
ROUND(T.Away_GA / 19, 2) AS Away_GA_Per_Match
 from
(select 
H.Team,H.Home_GF,H.Home_GA,H.Home_GF - H.Home_GA as Home_GD,ROUND(
    (H.Home_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Home_Attack_Per,
ROUND(
    (H.Home_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Home_Defense_Contr,
A.Away_GF,A.Away_GA,
A.Away_GF - A.Away_GA as Away_GD,
ROUND(
    (A.Away_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Away_Attack_Contr,
ROUND(
    (A.Away_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Away_Defense_Contr,
A.Away_GF + H.Home_GF as Total_GF,
A.Away_GA + H.Home_GA as Total_GA,
(A.Away_GF - A.Away_GA) + (H.Home_GF - H.Home_GA) as Total_GD

from
(
SELECT
    Home AS Team,
    SUM(HG) AS Home_GF,
    SUM(AG) AS Home_GA
FROM bra
WHERE Season = 2024
GROUP BY Home) as H
join (

SELECT
    Away AS Team,
    SUM(AG) AS Away_GF,
    SUM(HG) AS Away_GA
FROM bra
WHERE Season = 2024
GROUP BY Away) as A
on H.Team = A.Team
order by Total_GD desc,
 Total_GF desc) as T
 ORDER by Home_GF_Per_Match asc
 limit 5;
 
 # away best defence
 select T.Team,T.Home_GD, T.Away_GD,T.Total_GD, ROUND(T.Home_GF / 19, 2) AS Home_GF_Per_Match,
 ROUND(T.Away_GF / 19, 2) AS Away_GF_Per_Match,
ROUND(T.Home_GA / 19, 2) AS Home_GA_Per_Match,
ROUND(T.Away_GA / 19, 2) AS Away_GA_Per_Match
 from
(select 
H.Team,H.Home_GF,H.Home_GA,H.Home_GF - H.Home_GA as Home_GD,ROUND(
    (H.Home_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Home_Attack_Per,
ROUND(
    (H.Home_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Home_Defense_Contr,
A.Away_GF,A.Away_GA,
A.Away_GF - A.Away_GA as Away_GD,
ROUND(
    (A.Away_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Away_Attack_Contr,
ROUND(
    (A.Away_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Away_Defense_Contr,
A.Away_GF + H.Home_GF as Total_GF,
A.Away_GA + H.Home_GA as Total_GA,
(A.Away_GF - A.Away_GA) + (H.Home_GF - H.Home_GA) as Total_GD


from
(
SELECT
    Home AS Team,
    SUM(HG) AS Home_GF,
    SUM(AG) AS Home_GA
FROM bra
WHERE Season = 2024
GROUP BY Home) as H
join (

SELECT
    Away AS Team,
    SUM(AG) AS Away_GF,
    SUM(HG) AS Away_GA
FROM bra
WHERE Season = 2024
GROUP BY Away) as A
on H.Team = A.Team
order by Total_GD desc,
 Total_GF desc) as T
 ORDER by Away_GF_Per_Match asc
 limit 5;
 
# home vs away gap
select b.Team, 
b.Home_GF_Per_Match, b.Away_GF_Per_Match, b.Home_GA_Per_Match, b.Away_GA_Per_Match,
ROUND(
    b.Home_GF_Per_Match -
    b.Away_GF_Per_Match, 2
) AS Home_Away_Attack_Gap
 from( 
 select T.Team,T.Home_GD, T.Away_GD,T.Total_GD, ROUND(T.Home_GF / 19, 2) AS Home_GF_Per_Match,
 ROUND(T.Away_GF / 19, 2) AS Away_GF_Per_Match,
ROUND(T.Home_GA / 19, 2) AS Home_GA_Per_Match,
ROUND(T.Away_GA / 19, 2) AS Away_GA_Per_Match
 from
(select 
H.Team,H.Home_GF,H.Home_GA,H.Home_GF - H.Home_GA as Home_GD,ROUND(
    (H.Home_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Home_Attack_Per,
ROUND(
    (H.Home_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Home_Defense_Contr,
A.Away_GF,A.Away_GA,
A.Away_GF - A.Away_GA as Away_GD,
ROUND(
    (A.Away_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Away_Attack_Contr,
ROUND(
    (A.Away_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Away_Defense_Contr,
A.Away_GF + H.Home_GF as Total_GF,
A.Away_GA + H.Home_GA as Total_GA,
(A.Away_GF - A.Away_GA) + (H.Home_GF - H.Home_GA) as Total_GD

from
(
SELECT
    Home AS Team,
    SUM(HG) AS Home_GF,
    SUM(AG) AS Home_GA
FROM bra
WHERE Season = 2024
GROUP BY Home) as H
join (

SELECT
    Away AS Team,
    SUM(AG) AS Away_GF,
    SUM(HG) AS Away_GA
FROM bra
WHERE Season = 2024
GROUP BY Away) as A
on H.Team = A.Team
order by Total_GD desc,
 Total_GF desc) as T
 ORDER by Away_GF_Per_Match asc
 ) as b
 
 order by Home_Away_Attack_Gap asc;

# team scoring more goals at home
# home vs away gap
select b.Team, 
b.Home_GF_Per_Match, b.Away_GF_Per_Match, b.Home_GA_Per_Match, b.Away_GA_Per_Match,
ROUND(
    b.Home_GF_Per_Match -
    b.Away_GF_Per_Match, 2
) AS Home_Away_Attack_Gap
 from( 
 select T.Team,T.Home_GD, T.Away_GD,T.Total_GD, ROUND(T.Home_GF / 19, 2) AS Home_GF_Per_Match,
 ROUND(T.Away_GF / 19, 2) AS Away_GF_Per_Match,
ROUND(T.Home_GA / 19, 2) AS Home_GA_Per_Match,
ROUND(T.Away_GA / 19, 2) AS Away_GA_Per_Match
 from
(select 
H.Team,H.Home_GF,H.Home_GA,H.Home_GF - H.Home_GA as Home_GD,ROUND(
    (H.Home_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Home_Attack_Per,
ROUND(
    (H.Home_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Home_Defense_Contr,
A.Away_GF,A.Away_GA,
A.Away_GF - A.Away_GA as Away_GD,
ROUND(
    (A.Away_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Away_Attack_Contr,
ROUND(
    (A.Away_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Away_Defense_Contr,
A.Away_GF + H.Home_GF as Total_GF,
A.Away_GA + H.Home_GA as Total_GA,
(A.Away_GF - A.Away_GA) + (H.Home_GF - H.Home_GA) as Total_GD

from
(
SELECT
    Home AS Team,
    SUM(HG) AS Home_GF,
    SUM(AG) AS Home_GA
FROM bra
WHERE Season = 2024
GROUP BY Home) as H
join (

SELECT
    Away AS Team,
    SUM(AG) AS Away_GF,
    SUM(HG) AS Away_GA
FROM bra
WHERE Season = 2024
GROUP BY Away) as A
on H.Team = A.Team
order by Total_GD desc,
 Total_GF desc) as T
 ORDER by Away_GF_Per_Match asc
 ) as b
 where b.Home_GF_Per_Match < b.Away_GF_Per_Match
 order by Home_Away_Attack_Gap asc;
 
 # Teams conceding more goals away than at home
 
select b.Team, 
b.Home_GF_Per_Match, b.Away_GF_Per_Match, b.Home_GA_Per_Match, b.Away_GA_Per_Match,
ROUND(
    b.Home_GF_Per_Match -
    b.Away_GF_Per_Match, 2
) AS Home_Away_Attack_Gap
 from( 
 select T.Team,T.Home_GD, T.Away_GD,T.Total_GD, ROUND(T.Home_GF / 19, 2) AS Home_GF_Per_Match,
 ROUND(T.Away_GF / 19, 2) AS Away_GF_Per_Match,
ROUND(T.Home_GA / 19, 2) AS Home_GA_Per_Match,
ROUND(T.Away_GA / 19, 2) AS Away_GA_Per_Match
 from
(select 
H.Team,H.Home_GF,H.Home_GA,H.Home_GF - H.Home_GA as Home_GD,ROUND(
    (H.Home_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Home_Attack_Per,
ROUND(
    (H.Home_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Home_Defense_Contr,
A.Away_GF,A.Away_GA,
A.Away_GF - A.Away_GA as Away_GD,
ROUND(
    (A.Away_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Away_Attack_Contr,
ROUND(
    (A.Away_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Away_Defense_Contr,
A.Away_GF + H.Home_GF as Total_GF,
A.Away_GA + H.Home_GA as Total_GA,
(A.Away_GF - A.Away_GA) + (H.Home_GF - H.Home_GA) as Total_GD

from
(
SELECT
    Home AS Team,
    SUM(HG) AS Home_GF,
    SUM(AG) AS Home_GA
FROM bra
WHERE Season = 2024
GROUP BY Home) as H
join (

SELECT
    Away AS Team,
    SUM(AG) AS Away_GF,
    SUM(HG) AS Away_GA
FROM bra
WHERE Season = 2024
GROUP BY Away) as A
on H.Team = A.Team
order by Total_GD desc,
 Total_GF desc) as T
 ORDER by Away_GF_Per_Match asc
 ) as b
 where b.Home_GA_Per_Match < b.Away_GA_Per_Match
 order by b.Away_GA_Per_Match desc;

# Home_Away_Defence_Gap
CREATE VIEW
v_team_venue_2024 as
select b.Team, 
b.Home_GF_Per_Match, b.Away_GF_Per_Match, b.Home_GA_Per_Match, b.Away_GA_Per_Match,
ROUND(
    b.Home_GF_Per_Match -
    b.Away_GF_Per_Match, 2
) AS Home_Away_Attack_Gap,
ROUND(
    b.Away_GA_Per_Match - b.Home_GA_Per_Match, 2
) AS Home_Away_Defense_Gap
 from( 
 select T.Team,T.Home_GD, T.Away_GD,T.Total_GD, ROUND(T.Home_GF / 19, 2) AS Home_GF_Per_Match,
 ROUND(T.Away_GF / 19, 2) AS Away_GF_Per_Match,
ROUND(T.Home_GA / 19, 2) AS Home_GA_Per_Match,
ROUND(T.Away_GA / 19, 2) AS Away_GA_Per_Match
 from
(select 
H.Team,H.Home_GF,H.Home_GA,H.Home_GF - H.Home_GA as Home_GD,ROUND(
    (H.Home_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Home_Attack_Per,
ROUND(
    (H.Home_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Home_Defense_Contr,
A.Away_GF,A.Away_GA,
A.Away_GF - A.Away_GA as Away_GD,
ROUND(
    (A.Away_GF / (H.Home_GF + A.Away_GF)) * 100,
    2
) AS Away_Attack_Contr,
ROUND(
    (A.Away_GA / (H.Home_GA + A.Away_GA)) * 100,
    2
) AS Away_Defense_Contr,
A.Away_GF + H.Home_GF as Total_GF,
A.Away_GA + H.Home_GA as Total_GA,
(A.Away_GF - A.Away_GA) + (H.Home_GF - H.Home_GA) as Total_GD

from
(
SELECT
    Home AS Team,
    SUM(HG) AS Home_GF,
    SUM(AG) AS Home_GA
FROM bra
WHERE Season = 2024
GROUP BY Home) as H
join (

SELECT
    Away AS Team,
    SUM(AG) AS Away_GF,
    SUM(HG) AS Away_GA
FROM bra
WHERE Season = 2024
GROUP BY Away) as A
on H.Team = A.Team
) as T
 
 ) as b;
 
 select count(*) as total_teams
 from v_team_venue_2024;
