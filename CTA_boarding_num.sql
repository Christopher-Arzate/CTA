--CREATE TABLE Ridership_daily_boarding(
	--service_date date,
	--day_type varchar(20),
	--bus int,
	--rail_boardings int,
	--total_rides int
-- );


--Base Table

SELECT *
FROM ridership_daily_boarding 

-- A query that establishes the different times and the percentages of pasengers of the bus and trains


SELECT 
	EXTRACT(YEAR FROM service_date) as service_year, 
	EXTRACT(MONTH FROM service_date) as service_month, 
	EXTRACT(DAY FROM service_date) as service_day,
	bus,
	rail_boardings,
	total_rides,
	ROUND(100.0 * bus / total_rides,2) AS bus_percentage,
	ROUND(100.0 * rail_boardings / total_rides,2) AS rail_percentage
FROM ridership_daily_boarding
ORDER BY service_date



-- Query that gives the top five years of people boarding on trains
SELECT 
	EXTRACT(YEAR FROM service_date) as service_year, 
	ROUND(AVG(rail_boardings),0) as avg_train_ride
FROM ridership_daily_boarding
GROUP BY service_year
ORDER BY avg_train_ride DESC
LIMIT 5

/* Notes:
	2015,2014,2016,2012, and 2017 were on avg the most boardings for CTA Trains 
	Unsure of the reason this may require a closer look into each years specifics chart 
*/

-- Query that gives the Lower five years of people boarding on trains
SELECT 
	EXTRACT(YEAR FROM service_date) as service_year, 
	ROUND(AVG(rail_boardings),0) as avg_train_ride
FROM ridership_daily_boarding
GROUP BY service_year
ORDER BY avg_train_ride
LIMIT 5

/* Notes:
	Covid-19 and the damage it's done for people to ride in public Transport 
*/


--Query for the top five months of people boarding on trains

SELECT 
	EXTRACT(MONTH FROM service_date) as service_month, 
	ROUND(AVG(rail_boardings),0) as avg_train_ride
FROM ridership_daily_boarding
GROUP BY service_month
ORDER BY avg_train_ride DESC
LIMIT 5

/* Notes:
 October,September,June,August, and July are the biggest months of CTA Train Rides. 
 This can be due to the warmer weathers of summmer in the month of June,July and August.
 As for September and August this can be from the start of school <- I wouuld like to know demmographics of CTA Riders 
*/


--Query for the Lower five months of people boarding on trains

SELECT 
	EXTRACT(MONTH FROM service_date) as service_month, 
	ROUND(AVG(rail_boardings),0) as avg_train_ride
FROM ridership_daily_boarding
GROUP BY service_month
ORDER BY avg_train_ride 
LIMIT 6

/* Notes:
 December, January, February, March and May are the gave the least amount of people boarding the CTA
 This can be due to the colder weathers of winter in the month of December- February.
 May is an oddity for being here but has avg value close to April so it can be the colder weather being the main factor there isn't many riding the trains 
*/

-- Query for the busiet day of people boarding on trains 
SELECT 
	EXTRACT(DAY FROM service_date) as service_day, 
	ROUND(AVG(rail_boardings),0) as avg_train_ride
FROM ridership_daily_boarding
GROUP BY service_day
ORDER BY avg_train_ride DESC
LIMIT 5

/* Notes:
	The 13,12,9,14,10 of each month provide the most train ride boarding  (perhpas due to events, work?)
*/

-- Query for the busiet day of people boarding on trains 
SELECT 
	EXTRACT(DAY FROM service_date) as service_day, 
	ROUND(AVG(rail_boardings),0) as avg_train_ride
FROM ridership_daily_boarding
GROUP BY service_day
ORDER BY avg_train_ride 
LIMIT 5

/* Notes:
	The 25,24,26,27 and 1 of each month recieves the least amount of people boarding (my guess is holiday december plays a role here)
*/
-- Query for the total grouped by the months
SELECT 
	service_date,
	ROUND(100.0 * bus / total_rides,2) AS bus_percentage,
	ROUND(100.0 * rail_boardings / total_rides,2) AS rail_percentage
FROM ridership_daily_boarding
ORDER BY service_date

--Query that sums the total boardings by day_type 
SELECT
	day_type,
	SUM(total_rides) AS sum_days
FROM ridership_daily_boarding
GROUP BY day_type
ORDER BY sum_days DESC

