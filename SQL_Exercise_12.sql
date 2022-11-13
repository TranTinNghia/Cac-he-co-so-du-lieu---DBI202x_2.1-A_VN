-- Exercise 12:
-- 1. Tạo Trigger có ràng buộc: Giá bán của một vật tư bất kỳ lớn hơn hoặc bằng giá mua của nó.
-- Khi INSERT một chi tiết hoá đơn mới, hoặc khi UPDATE giá bán.

-- Xem dữ liệu các bảng:
SELECT *
FROM tbl_HoaDon
GO;

SELECT *
FROM tbl_VatTu
GO;

SELECT *
FROM tbl_ChiTietHoaDon
GO;

-- Tạo Trigger:
ALTER TRIGGER tg_check_GiaBan_GiaMua ON tbl_ChiTietHoaDon
AFTER INSERT, UPDATE
AS 
BEGIN
	IF NOT EXISTS (SELECT * FROM Inserted INNER JOIN tbl_HoaDon ON Inserted.MaHD = tbl_HoaDon.MaHD)
	BEGIN
		PRINT 'Ma Hoa don khong ton tai'
		ROLLBACK TRANSACTION
	END
	ELSE 
		IF NOT EXISTS (SELECT * FROM Inserted INNER JOIN tbl_VatTu ON Inserted.MaVT = tbl_VatTu.MaVT)
		BEGIN
			PRINT 'Ma Vat tu khong ton tai'
			ROLLBACK TRANSACTION
		END
	ELSE 
		IF EXISTS (SELECT * FROM Inserted INNER JOIN tbl_VatTu ON Inserted.MaVT = tbl_VatTu.MaVT WHERE Inserted.GiaBan < GiaMua)
		BEGIN 
			PRINT 'Gia ban khong duoc nho hon gia mua'
			ROLLBACK TRANSACTION
		END
	ELSE
		IF EXISTS (SELECT * FROM Inserted INNER JOIN Deleted ON Inserted.MaHD = Deleted.MaHD INNER JOIN tbl_VatTu ON Deleted.MaVT = tbl_VatTu.MaVT WHERE Inserted.GiaBan < tbl_VatTu.GiaMua)
		BEGIN
			PRINT 'Gia ban khong duoc nho hon gia mua'
			ROLLBACK TRANSACTION
		END
END
GO

-- Test Trigger:
-- Xoá Khoá ngoại:
ALTER TABLE tbl_ChiTietHoaDon
DROP CONSTRAINT FK_MaHD_tbl_ChiTietHoaDon

ALTER TABLE tbl_ChiTietHoaDon
DROP CONSTRAINT FK_MaVT_tbl_ChiTietHoaDon

-- Dòng này được thêm vào Bảng ChiTietHoaDon vì Mã Hoá đơn và Mã Vật tư đều tồn tại trong cơ sở dữ liệu.
-- Giá bán bằng giá mua của Vật tư 02, thoả mãn điều kiện.
INSERT INTO tbl_ChiTietHoaDon
VALUES ('HD001','VT02',50,45000)

-- Dòng này không được thêm vào Bảng ChiTietHoaDon vì Mã hoá đơn không tồn tại.
INSERT INTO tbl_ChiTietHoaDon
VALUES ('HD015','VT01',50,56000)

-- Dòng này không được thêm vào Bảng ChiTietHoaDon vì Mã Vật tư không tồn tại.
INSERT INTO tbl_ChiTietHoaDon
VALUES ('HD002','VT12',50,56000)

-- Dòng này không được thêm vào Bảng ChiTietHoaDon vì Giá Bán nhỏ hơn Giá Mua của Vật tư 01.
INSERT INTO tbl_ChiTietHoaDon
VALUES ('HD002','VT01',50,48000)

-- Dòng này không sửa được Giá bán của Vật tư 01 vì Giá Bán nhỏ hơn Giá Mua.
UPDATE tbl_ChiTietHoaDon SET GiaBan = 45000 WHERE MaHD = 'HD001' AND MaVT = 'VT01'

-- Dòng này sửa được Giá bán của Vật tư 01 vì Giá Bán lớn hơn Giá Mua.
UPDATE tbl_ChiTietHoaDon SET GiaBan = 51000 WHERE MaHD = 'HD001' AND MaVT = 'VT01'

