-- Tạo các Index cho các cột Author, Approver, Category_ID cho bảng ARTICLE để rút ngắn thời gian truy vấn trong bảng.

-- Cột Author.
IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_ARTICLE_Author')
DROP INDEX idx_ARTICLE_Author ON ARTICLE

CREATE NONCLUSTERED INDEX idx_ARTICLE_Author
ON ARTICLE(Author)
INCLUDE(Approver,Category_ID,Article_Name,Creating_Date,Posting_Date,Updating_Date,[Status])

SELECT Article_Name, Approver, Category_ID, Creating_Date, Posting_Date, Updating_Date, [Status]
FROM ARTICLE
WHERE Author = 'R002'

-- Cột Approver.
IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_ARTICLE_Approver')
DROP INDEX idx_ARTICLE_Approver ON ARTICLE

CREATE NONCLUSTERED INDEX idx_ARTICLE_Approver
ON ARTICLE(Approver)
INCLUDE(Author,Category_ID,Article_Name,Creating_Date,Posting_Date,Updating_Date,[Status])

SELECT Article_Name, Author, Category_ID, Creating_Date, Posting_Date, Updating_Date, [Status]
FROM ARTICLE
WHERE Approver = 'E009'

-- Cột Category_ID.
IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_ARTICLE_Category_ID')
DROP INDEX idx_ARTICLE_Category_ID ON ARTICLE

CREATE NONCLUSTERED INDEX idx_ARTICLE_Category_ID
ON ARTICLE(Category_ID)
INCLUDE(Author,Approver,Article_Name,Creating_Date,Posting_Date,Updating_Date,[Status])

SELECT Article_Name, Author, Approver, Creating_Date, Posting_Date, Updating_Date, [Status]
FROM ARTICLE
WHERE Category_ID = 'CAT003'
