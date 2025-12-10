/* Counts total amount of unique train IDs and total amount of departure recordings during the month */

SELECT 
	COUNT(DISTINCT "Train ID") AS "Unique Train IDs",
	COUNT("Train ID") AS "Total Train Departure Recordings"
FROM NJ_Transit_Departure_Times;



/*Counts which 10 stations had the longest total delays */
SELECT "Next Station", ROUND(SUM("Delay (Minutes)"), 2) AS "Station with Longest Total Delays"
FROM NJ_Transit_Departure_Times
GROUP BY "Next Station"
ORDER BY "Station with Longest Total Delays" DESC
LIMIT 10;



/* Shows the top 20 stations which had the longest average delay */
SELECT 
	"Next Station", 
	ROUND(AVG("Delay (Minutes)"), 2) AS avg_delay,
	line
FROM NJ_Transit_Departure_Times
GROUP BY "Next Station"
ORDER BY avg_delay DESC
LIMIT 20; 


 /* Shows which hours of the day that have the highest average delay */
SELECT 
    CAST(substr("Scheduled Time", instr("Scheduled Time", ' ') + 1, 2) AS INTEGER) AS hour_of_day,
    ROUND(AVG("Delay (Minutes)"), 2) AS avg_delay
FROM NJ_Transit_Departure_Times
WHERE "Scheduled Time" IS NOT NULL
GROUP BY hour_of_day
ORDER BY avg_delay DESC; 



/* Measures how many departures have a delay of more than 1 minute */
SELECT 
    COUNT(CASE WHEN "Delay (Minutes)" > 1 THEN 1 END) AS "Departures w/ delay of over 1 Minute",
    ROUND(
        100.0 * COUNT(CASE WHEN "Delay (Minutes)" > 1 THEN 1 END) / COUNT(*),2) AS "Percent of Delays over 1 Minute"
FROM NJ_Transit_Departure_Times;
