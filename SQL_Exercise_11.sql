-- Exercise 11:
-- 1. Tạo TRANSACTION:
-- Chèn thông tin MaHD, NgayHD, MaKH giá trị (HD020,2019-12-02,KH01). Hoá đơn này bao gồm:
-- VT01, 10 đơn vị, giá bán 55000.
-- VT02, 2 đơn vị, giá bán 47000.

BEGIN TRANSACTION Update_tbl_HoaDon_ChiTietHoaDon
	SELECT *
	FROM tbl_HoaDon

	ALTER TABLE tbl_HoaDon
	ALTER COLUMN TongGiaTri money NULL

	ALTER TABLE tbl_HoaDon
	DROP CONSTRAINT FK_tbl_HoaDon

	INSERT INTO tbl_HoaDon (MaHD, NgayHD, MaKH, TongGiatri)
	VALUES ('HD020','2019-12-02','KH01',NULL)

	ALTER TABLE tbl_HoaDon WITH NOCHECK
	ADD CONSTRAINT FK_tbl_HoaDon FOREIGN KEY(MaKH) REFERENCES tbl_KhachHang(MaKH)

	SELECT * 
	FROM tbl_ChiTietHoaDon

	ALTER TABLE tbl_ChiTietHoaDon
	DROP CONSTRAINT FK_MaHD_tbl_ChiTietHoaDon

	INSERT INTO tbl_ChiTietHoaDon (MaHD, MaVT, SoLuong, GiaBan)
	VALUES	('HD020','VT01',10,55000),
			('HD020','VT02',2,47000)
	
	ALTER TABLE tbl_ChiTietHoaDon WITH NOCHECK
	ADD CONSTRAINT FK_MaHD_tbl_ChiTietHoaDon FOREIGN KEY(MaHD) REFERENCES tbl_HoaDon(MaHD)
COMMIT TRANSACTION Update_tbl_HoaDon_ChiTietHoaDon;

SELECT *
FROM tbl_HoaDon;

SELECT *
FROM tbl_ChiTietHoaDon;

-- 2. Tạo Transaction xoá thông tin của HD008 ra khỏi Database.
BEGIN TRANSACTION Delete_HD008
	ALTER TABLE tbl_ChiTietHoaDon
	DROP CONSTRAINT FK_MaHD_tbl_ChiTietHoaDon

	ALTER TABLE tbl_ChiTietHoaDon WITH NOCHECK
	ADD CONSTRAINT FK_MaHD_tbl_ChiTietHoaDon FOREIGN KEY(MaHD) REFERENCES tbl_HoaDon(MaHD)
	ON DELETE CASCADE
	ON UPDATE CASCADE

	DELETE FROM tbl_HoaDon
	WHERE MaHD = 'HD008'
COMMIT TRANSACTION Delete_HD008;