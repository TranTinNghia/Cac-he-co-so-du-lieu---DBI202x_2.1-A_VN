SELECT  CAST(SUM(LAT_N) AS DECIMAL(9,4)) AS SUM_LAT_N
FROM 	STATION
WHERE 	LAT_N BETWEEN 38.7880 AND 137.2345;
