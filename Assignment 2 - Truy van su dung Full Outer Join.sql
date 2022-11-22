-- Lấy ra tên các tác giả chưa viết bài báo nào.

SELECT Full_Name AS Ten_Tac_Gia
FROM ARTICLE
FULL JOIN REPORTER ON ARTICLE.Author = REPORTER.Reporter_ID
WHERE Article_ID IS NULL

