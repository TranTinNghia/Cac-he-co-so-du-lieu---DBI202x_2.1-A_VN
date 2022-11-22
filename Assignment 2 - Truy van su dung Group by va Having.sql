-- Lấy ra thông tin các chủ đề có nhiều hơn 3 bài báo, thông tin lấy ra bao gồm cả chủ đề lớn tương ứng.

WITH TEMP1 AS (
    SELECT  ARTICLE.Category_ID,
            Category_Name,
            COUNT(Article_ID) AS Article_Number
    FROM ARTICLE
    INNER JOIN CATEGORY ON ARTICLE.Category_ID = CATEGORY.Category_ID
    GROUP BY ARTICLE.Category_ID, Category_Name
    HAVING COUNT(Article_ID) > 3
), TEMP2 AS (
    SELECT  C2.Category_ID,
            C2.Category_Name AS Chu_De,
            (CASE WHEN C2.Parent_ID IS NULL THEN C2.Category_Name ELSE C1.Category_Name END) AS Chu_De_Lon
    FROM CATEGORY AS C1
    RIGHT JOIN CATEGORY AS C2 ON C1.Category_ID = C2.Parent_ID
)

SELECT  TEMP1.Category_Name AS Chu_De,
        TEMP2.Chu_De_Lon
FROM TEMP1
INNER JOIN TEMP2 ON TEMP1.Category_ID = TEMP2.Category_ID


