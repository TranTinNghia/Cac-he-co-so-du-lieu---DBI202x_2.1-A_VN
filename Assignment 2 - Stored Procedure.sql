-- 1. Tạo Stored Procedure cập nhật lại thông tin cột Access_Number trong bảng ARTICLE theo dữ liệu trong bảng VIEWER_ARTICLE.

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'UPDATE_ARTICLE_Access_Number')
DROP PROCEDURE UPDATE_ARTICLE_Access_Number
GO

CREATE PROCEDURE UPDATE_ARTICLE_Access_Number
AS
BEGIN
    UPDATE ARTICLE SET Access_Number = Number_Of_Viewer
    FROM
        (SELECT Article_ID,
                COUNT(Viewer_ID) AS Number_Of_Viewer
        FROM VIEWER_ARTICLE
        GROUP BY Article_ID) AS TEMP
    WHERE ARTICLE.Article_ID = TEMP.Article_ID AND ARTICLE.Status = 'Approved'
END
GO

EXECUTE Update_ARTICLE_Access_Number
GO

SELECT *
FROM VIEWER_ARTICLE
GO

SELECT *
FROM ARTICLE
GO

-- 2. Tạo một Stored Procedure, với dữ liệu truyền vào là Author (hay Report_ID).
-- Kiểm tra Author đã có trong cơ sở dữ liệu chưa, nếu chưa có thì kết quả bằng 0.
-- Nếu đã có, cho ra kết quả là Author đã viết được bao nhiêu bài báo.

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'COUNT_ArticleID_Author')
DROP PROCEDURE COUNT_ArticleID_Author
GO

CREATE PROCEDURE COUNT_ArticleID_Author
(@Author NVARCHAR(5), @Article_Number INT OUTPUT)
AS
BEGIN
    IF EXISTS (SELECT Reporter_ID FROM REPORTER WHERE Reporter_ID = @Author)
    BEGIN
        IF EXISTS (SELECT Author FROM ARTICLE WHERE Author = @Author GROUP BY Author)
        BEGIN
            SET @Article_Number =
            (SELECT COUNT(Article_ID) AS Article_Number
            FROM ARTICLE
            WHERE Author = @Author
            GROUP BY Author)
        END
        ELSE
        BEGIN
            SET @Article_Number = 0
        END
    END
    ELSE
    BEGIN
        SET @Article_Number = 0
    END
END

-- Có trong cơ sở dữ liệu.
DECLARE @Count_Article_Number_1 INT
EXECUTE COUNT_ArticleID_Author 'R001', @Count_Article_Number_1 OUTPUT
SELECT @Count_Article_Number_1 AS Article_Number
GO

-- Không có trong bảng Article.
DECLARE @Count_Article_Number_2 INT
EXECUTE COUNT_ArticleID_Author 'R011', @Count_Article_Number_2 OUTPUT
SELECT @Count_Article_Number_2 AS Article_Number
GO

-- Không có trong cơ sở dữ liệu.
DECLARE @Count_Article_Number_3 INT
EXECUTE COUNT_ArticleID_Author 'R030', @Count_Article_Number_3 OUTPUT
SELECT @Count_Article_Number_3 AS Article_Number
GO

-- 3. Tạo Stored Procedure, trả về kết quả là số người đọc theo giới tính, mở tài khoản đọc báo vào quý 3 và quý 4 năm 2022.
--  Theo format:
--     Male           Female
--  [Male_Num]     [Female_Num]

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'COUNT_VIEWERS')
DROP PROCEDURE COUNT_VIEWERS
GO

CREATE PROCEDURE COUNT_VIEWERS
AS
BEGIN
    SELECT [Male], [Female]
    FROM
        (SELECT
            Viewer_ID,
            Gender
        FROM VIEWER
        WHERE Joining_Date BETWEEN '2022-07-01' AND '2022-12-31'
        ) AS TEMP
    PIVOT
        (
            COUNT(Viewer_ID)
            FOR Gender IN ([Male],[Female])
        ) AS PIVOT_TEMP
END
GO

EXECUTE COUNT_VIEWERS
GO
