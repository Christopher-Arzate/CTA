


# Context of the Project
A few weeks ago, I learned how the State Government needed to sign a budget bill so public transportation, such as Metra, CTA, and Pace, could function normally in the state. I gotten curious on how impactful public transportation are for people so I organized a project to answer this question. The data used for this project was from the Chicago Data Portal, finding data tables that contain any information about the trains. 


## Quick Insights
- The red line is the busiest line on average throughout the 24 years of data
- Thursday is the busiest day on average ridership per station, while Sunday has the least amount of ridership
- CTA Ridership has been slowly rising since 2020, but even before 2020, CTA ridership has been decreasing since 2015 (This means there is a hidden issue with the CTA that may have been resolved due to a greater threat, COVID-19)

## Recomendations 
- Identify why the CTA was losing ridership before 2020, to maintain revenue from public transport
- Research why Wednesdays are the busiest days for CTA, while Sunday is the least busiest 

## Tools used
This project required me to learn how to run and manage a PostgreSQL server, and I created and imported CSV files into databases. I utilize SQL to write queries that join tables by station name, allowing me to determine which color line each station is on. Utilize Subqueries to filter datasets and identify the stations with the highest average ridership. I learned how to import data from my SQL database into Power BI and create a custom dashboard that highlights key findings from this project.

This document will have both SQL files used to help explore this data and the tables used for the dashboard. 


## Static Dashboard Image

![image](CTA_Dashboard.png) 

## Files
- **[General SQL Analysis File](https://github.com/Christopher-Arzate/CTA/blob/main/CTA_boarding_num.sql)**: 
- **[Station Color SQL Analysis File](https://github.com/Christopher-Arzate/CTA/blob/main/CTA.sql)**:


