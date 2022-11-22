-- 1. Tạo Trigger kiểm tra Category_ID, Author (Reporter_ID), Approver (Editor_ID) đã tồn tại trong cơ sở dữ liệu chưa.
-- Khi thêm mới bất kỳ dòng nào vào bảng ARTICLE. Trả về lỗi nếu dữ liệu chưa tồn tại.

-- Tạo Trigger:

IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'INSERT_ARTICLE_CHECK_ID')
DROP TRIGGER INSERT_ARTICLE_CHECK_ID
GO

CREATE TRIGGER INSERT_ARTICLE_CHECK_ID ON ARTICLE
AFTER INSERT
AS
BEGIN
    IF NOT EXISTS (SELECT Inserted.Category_ID FROM Inserted INNER JOIN CATEGORY ON Inserted.Category_ID = CATEGORY.Category_ID)
    BEGIN
        PRINT '>>> Category_ID does not exist <<<'
        ROLLBACK TRANSACTION
    END
    ELSE
    IF NOT EXISTS (SELECT Inserted.Author FROM Inserted INNER JOIN REPORTER ON Inserted.Author = REPORTER.Reporter_ID)
    BEGIN
        PRINT '>>> Author does not exist <<<'
        ROLLBACK TRANSACTION
    END
    ELSE
    IF NOT EXISTS (SELECT Inserted.Approver FROM Inserted INNER JOIN EDITOR ON Inserted.Approver = EDITOR.Editor_ID)
    BEGIN
        PRINT '>>> Approver does not exist <<<'
        ROLLBACK TRANSACTION
    END
END
GO

-- Test Trigger:

ALTER TABLE ARTICLE
DROP CONSTRAINT FK_ARTICLE_Category_ID_CATEGORY

ALTER TABLE ARTICLE
DROP CONSTRAINT FK_ARTICLE_Author_REPORTER

ALTER TABLE ARTICLE
DROP CONSTRAINT FK_ARTICLE_Approver_EDITOR

-- Không INSERT được do Category_ID không tồn tại.
INSERT INTO ARTICLE (Article_ID, Category_ID, Author, Approver, Article_Name, Summary, Full_Content, Creating_Date, Posting_Date, Updating_Date, [Status])
VALUES  ('A031','CAT030','R005','E006','WB cong bo ban tin cap nhat tinh hinh vi mo Viet Nam',
        'Ngay 16/11 tai Ha Noi, Ngan hang the gioi (WB) cong bo ban tin cap nhat tinh hinh kinh te vi mo Viet Nam trong thang 10 nam nay',
        'Theo do ghi nhan, tinh hinh san xuat cong nghiep va doanh so ban le trong nuoc da giam sau trong thang 10 do nhu cau trong nuoc va nuoc ngoai chung lai.',
        '2022-11-16 22:18:23','2022-11-17 08:35:27','2022-11-17 08:35:27','Approved')

-- Không INSERT được do Author không tồn tại.
INSERT INTO ARTICLE (Article_ID, Category_ID, Author, Approver, Article_Name, Summary, Full_Content, Creating_Date, Posting_Date, Updating_Date, [Status])
VALUES  ('A031','CAT006','R030','E006','WB cong bo ban tin cap nhat tinh hinh vi mo Viet Nam',
        'Ngay 16/11 tai Ha Noi, Ngan hang the gioi (WB) cong bo ban tin cap nhat tinh hinh kinh te vi mo Viet Nam trong thang 10 nam nay',
        'Theo do ghi nhan, tinh hinh san xuat cong nghiep va doanh so ban le trong nuoc da giam sau trong thang 10 do nhu cau trong nuoc va nuoc ngoai chung lai.',
        '2022-11-16 22:18:23','2022-11-17 08:35:27','2022-11-17 08:35:27','Approved')

-- Không INSERT được do Approver không tồn tại.
INSERT INTO ARTICLE (Article_ID, Category_ID, Author, Approver, Article_Name, Summary, Full_Content, Creating_Date, Posting_Date, Updating_Date, [Status])
VALUES  ('A031','CAT006','R005','E030','WB cong bo ban tin cap nhat tinh hinh vi mo Viet Nam',
        'Ngay 16/11 tai Ha Noi, Ngan hang the gioi (WB) cong bo ban tin cap nhat tinh hinh kinh te vi mo Viet Nam trong thang 10 nam nay',
        'Theo do ghi nhan, tinh hinh san xuat cong nghiep va doanh so ban le trong nuoc da giam sau trong thang 10 do nhu cau trong nuoc va nuoc ngoai chung lai.',
        '2022-11-16 22:18:23','2022-11-17 08:35:27','2022-11-17 08:35:27','Approved')