-- Thêm lại khoá ngoại sau khi chỉnh sửa:
ALTER TABLE tbl_ChiTietHoaDon WITH NOCHECK
ADD CONSTRAINT FK_MaHD_tbl_ChiTietHoaDon FOREIGN KEY(MaHD) REFERENCES tbl_HoaDon(MaHD)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE tbl_ChiTietHoaDon WITH NOCHECK
ADD CONSTRAINT FK_MaVT_tbl_ChiTietHoaDon FOREIGN KEY(MaVT) REFERENCES tbl_VatTu(MaVT)
ON DELETE CASCADE
ON UPDATE CASCADE

-- Xoá dữ liệu test:
DELETE FROM tbl_ChiTietHoaDon WHERE MaHD = 'HD001' AND MaVT = 'VT02' AND SoLuong = 50 AND GiaBan = 45000

-- 2. Tạo Trigger nhằm thực hiện:
-- Mỗi khi một vật tư được bán ra với một số lượng nào đó, thì thuộc tính SoLuongTon trong bảng Vật tư cần giảm đi tương ứng.

-- Xem dữ liệu các bảng:
SELECT *
FROM tbl_ChiTietHoaDon
GO;

SELECT *
FROM tbl_VatTu
GO;

-- Tạo Trigger:
ALTER TRIGGER tg_update_VatTu_SoLuongTon ON tbl_ChiTietHoaDon
AFTER INSERT
AS
BEGIN
	DECLARE @SoLuongBan AS INT;
	DECLARE @SoLuongTon AS INT;
	SELECT @SoLuongBan = Inserted.SoLuong FROM Inserted;
	SELECT @SoLuongTon = tbl_VatTu.SoLuongTon FROM tbl_VatTu
	INNER JOIN Inserted ON Inserted.MaVT = tbl_VatTu.MaVT;
	IF @SoLuongBan > @SoLuongTon
	BEGIN
		PRINT 'So Luong ton khong du de ban'
		ROLLBACK TRANSACTION;
	END
	ELSE
	BEGIN
		UPDATE tbl_VatTu SET SoLuongTon = SoLuongTon - @SoLuongBan
		FROM tbl_VatTu
		INNER JOIN Inserted ON Inserted.MaVT = tbl_VatTu.MaVT
	END
END	

-- Test Trigger:
-- Xoá Khoá ngoại:
ALTER TABLE tbl_ChiTietHoaDon
DROP CONSTRAINT FK_MaHD_tbl_ChiTietHoaDon

ALTER TABLE tbl_ChiTietHoaDon
DROP CONSTRAINT FK_MaVT_tbl_ChiTietHoaDon

-- Dòng này được thêm vào bảng ChiTietHoaDon, vì trong bảng Vật tư, ban đầu mặt hàng này có SoLuongTon là 50000.
INSERT INTO tbl_ChiTietHoaDon
VALUES ('HD020','VT02',8000,48000)

-- Dòng này không được thêm vào bảng ChiTietHoaDon vì số lượng tồn nhỏ hơn số lượng bán.
INSERT INTO tbl_ChiTietHoaDon
VALUES ('HD020','VT02',45000,48000)

-- Thêm lại khoá ngoại sau khi chỉnh sửa:
ALTER TABLE tbl_ChiTietHoaDon WITH NOCHECK
ADD CONSTRAINT FK_MaHD_tbl_ChiTietHoaDon FOREIGN KEY(MaHD) REFERENCES tbl_HoaDon(MaHD)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE tbl_ChiTietHoaDon WITH NOCHECK
ADD CONSTRAINT FK_MaVT_tbl_ChiTietHoaDon FOREIGN KEY(MaVT) REFERENCES tbl_VatTu(MaVT)
ON DELETE CASCADE
ON UPDATE CASCADE

-- 3. Tạo Trigger đảm bảo giá bán của một sản phẩm bất kỳ chỉ có thể cập nhật tăng, không thể cập nhật giảm.

-- Xem dữ liệu các bảng:
SELECT *
FROM tbl_ChiTietHoaDon
GO;

SELECT *
FROM tbl_VatTu
GO;

-- Tạo Trigger:
ALTER TRIGGER tg_update_GiaBan_OnlyUp_NotDown ON tbl_ChiTietHoaDon
AFTER UPDATE
AS
BEGIN
	IF EXISTS (	SELECT * FROM Inserted AS I INNER JOIN Deleted AS D ON I.MaHD = D.MaHD AND I.MaVT = D.MaVT
				WHERE D.GiaBan > I.GiaBan )
	BEGIN
		PRINT 'Gia ban moi phai lon hon gia ban cu'
		ROLLBACK TRANSACTION
	END
