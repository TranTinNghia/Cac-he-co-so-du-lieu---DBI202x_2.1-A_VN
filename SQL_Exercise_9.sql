-- Exercise 9:
-- 1. Xoá dữ liệu Khách hàng có Mã Khách hàng là 02.

-- Còn dòng KH02:
SELECT *
FROM tbl_KhachHang;

ALTER TABLE tbl_HoaDon
DROP CONSTRAINT FK_tbl_HoaDon; 

DELETE FROM tbl_KhachHang
WHERE MaKH = 'KH02';

ALTER TABLE tbl_HoaDon WITH NOCHECK
ADD CONSTRAINT FK_tbl_HoaDon FOREIGN KEY(MaKH) REFERENCES tbl_KhachHang(MaKH);

-- Không còn dòng KH02:
SELECT *
FROM tbl_KhachHang

-- 2. Xoá các Khách hàng ở quận Tân Bình.

SELECT *
FROM tbl_KhachHang;

ALTER TABLE tbl_HoaDon
DROP CONSTRAINT FK_tbl_HoaDon;

DELETE FROM tbl_KhachHang
WHERE DiaChi = 'Tan Binh';

ALTER TABLE tbl_HoaDon WITH NOCHECK
ADD CONSTRAINT FK_tbl_HoaDon FOREIGN KEY(MaKH) REFERENCES tbl_KhachHang(MaKH);

SELECT *
FROM tbl_KhachHang;

-- 3. Xoá vật tư có giá mua nhỏ hơn 1000.

SELECT *
FROM tbl_VatTu;

ALTER TABLE tbl_ChiTietHoaDon
DROP CONSTRAINT FK_MaVT_tbl_ChiTietHoaDon;

DELETE FROM tbl_VatTu
WHERE GiaMua < 1000;

ALTER TABLE tbl_ChiTietHoaDon WITH NOCHECK
ADD CONSTRAINT FK_MaVT_tbl_ChiTietHoaDon FOREIGN KEY(MaVT) REFERENCES tbl_VatTu(MaVT);

SELECT *
FROM tbl_VatTu;

-- 4. Cập nhật giá bán Vật tư có mã VT05 tăng thêm 10%.

SELECT *
FROM tbl_ChiTietHoaDon
WHERE MaVT = 'VT05';

UPDATE tbl_ChiTietHoaDon
SET GiaBan = GiaBan * 1.1
WHERE MaVT = 'VT05';

-- 5. Cập nhật giá bán của tất cả các vật tư thuộc HD009 tăng thêm 10%.

SELECT *
FROM tbl_ChiTietHoaDon
WHERE MaHD = 'HD009';

UPDATE tbl_ChiTietHoaDon
SET GiaBan = GiaBan * 1.1
WHERE MaHD = 'HD009';