-- INSERT được.
INSERT INTO ARTICLE (Article_ID, Category_ID, Author, Approver, Article_Name, Summary, Full_Content, Creating_Date, Posting_Date, Updating_Date, [Status])
VALUES  ('A031','CAT006','R005','E006','WB cong bo ban tin cap nhat tinh hinh vi mo Viet Nam',
        'Ngay 16/11 tai Ha Noi, Ngan hang the gioi (WB) cong bo ban tin cap nhat tinh hinh kinh te vi mo Viet Nam trong thang 10 nam nay',
        'Theo do ghi nhan, tinh hinh san xuat cong nghiep va doanh so ban le trong nuoc da giam sau trong thang 10 do nhu cau trong nuoc va nuoc ngoai chung lai.',
        '2022-11-16 22:18:23','2022-11-17 08:35:27','2022-11-17 08:35:27','Approved')

ALTER TABLE ARTICLE WITH NOCHECK
ADD CONSTRAINT FK_ARTICLE_Category_ID_CATEGORY FOREIGN KEY(Category_ID) REFERENCES CATEGORY(Category_ID)

ALTER TABLE ARTICLE WITH NOCHECK
ADD CONSTRAINT FK_ARTICLE_Author_REPORTER FOREIGN KEY(Author) REFERENCES REPORTER(Reporter_ID)

ALTER TABLE ARTICLE WITH NOCHECK
ADD CONSTRAINT FK_ARTICLE_Approver_EDITOR FOREIGN KEY(Approver) REFERENCES EDITOR(Editor_ID)

SELECT *
FROM ARTICLE
GO

-- 2. Tạo Trigger kiểm tra các điều kiện sau:
-- Kiểm tra Viewer_ID đã tồn tại trong cơ sở dữ liệu chưa. Nếu không tồn tại thì báo lỗi.
-- Article_ID đã tồn tại trong cơ sở dữ liệu chưa. Nếu không tồn tại thì báo lỗi.
-- Nếu Article_ID có tồn tại, thì trạng thái phải là "Approved". Nếu là "Not Approved" thì báo lỗi.
-- Kiểm tra ngày Reading_Date trong bảng VIEWER_ARTICLE phải lớn hơn hoặc bằng ngày Posting_Date trong bảng ARTICLE. Nếu không thì báo lỗi.
-- Mỗi khi thêm bất kỳ dòng nào vào bảng VIEWER_ARTICLE.
-- Thoả mãn tất cả các điều kiện trên thì sẽ INSERT được dữ liệu vào bảng VIEWER_ARTICLE.

-- Tạo Trigger:

IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'INSERT_VIEWER_ARTICLE_CHECK_ID_AND_DATE')
DROP TRIGGER INSERT_VIEWER_ARTICLE_CHECK_ID_AND_DATE
GO

CREATE TRIGGER INSERT_VIEWER_ARTICLE_CHECK_ID_AND_DATE ON VIEWER_ARTICLE
AFTER INSERT
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Inserted INNER JOIN VIEWER ON Inserted.Viewer_ID = VIEWER.Viewer_ID)
    BEGIN
        PRINT '>>> Viewer_ID does not exist <<<'
        ROLLBACK TRANSACTION
    END
    ELSE
        IF NOT EXISTS (SELECT Inserted.Article_ID FROM Inserted INNER JOIN ARTICLE ON Inserted.Article_ID = ARTICLE.Article_ID)
        BEGIN
            PRINT '>>> Article_ID does not exist <<<'
            ROLLBACK TRANSACTION
        END
        ELSE
        BEGIN
            IF EXISTS (SELECT ARTICLE.[Status] FROM Inserted INNER JOIN ARTICLE ON Inserted.Article_ID = ARTICLE.Article_ID WHERE [Status] = 'Not Approved')
            BEGIN
                PRINT '>>> Status must not be "Not Approved" <<<'
                ROLLBACK TRANSACTION
            END
        END
    IF EXISTS   (SELECT Inserted.Reading_Date, ARTICLE.Posting_Date
                FROM Inserted INNER JOIN ARTICLE ON Inserted.Article_ID = ARTICLE.Article_ID
                WHERE Inserted.Reading_Date < ARTICLE.Posting_Date)
    BEGIN
        PRINT '>>> Reading Date must be equal or greater than Posting Date <<<'
        ROLLBACK TRANSACTION
    END
END
GO

-- Test Trigger:

