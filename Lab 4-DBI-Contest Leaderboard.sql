WITH TEMP1 AS (
    SELECT HACKER_ID, CHALLENGE_ID, MAX(SCORE) AS MAX_SCORE
    FROM SUBMISSIONS
    GROUP BY HACKER_ID, CHALLENGE_ID
), TEMP2 AS (
    SELECT HACKER_ID, SUM(MAX_SCORE) AS SUM_SCORE
    FROM TEMP1
    GROUP BY HACKER_ID
), TEMP3 AS (
    SELECT TEMP2.HACKER_ID, HACKERS.NAME, SUM_SCORE
    FROM TEMP2
    INNER JOIN HACKERS
    ON TEMP2.HACKER_ID = HACKERS.HACKER_ID
)

SELECT *
FROM TEMP3
WHERE SUM_SCORE != 0
ORDER BY 3 DESC, 1
