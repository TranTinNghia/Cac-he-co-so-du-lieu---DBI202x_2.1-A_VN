-- Lấy ra tên của những người đọc có đọc báo trong năm 2022.

SELECT DISTINCT  V_A.Viewer_ID,
                (SELECT Full_Name FROM VIEWER AS V WHERE V_A.Viewer_ID = V.Viewer_ID) AS Viewer_Name
FROM VIEWER_ARTICLE AS V_A
WHERE Reading_Date BETWEEN '2022-01-01' AND '2022-12-31'

-- Lấy ra tên chủ đề có nhiều bài báo nhất.

SELECT  CATEGORY.Category_Name
FROM
    (SELECT ROW_NUMBER() OVER(ORDER BY Number_Of_Article DESC) AS Number_Order,
            *
    FROM
        (SELECT Category_ID,
                COUNT(Article_ID) AS Number_Of_Article
        FROM ARTICLE
        GROUP BY Category_ID
        ) AS TEMP1
    ) AS TEMP2
LEFT JOIN CATEGORY ON TEMP2.Category_ID = CATEGORY.Category_ID
WHERE Number_Order = 1
