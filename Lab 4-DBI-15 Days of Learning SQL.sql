WITH    TEMP1 AS (
            SELECT DISTINCT HACKER_ID, SUBMISSION_DATE
            FROM SUBMISSIONS
),      TEMP2 AS (
            SELECT  HACKER_ID,
                    SUBMISSION_DATE,
                    COUNT(*) OVER(PARTITION BY HACKER_ID ORDER BY SUBMISSION_DATE
                    ROWS UNBOUNDED PRECEDING) AS COUNT_COLUMN
            FROM TEMP1
),      TEMP3 AS (
            SELECT *
            FROM TEMP2
            WHERE DAY(SUBMISSION_DATE) = COUNT_COLUMN
),      TEMP4 AS (
            SELECT   TEMP3.SUBMISSION_DATE,
                     COUNT(*) AS COUNT_COLUMN
            FROM TEMP3
            GROUP BY TEMP3.SUBMISSION_DATE
),      TEMP5 AS (
            SELECT   SUBMISSIONS.HACKER_ID,
                     SUBMISSIONS.SUBMISSION_DATE,
                     COUNT(*) COUNT_COLUMN
            FROM SUBMISSIONS
            GROUP BY SUBMISSIONS.HACKER_ID, SUBMISSIONS.SUBMISSION_DATE
),      TEMP6 AS (
            SELECT DISTINCT SUBMISSION_DATE,
                            FIRST_VALUE(HACKER_ID) OVER(PARTITION BY SUBMISSION_DATE ORDER BY COUNT_COLUMN DESC, HACKER_ID) AS FIRST_VALUE_COLUMN
            FROM TEMP5
),      TEMP7 AS (
            SELECT   TEMP4.SUBMISSION_DATE,
                     COUNT_COLUMN,
                     FIRST_VALUE_COLUMN,
                     NAME
            FROM TEMP4
            INNER JOIN TEMP6 ON TEMP4.SUBMISSION_DATE = TEMP6.SUBMISSION_DATE
            INNER JOIN HACKERS ON HACKERS.HACKER_ID = TEMP6.FIRST_VALUE_COLUMN
)

SELECT  SUBMISSION_DATE,
        COUNT_COLUMN,
        FIRST_VALUE_COLUMN,
        NAME
FROM TEMP7
ORDER BY SUBMISSION_DATE
