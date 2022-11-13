﻿SELECT 	CAST(MAX(LAT_N) AS DECIMAL(7,4)) AS GREATEST_LAT_N
FROM 	STATION
WHERE 	LAT_N < 137.2345;