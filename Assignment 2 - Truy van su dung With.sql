-- Lấy ra tất cả bài báo có lượt view thấp nhất được viết trong năm 2021. Chỉ lấy ra tên bài báo và tên tác giả của các bài báo đó.

WITH MIN_VIEW_ARTICLE AS (
    SELECT *
    FROM ARTICLE
    WHERE   (Access_Number = (SELECT MIN(Access_Number) AS Min_View_Except_0 FROM ARTICLE WHERE Access_Number != 0)) AND
            (Creating_Date BETWEEN '2021-01-01' AND '2021-12-31')
)

SELECT  MVA.Article_Name AS Ten_Bai_Bao,
        R.Full_Name AS Ten_Tac_Gia
FROM MIN_VIEW_ARTICLE AS MVA
INNER JOIN REPORTER AS R ON R.Reporter_ID = MVA.Author

