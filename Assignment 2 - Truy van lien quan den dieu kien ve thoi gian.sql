-- Lấy ra tên các bài báo đã được phê duyệt, năm bài báo được viết, quý bài báo được viết và kiểm tra thêm điều kiện sau:
-- Nếu Posting_Date = Updating_Date thì hiển thị 'Article has not been revised'.
-- Nếu Posting_Date khác Updating_Date thì hiển thị 'Article has been revised'.

SELECT  Article_Name,
        DATEPART(YEAR, Creating_Date) Article_Year,
        (CASE   WHEN DATEPART(MONTH, Creating_Date) BETWEEN 1 AND 3 THEN 'Quarter 1'
                WHEN DATEPART(MONTH, Creating_Date) BETWEEN 4 AND 6 THEN 'Quarter 2'
                WHEN DATEPART(MONTH, Creating_Date) BETWEEN 7 AND 9 THEN 'Quarter 3'
                ELSE 'Quarter 4' END) AS Article_Quarter,
        (CASE   WHEN Posting_Date = Updating_Date THEN 'Article has not been revised'
                ELSE 'Article has been revised' END) AS Check_Article_Revised
FROM    ARTICLE
WHERE   [Status] = 'Approved'
ORDER BY 1
