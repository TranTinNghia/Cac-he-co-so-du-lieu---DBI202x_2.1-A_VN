-- 1. Tạo FUNCTION, truyền vào một mã bài báo.
-- Trả về tên tác giả bài báo đó.

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'NAME_AUTHOR')
DROP FUNCTION NAME_AUTHOR
GO

CREATE FUNCTION NAME_AUTHOR (@Article_ID NVARCHAR(5))
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Name_Author NVARCHAR(50)
    SELECT  @Name_Author = REPORTER.Full_Name
    FROM ARTICLE
    INNER JOIN REPORTER
    ON ARTICLE.Author = REPORTER.Reporter_ID
    WHERE Article_ID = @Article_ID
    RETURN @Name_Author
END
GO

IF (SELECT dbo.NAME_AUTHOR('A007') AS Ten_Tac_Gia) IS NOT NULL
BEGIN
    SELECT dbo.NAME_AUTHOR('A007') AS Ten_Tac_Gia
END
ELSE
BEGIN
    PRINT '>>> Article does not exist <<<'
END

-- 2. Tạo FUNCTION, truyền vào một năm.
-- Trả về tên bài báo, tên tác giả và tên người duyệt bài của các bài báo có lượng truy cập nhiều nhất của năm đó.

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'NAME_ARTICLE_MAX_Access_Number')
DROP FUNCTION NAME_ARTICLE_MAX_Access_Number
GO

CREATE FUNCTION NAME_ARTICLE_MAX_Access_Number(@Year INT)
RETURNS TABLE
AS RETURN
    (
    SELECT  ARTICLE.Article_Name AS Ten_Bai_Bao,
            REPORTER.Full_Name AS Ten_Tac_Gia,
            EDITOR.Full_Name AS Ten_Nguoi_Duyet_Bai
    FROM    ARTICLE
    INNER JOIN REPORTER ON ARTICLE.Author = REPORTER.Reporter_ID
    INNER JOIN EDITOR ON ARTICLE.Approver = EDITOR.Editor_ID
    WHERE   Access_Number = (SELECT MAX(Access_Number) AS MAX_Access_Number FROM ARTICLE WHERE YEAR(Posting_Date) = @Year) AND
            YEAR(Posting_Date) = @Year
    )
GO

SELECT *
FROM dbo.NAME_ARTICLE_MAX_Access_Number(2022)
GO

-- 3. Tạo FUNCTION, truyền vào một mã tác giả.
-- Trả về mã các bài báo chưa được duyệt mà tác giả đó đã viết.

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'Article_ID_Not_Approved')
DROP FUNCTION Article_ID_Not_Approved
GO

CREATE FUNCTION Article_ID_Not_Approved (@Author NVARCHAR(5))
RETURNS TABLE
AS RETURN
    (SELECT Article_ID
    FROM ARTICLE
    WHERE [Status] = 'Not Approved' AND Author = @Author
    )
GO

SELECT *
FROM dbo.Article_ID_Not_Approved('R002')

