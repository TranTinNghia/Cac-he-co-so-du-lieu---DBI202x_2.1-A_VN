-- Sử dụng kết quả trả về của Function Article_ID_Not_Approved đã tạo.
-- Lấy ra thông tin tên bài báo, ngày tạo bài báo.
-- và tên người duyệt bài của các bài báo chưa được phê duyệt như kết quả của hàm Function Article_ID_Not_Approved.

WITH FUNCTION_3_ARTICLE AS (
    SELECT  Function_3.Article_ID
    FROM ARTICLE
    CROSS APPLY dbo.Article_ID_Not_Approved('R002') AS Function_3
)

SELECT  DISTINCT A.Article_Name,
        A.Creating_Date,
        E.Full_Name AS Approver_Name
FROM FUNCTION_3_ARTICLE AS F3_A
INNER JOIN ARTICLE AS A ON F3_A.Article_ID = A.Article_ID
INNER JOIN EDITOR AS E ON A.Approver = E.Editor_ID
