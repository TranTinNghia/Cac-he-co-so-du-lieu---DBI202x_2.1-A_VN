SELECT
    (CASE   WHEN GRADE < 8 THEN NULL
            ELSE NAME
            END) AS CHECK_GRADE,
            GRADE,
            MARKS
FROM STUDENTS, GRADES
WHERE MARKS BETWEEN MIN_MARK AND MAX_MARK
ORDER BY GRADE DESC, NAME
