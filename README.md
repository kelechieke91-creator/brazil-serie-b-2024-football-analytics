Brazil Serie B 2024 – Football Performance Analytics

Project Overview

This project analyses the 2024 Brazil Serie B football season using MySQL and Power BI. It focuses on comparing the home and away performances of the 20 participating teams across 380 matches.

The analysis examines goals scored, goals conceded, attacking differences and defensive differences between home and away matches. SQL was used to calculate team-level performance metrics, while Power BI was used to develop an interactive dashboard for exploring the results.

Dataset and Scope

Attribute| Details
Competition| Brazil Serie B
Season| 2024
Teams| 20
Matches| 380
Data source| "Football-Data.co.uk" (https://www.football-data.co.uk/)
Database| "brazil_serieb_db"
Source table| "bra"

The match-level CSV dataset was downloaded from Football-Data.co.uk and imported directly into MySQL Workbench for analysis.

Tools and Technologies

- MySQL Workbench 8.0.46: Database management and SQL analysis.
- MySQL: Data aggregation, performance calculations and analytical view creation.
- Microsoft Power BI Desktop: Data visualisation and interactive dashboard development.
- Football-Data.co.uk: Source of the match-level dataset.

SQL Analysis and Methodology

SQL was used to examine team performance across home and away matches during the 2024 season.

The analysis involved:

1. Data exploration: Examining match records, identifying teams and validating match totals.
2. Team performance aggregation: Using "SUM()" and "COUNT()" to calculate goals scored, goals conceded, match outcomes and points.
3. Home and away analysis: Separately evaluating each team's performance at both venues.
4. Performance metrics: Calculating average goals scored and conceded per match, using 19 home and 19 away matches per team.
5. Comparative analysis: Developing custom indicators to measure attacking and defensive differences.
6. SQL view creation: Creating "v_team_venue_2024" as a consolidated dataset for Power BI.

SQL techniques included "SELECT", "WHERE", "GROUP BY", "UNION ALL", aggregate functions, "CASE", subqueries, "ROUND()", "ABS()" and "CREATE VIEW".

Custom Performance Indicators

Two custom indicators were developed to measure differences in team performance across home and away matches.

1. Home/Away Attacking Gap

Formula:

"Home Goals Scored per Match - Away Goals Scored per Match"

- Positive value: The team scores more goals per match at home.
- Negative value: The team scores more goals per match away.
- Zero: Equal scoring rates at both venues.

2. Home/Away Defensive Gap

Formula:

"Away Goals Conceded per Match - Home Goals Conceded per Match"

- Positive value: The team concedes more goals per match away, indicating stronger home defensive performance.
- Negative value: The team concedes more goals per match at home, indicating stronger away defensive performance.
- Zero: Equal goals-conceded rates at both venues.

Key Findings

Finding| Team| Result
Highest home goals per match| Corinthians| 1.95
Highest away goals per match| Flamengo RJ| 1.63
Best home defensive record| Fortaleza| 0.42
Largest home attacking advantage| Corinthians| +1.06
Largest home defensive advantage| Fortaleza| +1.21

Interpretation

- Corinthians recorded the highest home scoring rate and the largest positive attacking gap.
- Flamengo RJ recorded the highest away scoring rate, at 1.63 goals per match.
- Fortaleza had the strongest home defensive record, conceding just 0.42 goals per home match.
- Fortaleza also recorded the largest positive defensive gap, indicating a substantial difference between its home and away defensive performances.

Power BI Dashboard

An interactive Power BI dashboard was developed to present the home and away performance analysis of the 20 teams.

Dashboard Visualisations

1. Home vs Away Goals Scored per Match: Compares each team's attacking output at home and away.
2. Home vs Away Goals Conceded per Match: Compares defensive performance across both venues.
3. Home/Away Attacking Gap: Highlights differences in goals scored per match between home and away fixtures.
4. Home/Away Defensive Gap: Highlights differences in goals conceded per match between home and away fixtures.

Key Performance Indicators (KPIs)

Three KPI cards provide additional summary information:

- Total number of teams analysed.
- Highest home goals-per-match figure and the corresponding team.
- Highest away goals-per-match figure and the corresponding team.

Interactive Features

A team-selection dropdown slicer allows users to select individual teams and dynamically filter all four charts and the three KPI cards.

The dashboard uses distinct colours to differentiate home and away performance and to distinguish attacking from defensive comparisons.

Project Limitations

1. Match-level data: The analysis focuses on team performance rather than individual player contributions.
2. Limited performance indicators: The dataset does not provide expected goals (xG), possession, shots, passing accuracy or other advanced performance statistics.
3. Descriptive analysis: The project identifies performance patterns and differences but does not establish the underlying causes of those differences.
4. Single-season scope: The analysis covers only the 2024 Brazil Serie B season, so it does not establish long-term performance trends.

These limitations provide opportunities for future analysis using more detailed datasets.

Project Structure

Brazil_Serie_B_2024_Football_Analytics/
│
├── SQL/
│   └── brazil_serie_b_2024_analysis.sql
│
├── PowerBI/
│   └── Brazil_Serie_B_2024_Performance.pbix
│
├── Images/
│   └── Dashboard screenshots
│
└── README.md

Conclusion

This project demonstrates the application of SQL and Power BI in football data analysis. It combines database querying, performance metric development and interactive visualisation to explore differences in team performance across home and away matches in the 2024 Brazil Serie B season.
