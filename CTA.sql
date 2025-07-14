CREATE TABLE L_STATION(
	station_id int,
	station_name varchar(200),
	date date,
	daytype varchar(20),
	rides int
	);
CREATE TABLE COLOR_STATION(
	STOP_ID int,
	DIRECTION_ID varchar(10),
	STOP_NAME varchar(200),
	STATION_NAME varchar(200),
	STATION_DESCRIPTION varchar(500),
	MAP_ID int,
	ada Boolean,
	red Boolean,
	blue Boolean,
	Green Boolean,
	Brown Boolean,
	Purple Boolean,
	Purple_Express Boolean,
	Yellow Boolean,
	Pink Boolean,
	Orange Boolean,
	Location varchar(200)
)
-- Base Table Creation 
SELECT *
FROM L_STATION

-- Aggregation of ridership 
SELECT
	station_name,
	ROUND(AVG(rides),0) as avg_ridership
FROM L_STATION
GROUP BY station_name
ORDER BY avg_ridership DESC
LIMIT 5
/* Notes:

Low Top 5 :
 Homan : 1
 Kostner : 315
 King Drive : 478
 Oakton-Skokie : 566
 Halsted/63rd : 571 

Top 5:
 Lake/State: 12,638
 Clark/Lake: 12,373
 Chicago/State :11,379
 Belmont-North Main: 9,321
 Fullerton: 9,196
 
*/

SELECT
	station_name,
	SUM(rides) as sum_ridership
FROM L_STATION
GROUP BY station_name
ORDER BY sum_ridership 
LIMIT 5


/* Notes:

Low Top 5 :
 Homan : 27
 Kostner : 111,200
 King Drive : 2,636,850
 Oakton-Skokie : 2,758,312
 Halsted/63rd : 4,001,400

Top 5:
 Lake/State: 110,807,420
 Clark/Lake: 108,471,050
 Chicago/State :99,751,808
 Belmont-North Main: 81,706,559
 Fullerton: 80,624,980
 
*/

SELECT 
	EXTRACT(YEAR FROM date) as date_year, 
	ROUND(AVG(rides),0) as avg_ridership
FROM L_STATION
GROUP BY date_year
ORDER BY date_year DESC

SELECT 
	EXTRACT(MONTH FROM date) as date_month, 
	ROUND(AVG(rides),0) as avg_ridership
FROM L_STATION
GROUP BY date_month
ORDER BY date_month 

---

SELECT *
FROM color_station


CREATE TABLE JOIN_L AS
SELECT 
	L.station_id,
	L.station_name,
	L.date,
	L.daytype,
	L.rides,
	C.red,
	C.blue,
	C.green,
	C.brown,
	C.purple,
	C.purple_express,
	C.yellow,
	C.pink,
	C.orange
FROM L_STATION as L
LEFT JOIN COLOR_STATION as C
ON L.station_id = C.map_id

SELECT *
FROM JOIN_L

CREATE TABLE STATION_TABLE AS 
SELECT l.station_id,
	station_name,
	station_color,
	date,
	daytype,
	rides
from join_L as L
cross join lateral (values(station_id, 'red', red),
	(station_id, 'blue', blue), 
	(station_id, 'green', green),
	(station_id, 'brown', brown),
	(station_id, 'purple', purple),
	(station_id, 'purple_express', purple_express),
	(station_id, 'yellow', yellow),
	(station_id, 'pink', pink),
	(station_id, 'orange', orange)
	
	) x(station_id, station_color, val)
where x.val= true 

SELECT 
	station_color,
	ROUND(AVG(rides),0) as avg_rides
FROM STATION_TABLE
GROUP BY station_color
ORDER BY avg_rides DESC

CREATE TABLE Station_rider_date AS
SELECT *,
	EXTRACT(dow FROM date) AS day_of_week,
	EXTRACT(year FROM date) AS year,
	EXTRACT(month FROM date) AS month,
	EXTRACT(day FROM date) AS day
FROM STATION_TABLE


SELECT *
FROM Station_rider_date

SELECT
 station_color,
 year,
 ROUND(AVG(rides),0) as avg_rides
FROM Station_rider_date
GROUP BY station_color,year


-- Template for Notes
/* Notes:

*/

