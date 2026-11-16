# Brazil Serie B 2024 – Football Analytics Project

## Project Overview

This project analyses the 2024 Brazil Serie B football season using SQL and Power BI, with a focus on comparing team performance in home and away matches.

The analysis examines goals scored, goals conceded, and differences in attacking and defensive performance across both venues to identify patterns, strengths and weaknesses among the 20 participating teams.

## Dataset and Scope

- Competition: Brazil Serie B
- Season: 2024
- Number of Teams: 20
- Number of Matches: 380
- Matches per Team: 19 home and 19 away matches
- Data Source: Football-Data.co.uk

The dataset contains match-level football statistics used to investigate team performance across home and away fixtures.

## Tools and Technologies

- **MySQL Workbench 8.0.46:** Data querying, aggregation and analysis.
- **Microsoft Power BI Desktop:** Data visualization and interactive dashboard development.

## SQL Analysis and Methodology

SQL was used to transform match-level data into team-level performance indicators.

The analysis included:

- Total matches and participating teams.
- Home and away goals scored and conceded.
- Home and away performance comparisons.
- Team rankings and performance differences.
- Goals scored and conceded per match.
- Custom attacking and defensive performance indicators.

### SQL techniques used included:

"SELECT", "WHERE", "GROUP BY", "ORDER BY", "SUM()", "COUNT()", "ROUND()", "CASE", subqueries, "UNION ALL", "ABS()" and "CREATE VIEW".

A final SQL view named "v_team_venue_2024" was created to provide the team-level metrics used in the Power BI dashboard.

## Custom Performance Indicators

Two indicators were developed to compare home and away performance.

### 1. Home/Away Attacking Gap

### Formula:

Home Goals Scored per Match − Away Goals Scored per Match

- A positive value indicates that a team scores more goals per match at home.
- A negative value indicates stronger scoring performance away from home.
- A value close to zero indicates similar attacking output across both venues.

### 2. Home/Away Defensive Gap

### Formula:

Away Goals Conceded per Match − Home Goals Conceded per Match

- A positive value indicates that a team concedes more goals away from home, suggesting stronger home defensive performance.
- A negative value indicates that a team concedes fewer goals away from home.
- A value of zero indicates equal goals conceded per match at both venues.

## Key Findings

| Performance Indicator | Team | Result |
|---|---|---:|
| Highest Home Goals per Match | Corinthians | 1.95 |
| Highest Away Goals per Match | Flamengo RJ | 1.63 |
| Best Home Defence | Fortaleza | 0.42 |
| Largest Attacking Gap | Corinthians | +1.06 |
| Largest Defensive Gap | Fortaleza | +1.21 |

### Interpretation

- Corinthians recorded the highest home scoring rate, averaging 1.95 goals per match.
- Flamengo RJ had the highest away scoring rate, averaging 1.63 goals per match.
- Fortaleza had the strongest home defensive record, conceding only 0.42 goals per home match.
- Corinthians recorded the largest attacking gap, indicating a substantial difference between their home and away scoring rates.
- Fortaleza recorded the largest defensive gap, showing a considerable difference between goals conceded at home and away.

These findings highlight differences in how teams performed across home and away fixtures during the season.

## Power BI Dashboard

The Power BI dashboard presents the results of the SQL analysis through four main visualisations:

1. Home vs Away Goals Scored per Match.
2. Home vs Away Goals Conceded per Match.
3. Home/Away Attacking Gap.
4. Home/Away Defensive Gap.

### Key Performance Indicators

The dashboard also includes three KPI cards:

- Total Teams Analysed: 20.
- Highest Home Goals per Match: 1.95.
- Highest Away Goals per Match: 1.63.

The KPI cards identify the teams responsible for the highest home and away scoring rates.

### Interactive Feature

A team dropdown slicer allows users to select individual teams and examine their home and away performance across all four visualisations and the KPI cards.

## Project Limitations

The analysis is based on match-level statistics available in the Football-Data.co.uk dataset.

It does not include:

- Player-level performance statistics.
- Expected Goals (xG).
- Possession statistics.
- Shots and passing data.

Consequently, the project focuses on team-level scoring and defensive performance rather than individual player contributions or broader tactical analysis.

## Project Structure

```text
Brazil_Serie_B_2024_Football_Analytics/
│
├── SQL/
│   └── brazil_serie_b_2024_analysis.sql
│
├── PowerBI/
│   └── Brazil_Serie_B_2024_Performance.pbix
│
├── Images/
│   └── Dashboard screenshot(s)
│
└── README.md
```

## Conclusion

This project demonstrates the use of SQL for football data analysis and Power BI for communicating analytical findings through an interactive dashboard.

By comparing home and away goals scored and conceded, the project identifies differences in team performance and highlights the importance of venue when evaluating football teams.

It also demonstrates practical skills in data querying, aggregation, analytical indicator development, data visualisation and football performance analysis.
