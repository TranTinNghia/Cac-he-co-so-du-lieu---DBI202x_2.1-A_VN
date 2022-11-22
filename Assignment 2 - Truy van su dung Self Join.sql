-- Lấy ra tên các chủ đề nhỏ và các chủ đề lớn tương ứng. Nếu một chủ đề không có chủ đề lớn, hiển thị chính tên chủ đề đó.

SELECT  C2.Category_Name AS Chu_De,
        (CASE WHEN C2.Parent_ID IS NULL THEN C2.Category_Name ELSE C1.Category_Name END) AS Chu_De_Lon
FROM CATEGORY AS C1
RIGHT JOIN CATEGORY AS C2 ON C1.Category_ID = C2.Parent_ID
