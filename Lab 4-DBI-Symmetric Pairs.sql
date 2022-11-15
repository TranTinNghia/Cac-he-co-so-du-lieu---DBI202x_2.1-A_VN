﻿-- CREATE 3 TABLES (TEMP1, TEMP2, TEMP3), TEMP1 AND TEMP2 HAVE THEIR DATA SAME AS FUNTIONS, TEMP3  FOR JOINING TEMP1 AND TEMP2.
WITH TEMP1 AS (
    SELECT  ROW_NUMBER() OVER(ORDER BY X) AS ROW_NUM_1,
    X AS X1,
    Y AS Y1
    FROM FUNCTIONS
), TEMP2 AS (
    SELECT  ROW_NUMBER() OVER(ORDER BY X) AS ROW_NUM_2,
    X AS X2,
    Y AS Y2
    FROM FUNCTIONS
), TEMP3 AS (
    SELECT *
    FROM TEMP1
    INNER JOIN TEMP2
    ON TEMP1.ROW_NUM_1 != TEMP2.ROW_NUM_2
    AND X1 = Y2 AND X2 = Y1 AND X1 <= Y1
)

SELECT DISTINCT X1, Y1
FROM TEMP3
ORDER BY X1
