-- Exercise 10:
-- 1. Đánh chỉ mục cho Trường Giá mua trong bảng Vật tư.

CREATE NONCLUSTERED INDEX idx_tbl_VatTu_GiaMua
ON tbl_VatTu(GiaMua)
INCLUDE (TenVT);

SELECT TenVT, GiaMua
FROM tbl_VatTu
WHERE GiaMua = 50000;

-- 2. Đánh chỉ mục cho trường Số lượng tồn trong bảng Vật tư.

CREATE NONCLUSTERED INDEX idx_tbl_VatTu_SoLuongTon
ON tbl_VatTu(SoLuongTon);

SELECT SoLuongTon
FROM tbl_VatTu
WHERE SoLuongTon = 5000

-- 3. Đánh chỉ mục cho trường Ngày trong bảng Hoá đơn.

CREATE NONCLUSTERED INDEX idx_tbl_HoaDon_NgayHD
ON tbl_HoaDon(NgayHD)
INCLUDE (MaHD, MaKH);

SELECT NgayHD, MaHD, MaKH
FROM tbl_HoaDon
WHERE	NgayHD = '2000-12-27' OR
		NgayHD = '2000-06-25'