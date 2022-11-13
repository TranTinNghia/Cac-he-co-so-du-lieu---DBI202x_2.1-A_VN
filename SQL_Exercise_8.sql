-- Exercise 8:
-- 1. Hiển thị danh sách các Khách hàng có điện thoại là 08457895, gồm Mã Khách hàng, Tên Khách hàng, Địa chỉ, Điện thoại và Email:

SELECT	MaKH, TenKH, DiaChi, DienThoai, Email
FROM tbl_KhachHang
WHERE DienThoai = '08457895';

-- 2. Hiện thị danh sách các vật tư là "DA" (bao gồm các loại đá) có giá mua dưới 30.000.
-- Gồm Mã Vật tư, Tên Vật tư, Đơn vị tính và Giá mua.

SELECT	MaVT, TenVT, DonViTinh, GiaMua
FROM tbl_VatTu
WHERE	TenVT LIKE '%DA%' AND
		GiaMua < 30000;

-- 3. Lấy ra các thông tin Mã Hoá đơn, Ngày Hoá đơn, Tên Khách hàng, Địa chỉ Khách hàng và Điện thoại.
-- Sắp xếp theo thứ tự Ngày Hoá đơn giảm dần.

SELECT	MaHD, FORMAT(NgayHD,'dd/MM/yyyy') AS Format_NgayHD, TenKH, DiaChi, DienThoai
FROM tbl_HoaDon AS HD
LEFT JOIN tbl_KhachHang AS KH
ON HD.MaKH = KH.MaKH
ORDER BY NgayHD DESC;

-- 4. Lấy ra danh sách các Khách hàng mua hàng trong tháng 06/2000, bao gồm Tên Khách hàng, Địa chỉ, Điện thoại.

SELECT	DISTINCT TenKH, DiaChi, DienThoai
FROM tbl_HoaDon AS HD
LEFT JOIN tbl_KhachHang AS KH
ON HD.MaKH = KH.MaKH
WHERE NgayHD BETWEEN '2000-06-01' AND '2000-06-30';

-- 5. Lấy ra chi tiết gồm Mã Hoá đơn, Mã Vật tư, Tên Vật tư, Giá bán, Giá mua, Số lượng, Trị giá mua (Giá mua x Số lượng).
-- Trị giá bán (Giá bán x Số lượng), Tiền lời (Trị giá bán - Trị giá mua) với Giá bán lớn hơn hoặc bằng Giá mua.

SELECT	MaHD, HD_Detail.MaVT, TenVT, GiaBan, GiaMua, SoLuong,
		(GiaMua * SoLuong) AS Tri_Gia_Mua,
		(GiaBan * SoLuong) AS Tri_Gia_Ban,
		((GiaBan * SoLuong) - (GiaMua * SoLuong)) AS Tien_Loi
FROM tbl_ChiTietHoaDon AS HD_Detail
LEFT JOIN tbl_VatTu AS VT
ON HD_Detail.MaVT = VT.MaVT
WHERE GiaBan >= GiaMua
ORDER BY 2;

-- 6. Lấy ra hoá đơn có tổng trị giá nhỏ nhất trong số các hóa đơn năm 2000, 
-- Gồm các thông tin: Số Hoá đơn, Ngày Hoá đơn, Tên Khách hàng, Địa chỉ, Tổng trị giá của hoá đơn.

WITH tbl_Temp AS (	
	SELECT	TOP(1) Detail.MaHD, NgayHD, MaKH, SUM(Tri_Gia_Ban) AS Tong_Tri_Gia_Hoa_Don
	FROM 
		(SELECT	MaHD, HD_Detail.MaVT, TenVT, GiaBan, GiaMua, SoLuong,
				(GiaMua * SoLuong) AS Tri_Gia_Mua,
				(GiaBan * SoLuong) AS Tri_Gia_Ban,
				((GiaBan * SoLuong) - (GiaMua * SoLuong)) AS Tien_Loi
		FROM tbl_ChiTietHoaDon AS HD_Detail
		LEFT JOIN tbl_VatTu AS VT
		ON HD_Detail.MaVT = VT.MaVT
		WHERE GiaBan >= GiaMua) AS Detail
	LEFT JOIN tbl_HoaDon AS HD
	ON Detail.MaHD = HD.MaHD
	WHERE NgayHD BETWEEN '2000-01-01' AND '2000-12-31'
	GROUP BY Detail.MaHD, NgayHD, MaKH
	ORDER BY Tong_Tri_Gia_Hoa_Don)

SELECT	MaHD,
		FORMAT(NgayHD,'dd/MM/yyyy') AS NgayHD,
		TenKH,
		DiaChi,
		FORMAT(Tong_Tri_Gia_Hoa_Don,'#,###') AS Tong_Tri_Gia_Hoa_Don
FROM tbl_Temp
LEFT JOIN tbl_KhachHang AS KH
ON tbl_Temp.MaKH = KH.MaKH;

-- 7. Lấy ra thông tin về các khách hàng mua ít loại vật tư nhất.

WITH tbl_KH_Temp AS
	(SELECT	MaKH, COUNT(MaVT) AS SoLuong_Vat_Tu
	FROM tbl_ChiTietHoaDon AS HD_Detail
	LEFT JOIN tbl_HoaDon AS HD
	ON HD_Detail.MaHD = HD.MaHD
	GROUP BY MaKH)

SELECT TOP(1) tbl_KH_Temp.MaKH, TenKH, DiaChi, DienThoai, Email
FROM tbl_KH_Temp
LEFT JOIN tbl_KhachHang AS KH
ON tbl_KH_Temp.MaKH = KH.MaKH
ORDER BY SoLuong_Vat_Tu;

-- 8. Lấy ra vật tư có giá mua thấp nhất.

SELECT MaVT, TenVT, DonViTinh, GiaMua, SoLuongTon
FROM
	(SELECT	ROW_NUMBER() OVER(ORDER BY GiaMua) AS So_Thu_Tu, *
	FROM tbl_VatTu) AS tbl_Temp_VatTu
WHERE So_Thu_Tu = 1;

-- 9. Lấy ra vật tư có giá bán cao nhất trong số các vật tư được bán trong năm 2000.
-- Có thể có những vật tư chưa bán được đơn vị nào, khi đó cần hiển thị là đã bán 0 đơn vị.

SELECT tbl_Temp_VatTu.MaVT, TenVT
FROM
	(SELECT	TOP (1) MaVT, GiaBan,
			(CASE WHEN SUM(SoLuong) IS NULL THEN 0
			ELSE SUM(SoLuong)
			END) AS SL_Da_Ban
	FROM tbl_ChiTietHoaDon AS HD_Detail
	LEFT JOIN tbl_HoaDon as HD
	ON HD_Detail.MaHD = HD.MaHD
	WHERE NgayHD BETWEEN '2000-01-01' AND '2000-12-31'
	GROUP BY MaVT, GiaBan
	ORDER BY 1, 2 DESC) AS tbl_Temp_VatTu
LEFT JOIN tbl_VatTu AS VT
ON tbl_Temp_VatTu.MaVT = VT.MaVT;