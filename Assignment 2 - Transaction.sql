-- Tạo Transaction thực hiện 2 công việc:
-- 1. Thêm dữ liệu trong bảng VIEWER_ARTICLE cho Article_ID A021 với giá trị lần lượt các cột là: 'V014','A021','2021-08-24 15:34:19',NULL,NULL.
-- 2. Kiểm tra lượng truy cập của Article_ID A021 trong bảng ARTICLE là bao nhiêu.

BEGIN TRANSACTION Transaction_VIEWER_ARTICLE

INSERT INTO VIEWER_ARTICLE (Viewer_ID,Article_ID,Reading_Date,Commenting_Date,Comment_Content)
VALUES  ('V014','A021','2021-08-24 15:34:19',NULL,NULL)

SELECT Access_Number
FROM ARTICLE
WHERE Article_ID = 'A021'

COMMIT TRANSACTION Transaction_VIEWER_ARTICLE