/* Notes:
	Weekday has the most riders in the last 23 years with 8.7 billion people who used the CTA
	Saturday followed with a 1.1 billion people
	Sunday and the holidays were the least with 882 million people 
*/


--A query which averages the total boardings by day_type 
SELECT
	day_type,
	ROUND(AVG(total_rides),0) AS avg_days
FROM ridership_daily_boarding
GROUP BY day_type
ORDER BY avg_days DESC

/* Notes:
	About 1.4 million people ride the cta on the weekdays
	About 888 thousand people ride the cta on Saturdays 
	About 631 thoudansds people ride the cta on Sundays 
*/

-- A query to see which days of the month are the most popular 
SELECT 
	service_date,
	EXTRACT(dow FROM service_date) AS day_of_week
FROM ridership_daily_boarding
ORDER BY service_date

-- A query which takes the average of each of the total boardings based on their day of the week 
WITH days_service(service_date, day_of_week) AS(
	SELECT 
		service_date,
		EXTRACT(dow FROM service_date) AS day_of_week
	FROM ridership_daily_boarding
	ORDER BY service_date
)

SELECT 
	D.day_of_week AS days,
	ROUND(AVG(R.total_rides),0) AS avg_rides
FROM ridership_daily_boarding AS R 
LEFT JOIN days_service AS D
ON D.service_date = R.service_date
GROUP BY days
ORDER BY days
/* Notes:

0=Sunday 639,382
1=Monday 1,336,410
2=Tuesday 1,434,323
3=Wednesday 1,433,661
4=Thursaday 1,417,971
5=Friday 1,413,898
6=Saturday 886,997

Weekends have the least amount of people on the CTA in the last 23 years
The Weekdays have the most people who use the CTA 
*/


-- A query which takes the average of each of the total boardings based on their day of the week 
WITH days_service(service_date, day_of_week) AS(
	SELECT 
		service_date,
		EXTRACT(dow FROM service_date) AS day_of_week
	FROM ridership_daily_boarding
	ORDER BY service_date
)
SELECT 
	D.day_of_week AS days,
	ROUND(SUM(R.total_rides),0) AS sum_rides
FROM ridership_daily_boarding AS R 
LEFT JOIN days_service AS D
ON D.service_date = R.service_date
GROUP BY days
ORDER BY days
/* Notes:

0=Sunday 800 Million
1=Monday 1.67 Billion
2=Tuesday 1.79 Billion
3=Wednesday 1.79 Billion
4=Thursaday 1.77 Billion 
5=Friday 1.77 Billion
6=Saturday 1.11 Billion

Weekends have the least amount of people on the CTA in the last 23 years
The Weekdays have the most people who use the CTA 
*/


WITH year_service(service_date, year) AS(
	SELECT 
		service_date,
		EXTRACT(year FROM service_date) AS year
	FROM ridership_daily_boarding
	ORDER BY service_date
)

SELECT 
	Y.year AS years,
	ROUND(AVG(R.total_rides),0) AS sum_rides
FROM ridership_daily_boarding AS R 
LEFT JOIN year_service AS Y
ON Y.service_date = R.service_date
GROUP BY years
ORDER BY years

/* Notes:
Overall there was  steady stream of people using CTA for about 1.29 -1.42 Million people a year
2020 saw a drastic decrease to 529 thousands people due to COVID
However, the number of people using CTA was increasing as we got a better control of the COVID pandemic 
*/

WITH year_service(service_date, year, month) AS(
	SELECT 
		service_date,
		EXTRACT(year FROM service_date) AS year,
		EXTRACT(month FROM service_date) AS month
	FROM ridership_daily_boarding
	ORDER BY service_date
)

SELECT 
	YM.year AS years,
	YM.month AS months,
	ROUND(AVG(R.total_rides),0) AS avg_rides
FROM ridership_daily_boarding AS R 
LEFT JOIN year_service AS YM
ON YM.service_date = R.service_date
GROUP BY years, month
ORDER BY avg_rides

-- Template for Notes
/* Notes:
 October 2012, had the most boardings with 163 million people;October 2008, October 2013 are 2nd and 3rd most
April, May and June 2020 had the least amount of people boarding 270 thousand 292 thousand and 342 thousand people respectivly
*/

-- Template for Notes
/* Notes:

*/

