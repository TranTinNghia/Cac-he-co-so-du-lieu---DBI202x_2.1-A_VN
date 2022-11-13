-- Exercise 7:
-- 1. Lấy ra các thông tin gồm Mã hoá đơn, Ngày lập hoá đơn, Tên Khách hàng, Địa chỉ Khách hàng và Số điện thoại.

SELECT	HD.MaHD, FORMAT(HD.NgayHD,'dd/MM/yyyy') AS NgayHD, KH.TenKH, KH.DiaChi, KH.DienThoai
FROM tbl_HoaDon AS HD
LEFT JOIN tbl_KhachHang AS KH 
ON HD.MaKH = KH.MaKH;

-- 2. Lấy ra các thông tin gồm Mã hoá đơn, Tên Khách hàng, Địa chỉ Khách hàng và Số điện thoại ngày 25/05/2000.

SELECT	HD.MaHD, KH.TenKH, KH.DiaChi, KH.DienThoai
FROM tbl_HoaDon AS HD
LEFT JOIN tbl_KhachHang AS KH 
ON HD.MaKH = KH.MaKH
WHERE HD.NgayHD = '2000-05-25';

-- 3. Lấy ra các thông tin gồm Mã hoá đơn, Ngày lập hoá đơn, Tên Khách hàng, Địa chỉ Khách hàng và Số điện thoại
-- của những hoá đơn trong tháng 06/2000.

SELECT	HD.MaHD, FORMAT(HD.NgayHD,'dd/MM/yyyy') AS NgayHD, KH.TenKH, KH.DiaChi, KH.DienThoai
FROM tbl_HoaDon AS HD
LEFT JOIN tbl_KhachHang AS KH 
ON HD.MaKH = KH.MaKH
WHERE HD.NgayHD BETWEEN '2000-06-01' AND '2000-06-30';

-- 4. Lấy ra danh sách các Khách hàng (Tên Khách hàng, Địa chỉ, Số điện thoại) đã mua hàng trong tháng 06/2000.

SELECT	DISTINCT KH.TenKH, KH.DiaChi, KH.DienThoai
FROM tbl_HoaDon AS HD
LEFT JOIN tbl_KhachHang AS KH 
ON HD.MaKH = KH.MaKH
WHERE HD.NgayHD BETWEEN '2000-06-01' AND '2000-06-30';

-- 5. Lấy ra danh sách các mặt hàng được bán từ ngày 01/01/2000 đến ngày 01/07/2000. Thông tin gồm: Mã vật tư, Tên vật tư.

WITH tbl_Temp_VatTu AS (	
	SELECT DISTINCT HD_Detail.MaVT
	FROM tbl_ChiTietHoaDon AS HD_Detail
	LEFT JOIN tbl_HoaDon AS HD 
	ON HD_Detail.MaHD = HD.MaHD 
	WHERE HD.NgayHD BETWEEN '2000-01-01' AND '2000-07-01')

SELECT tbl_Temp_VatTu.MaVT, VT.TenVT
FROM tbl_Temp_VatTu 
LEFT JOIN tbl_VatTu AS VT 
ON tbl_Temp_VatTu.MaVT = VT.MaVT;

-- 6. Lấy ra danh sách các vật tư được bán từ ngày 1/1/2000 đến ngày 1/7/2000. 
-- Thông tin gồm: Mã vật tư, Tên vật tư, Tên Khách hàng đã mua, ngày mua, số lượng mua.

WITH tbl_Temp AS (
	SELECT	HD.MaHD,
			HD_Detail.MaVT,
			HD_Detail.SoLuong,
			HD.NgayHD,
			HD.MaKH
	FROM tbl_ChiTietHoaDon AS HD_Detail
	LEFT JOIN tbl_HoaDon AS HD
	ON HD_Detail.MaHD = HD.MaHD
	WHERE HD.NgayHD BETWEEN '2000-01-01' AND '2000-07-01')

SELECT	tbl_Temp.MaVT,
		VT.TenVT,
		KH.TenKH,
		FORMAT(tbl_Temp.NgayHD,'dd/MM/yyyy') AS NgayMua,
		tbl_Temp.SoLuong
FROM tbl_Temp
LEFT JOIN tbl_KhachHang AS KH
ON tbl_Temp.MaKH = KH.MaKH
LEFT JOIN tbl_VatTu AS VT
ON tbl_Temp.MaVT = VT.MaVT;

-- 7. Lấy ra danh sách các vật tư được mua bởi những khách hàng ở Tân Bình, trong năm 2000. 
-- Thông tin lấy ra gồm: Mã vật tư, Tên vật tư, Tên khách hàng, Ngày mua, Số lượng mua.

WITH tbl_Temp AS (
	SELECT	HD.MaHD,
			HD_Detail.MaVT,
			HD_Detail.SoLuong,
			HD.NgayHD,
			HD.MaKH
	FROM tbl_ChiTietHoaDon AS HD_Detail
	LEFT JOIN tbl_HoaDon AS HD
	ON HD_Detail.MaHD = HD.MaHD
	WHERE HD.NgayHD BETWEEN '2000-01-01' AND '2000-12-31')

SELECT	tbl_Temp.MaVT,
		VT.TenVT,
		KH.TenKH,
		FORMAT(tbl_Temp.NgayHD,'dd/MM/yyyy') AS NgayMua,
		tbl_Temp.SoLuong
FROM tbl_Temp
LEFT JOIN tbl_KhachHang AS KH
ON tbl_Temp.MaKH = KH.MaKH
LEFT JOIN tbl_VatTu AS VT
ON tbl_Temp.MaVT = VT.MaVT
WHERE KH.DiaChi = 'Tan Binh'
ORDER BY 1;

-- 8. Lấy ra danh sách các vật tư được mua bởi những khách hàng ở Tân Bình, trong năm 2000. 
-- Thông tin lấy ra gồm: Mã vật tư, Tên vật tư.

WITH tbl_Temp AS (
	SELECT	HD.MaHD,
			HD_Detail.MaVT,
			HD_Detail.SoLuong,
			HD.NgayHD,
			HD.MaKH
	FROM tbl_ChiTietHoaDon AS HD_Detail
	LEFT JOIN tbl_HoaDon AS HD
	ON HD_Detail.MaHD = HD.MaHD
	WHERE HD.NgayHD BETWEEN '2000-01-01' AND '2000-12-31')

SELECT	DISTINCT tbl_Temp.MaVT,
		VT.TenVT
FROM tbl_Temp
LEFT JOIN tbl_KhachHang AS KH
ON tbl_Temp.MaKH = KH.MaKH
LEFT JOIN tbl_VatTu AS VT
ON tbl_Temp.MaVT = VT.MaVT
WHERE KH.DiaChi = 'Tan Binh'
ORDER BY 1;

-- 9. Lấy ra danh sách những khách hàng không mua hàng trong tháng 6/2000.
-- Thông tin gồm Tên khách hàng, Địa chỉ, Số điện thoại.

WITH tbl_Temp AS (
	SELECT DISTINCT MaKH
	FROM tbl_HoaDon
	WHERE NgayHD BETWEEN '2000-01-01' AND '2000-12-31')

SELECT	KH.MaKH, KH.TenKH, KH.DiaChi, KH.DienThoai
FROM tbl_Temp
RIGHT JOIN tbl_KhachHang AS KH
ON tbl_Temp.MaKH = KH.MaKH
WHERE tbl_Temp.MaKH IS NULL;