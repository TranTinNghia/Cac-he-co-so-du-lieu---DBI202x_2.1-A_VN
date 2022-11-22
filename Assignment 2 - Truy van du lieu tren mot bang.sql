-- Lấy ra tất cả thông tin của bài báo mới nhất xuất hiện trên trang web.
SELECT *
FROM ARTICLE
WHERE Updating_Date = (SELECT MAX(Updating_Date) AS MAX_Updating_Date FROM ARTICLE)
