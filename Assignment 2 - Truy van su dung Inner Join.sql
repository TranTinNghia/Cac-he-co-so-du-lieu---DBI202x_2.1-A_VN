-- Lấy ra tên bài báo, tên tác giả và tên chủ đề của các bài báo có comment.

SELECT  A.Article_Name AS Ten_Bai_Bao,
        R.Full_Name AS Ten_Tac_Gia,
        C.Category_Name AS Ten_Chu_De
FROM VIEWER_ARTICLE AS V_A
INNER JOIN ARTICLE AS A ON A.Article_ID = V_A.Article_ID
INNER JOIN REPORTER AS R ON R.Reporter_ID = A.Author
INNER JOIN CATEGORY AS C ON C.Category_ID = A.Category_ID
WHERE V_A.Commenting_Date IS NOT NULL