END

-- Test Trigger:
-- Xoá Khoá ngoại:
ALTER TABLE tbl_ChiTietHoaDon
DROP CONSTRAINT FK_MaHD_tbl_ChiTietHoaDon

ALTER TABLE tbl_ChiTietHoaDon
DROP CONSTRAINT FK_MaVT_tbl_ChiTietHoaDon

-- Dòng này được thực thi vì Giá bán mới cao hơn Giá bán cũ.
UPDATE tbl_ChiTietHoaDon SET GiaBan = 36000
WHERE MaHD = 'HD001' AND MaVT = 'VT05'

-- Dòng này không được thực thi vì Giá bán mới nhỏ hơn Giá bán cũ.
UPDATE tbl_ChiTietHoaDon SET GiaBan = 30000
WHERE MaHD = 'HD001' AND MaVT = 'VT05'

-- Thêm lại khoá ngoại sau khi chỉnh sửa:
ALTER TABLE tbl_ChiTietHoaDon WITH NOCHECK
ADD CONSTRAINT FK_MaHD_tbl_ChiTietHoaDon FOREIGN KEY(MaHD) REFERENCES tbl_HoaDon(MaHD)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE tbl_ChiTietHoaDon WITH NOCHECK
ADD CONSTRAINT FK_MaVT_tbl_ChiTietHoaDon FOREIGN KEY(MaVT) REFERENCES tbl_VatTu(MaVT)
ON DELETE CASCADE
ON UPDATE CASCADE
GO

-- 4. Tạo Trigger để mỗi khi có sự thay đổi nào đó trong bảng ChiTietHoaDon 
-- thì thuộc tính TongGiaTri trong bảng HoaDon.
-- Xem dữ liệu các bảng:
SELECT *
FROM tbl_ChiTietHoaDon
GO;

SELECT *
FROM tbl_HoaDon
GO;

-- Tạo Trigger:
ALTER TRIGGER Cong_tbl_HoaDon_TongGiatri ON tbl_ChiTietHoaDon
AFTER INSERT
AS
BEGIN
	UPDATE tbl_HoaDon 
	SET TongGiatri = TongGiatri + (SELECT GiaBan FROM Inserted WHERE Inserted.MaHD = tbl_HoaDon.MaHD)
	FROM tbl_HoaDon
	INNER JOIN Inserted ON Inserted.MaHD = tbl_HoaDon.MaHD
END
GO

ALTER TRIGGER Tru_tbl_HoaDon_TongGiatri ON tbl_ChiTietHoaDon
AFTER DELETE
AS
BEGIN
	UPDATE tbl_HoaDon
	SET TongGiatri = TongGiatri - (SELECT GiaBan FROM Deleted WHERE Deleted.MaHD = tbl_HoaDon.MaHD)
	FROM tbl_HoaDon
	INNER JOIN Deleted ON Deleted.MaHD = tbl_HoaDon.MaHD
END
GO

-- Test Trigger:
-- Xoá Khoá ngoại:
ALTER TABLE tbl_ChiTietHoaDon
DROP CONSTRAINT FK_MaHD_tbl_ChiTietHoaDon

ALTER TABLE tbl_ChiTietHoaDon
DROP CONSTRAINT FK_MaVT_tbl_ChiTietHoaDon

-- Dòng này được thêm vào bảng ChiTietHoaDon vì thoả mãn hoàn toàn các Trigger ở các câu trên.
-- Sau khi Insert, Tổng giá trị của HD002 trong bảng HoaDon là 30.150.
INSERT INTO tbl_ChiTietHoaDon
VALUES ('HD002','VT05',10,30000)

-- Sau khi Delete, Tổng giá trị của HD002 trong bảng HoaDon quay trở lại 150.
DELETE FROM tbl_ChiTietHoaDon
WHERE MaHD = 'HD002' AND MaVT = 'VT05'

-- Thêm lại khoá ngoại sau khi chỉnh sửa:
ALTER TABLE tbl_ChiTietHoaDon WITH NOCHECK
ADD CONSTRAINT FK_MaHD_tbl_ChiTietHoaDon FOREIGN KEY(MaHD) REFERENCES tbl_HoaDon(MaHD)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE tbl_ChiTietHoaDon WITH NOCHECK
ADD CONSTRAINT FK_MaVT_tbl_ChiTietHoaDon FOREIGN KEY(MaVT) REFERENCES tbl_VatTu(MaVT)
ON DELETE CASCADE
ON UPDATE CASCADE
GO