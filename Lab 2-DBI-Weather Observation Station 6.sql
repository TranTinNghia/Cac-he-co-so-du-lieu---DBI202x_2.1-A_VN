﻿SELECT  TOP(1) CITY, LEN(CITY) AS LENGTH
FROM STATION
ORDER BY 2 DESC, 1 ASC;

SELECT  TOP(1) CITY, LEN(CITY) AS LENGTH
FROM STATION
ORDER BY 2, 1 ASC;