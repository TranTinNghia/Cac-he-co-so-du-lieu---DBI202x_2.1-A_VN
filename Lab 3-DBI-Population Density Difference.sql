﻿SELECT DIFFERENCE
FROM
    (SELECT MAX(POPULATION) AS MAX_POPULATION,
            MIN(POPULATION) AS MIN_POPULATION,
            (MAX(POPULATION) - MIN(POPULATION)) AS DIFFERENCE
    FROM CITY) AS TBL_TEMP;