ALTER TABLE VIEWER_ARTICLE
DROP CONSTRAINT FK_VIEWER_ARTICLE_Viewer_ID

ALTER TABLE VIEWER_ARTICLE
DROP CONSTRAINT FK_VIEWER_ARTICLE_Article_ID

-- Không INSERT được do Viewer_ID không tồn tại.
INSERT INTO VIEWER_ARTICLE (Viewer_ID, Article_ID, Reading_Date, Commenting_Date, Comment_Content)
VALUES  ('V030','A006','2021-01-14 07:18:55','2021-01-14 07:20:22','Tuyet voi Viet Nam, co gang phat huy.')

-- Không INSERT được do Article_ID không tồn tại.
INSERT INTO VIEWER_ARTICLE (Viewer_ID, Article_ID, Reading_Date, Commenting_Date, Comment_Content)
VALUES  ('V003','A050','2021-01-14 07:18:55','2021-01-14 07:20:22','Tuyet voi Viet Nam, co gang phat huy.')

-- Không INSERT được do trạng thái của Article_ID trong bảng ARTICLE là "Not Approved".
INSERT INTO VIEWER_ARTICLE (Viewer_ID, Article_ID, Reading_Date, Commenting_Date, Comment_Content)
VALUES  ('V003','A004','2021-01-14 07:18:55','2021-01-14 07:20:22','Tuyet voi Viet Nam, co gang phat huy.')

-- Không INSERT được do Reading Date nhỏ hơn Posting_Date.
INSERT INTO VIEWER_ARTICLE (Viewer_ID, Article_ID, Reading_Date, Commenting_Date, Comment_Content)
VALUES  ('V003','A006','2021-01-09 07:18:55','2021-01-14 07:20:22','Tuyet voi Viet Nam, co gang phat huy.')

-- INSERT được.
INSERT INTO VIEWER_ARTICLE (Viewer_ID, Article_ID, Reading_Date, Commenting_Date, Comment_Content)
VALUES  ('V003','A006','2021-01-14 07:18:55','2021-01-14 07:20:22','Tuyet voi Viet Nam, co gang phat huy.')

ALTER TABLE VIEWER_ARTICLE WITH NOCHECK
ADD CONSTRAINT FK_VIEWER_ARTICLE_Viewer_ID FOREIGN KEY(Viewer_ID) REFERENCES VIEWER(Viewer_ID)

ALTER TABLE VIEWER_ARTICLE WITH NOCHECK
ADD CONSTRAINT FK_VIEWER_ARTICLE_Article_ID FOREIGN KEY(Article_ID) REFERENCES ARTICLE(Article_ID)

SELECT *
FROM ARTICLE
GO

SELECT *
FROM VIEWER_ARTICLE
GO

-- 3. Tạo Trigger UPDATE Access_Number trong bảng ARTICLE.
-- Mỗi khi thêm hoặc xoá dòng trong bảng VIEWER_ARTICLE.

-- Tạo Trigger test:
IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'INSERT_DELETE_VIEWER_ARTICLE_UPDATE_ARTICLE_Access_Number')
DROP TRIGGER INSERT_DELETE_VIEWER_ARTICLE_UPDATE_ARTICLE_Access_Number
GO

CREATE TRIGGER INSERT_DELETE_VIEWER_ARTICLE_UPDATE_ARTICLE_Access_Number ON VIEWER_ARTICLE
AFTER INSERT, DELETE
AS
BEGIN
    UPDATE ARTICLE SET Access_Number = Access_Number + (SELECT COUNT(Viewer_ID) FROM Inserted WHERE Inserted.Article_ID = ARTICLE.Article_ID)
    FROM ARTICLE
    INNER JOIN Inserted ON Inserted.Article_ID = ARTICLE.Article_ID

    UPDATE ARTICLE SET Access_Number = Access_Number - (SELECT COUNT(Viewer_ID) FROM Deleted WHERE Deleted.Article_ID = ARTICLE.Article_ID)
    FROM ARTICLE
    INNER JOIN Deleted ON Deleted.Article_ID = ARTICLE.Article_ID
END
GO

-- Test Trigger:

INSERT INTO VIEWER_ARTICLE (Viewer_ID, Article_ID, Reading_Date, Commenting_Date, Comment_Content)
VALUES  ('V003','A006','2021-01-14 07:18:55','2021-01-14 07:20:22','Tuyet voi Viet Nam, co gang phat huy.')

DELETE FROM VIEWER_ARTICLE WHERE Viewer_ID = 'V003' AND Article_ID = 'A006'

SELECT *
FROM ARTICLE

SELECT *
FROM VIEWER_ARTICLE



