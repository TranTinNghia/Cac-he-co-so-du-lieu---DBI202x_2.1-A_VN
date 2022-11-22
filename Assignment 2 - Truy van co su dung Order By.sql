-- Lấy ra tất cả các Mã phóng viên và xem mỗi phóng viên đã viết được bao nhiêu bài báo.

SELECT  R.Reporter_ID,
        COUNT(A.Article_ID) AS Number_Of_Article
FROM REPORTER AS R
LEFT JOIN ARTICLE AS A
ON A.Author = R.Reporter_ID
GROUP BY R.Reporter_ID
ORDER BY 2 DESC
