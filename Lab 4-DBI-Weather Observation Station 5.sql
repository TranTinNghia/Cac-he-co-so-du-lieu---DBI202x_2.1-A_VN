WITH TEMP1 AS (
        SELECT CITY, LEN(CITY) AS LEN_CITY
        FROM STATION
),   TEMP2 AS (
        SELECT DENSE_RANK() OVER(PARTITION BY LEN_CITY ORDER BY CITY) AS DENSE_RANK, *
        FROM TEMP1
),   TEMP3 AS (
        SELECT  *,
                (CASE   WHEN    (DENSE_RANK = (SELECT MIN(DENSE_RANK) FROM TEMP2)
                                AND LEN_CITY = (SELECT MIN(LEN_CITY) FROM TEMP1)) THEN 'MIN'
                        WHEN    (DENSE_RANK = (SELECT MIN(DENSE_RANK) FROM TEMP2)
                                AND LEN_CITY = (SELECT MAX(LEN_CITY) FROM TEMP1)) THEN 'MAX'
                        ELSE    NULL
                        END
                ) AS FLAG
        FROM TEMP2
)
SELECT CITY, LEN_CITY
FROM TEMP3
WHERE FLAG IS NOT NULL
