-- 1. Tạo Stored Procedure cập nhật thông tin cột TongGiatri trong bảng HoaDon theo đúng thực tế của bảng ChiTietHoaDon.
ALTER PROCEDURE Update_tbl_HoaDon_TongGiatri
AS
BEGIN
	UPDATE tbl_HoaDon SET TongGiatri = Tong_GiaBan
	FROM
		(SELECT	MaHD,
				SUM(GiaBan) AS Tong_GiaBan
		FROM tbl_ChiTietHoaDon
		GROUP BY MaHD) AS tbl_Temp
	WHERE tbl_HoaDon.MaHD = tbl_Temp.MaHD
END
GO

EXECUTE Update_tbl_HoaDon_TongGiatri
GO

SELECT *
FROM tbl_HoaDon

-- 2. Tạo Stored Procedure, input là số điện thoại, kiểm tra xem đã có khách hàng có số điện thoại này trong cơ sở dữ liệu chưa.
-- Hiện thông báo đã có hoặc chưa có khách hàng này.
SELECT *
FROM tbl_KhachHang
GO

ALTER PROCEDURE Check_tbl_KhachHang_SoDienThoai
(@DienThoai NVARCHAR(10))
AS
BEGIN
	IF EXISTS (SELECT * FROM tbl_KhachHang WHERE DienThoai = @DienThoai)
	BEGIN
		SELECT MaKH, TenKH, DiaChi
		FROM tbl_KhachHang
		WHERE DienThoai = @DienThoai
	END
	ELSE
	BEGIN
		PRINT 'Khong co Khach hang'
		ROLLBACK TRANSACTION
	END
END

EXECUTE Check_tbl_KhachHang_SoDienThoai @DienThoai = '08457895'

-- 3. Tạo Stored Procedure có đầu vào là Mã Khách hàng, tính tổng số tiền mà Khách hàng này đã mua.
-- Kết quả trả về là tham số kiểu Output.
SELECT *
FROM tbl_KhachHang
GO

SELECT *
FROM tbl_HoaDon
GO

SELECT *
FROM tbl_ChiTietHoaDon
GO

-- Sử dụng Output Variable:
ALTER PROCEDURE TongTien_OutPut_Variable
(@MaKH NVARCHAR(5), @TongSoTien MONEY OUTPUT)
AS
BEGIN
	IF EXISTS (SELECT DISTINCT MaKH FROM tbl_HoaDon WHERE @MaKH = MaKH)
		BEGIN
			SET @TongSoTien =
				(SELECT SUM(SoLuong * GiaBan)
				FROM tbl_ChiTietHoaDon
				LEFT JOIN tbl_HoaDon
				ON tbl_ChiTietHoaDon.MaHD = tbl_HoaDon.MaHD
				WHERE @MaKH = MaKH
				GROUP BY MaKH)
		END
		ELSE
		BEGIN
			SET @TongSoTien = 0
		END
END
GO

DECLARE @TongTien MONEY
EXECUTE TongTien_Output_Variable 'KH05', @TongTien OUTPUT
SELECT @TongTien AS TongSoTien
GO

-- Sử dụng Return Value:
ALTER PROCEDURE TongTien_Return_Value
(@MaKH NVARCHAR(5))
AS
BEGIN
	IF EXISTS (SELECT DISTINCT MaKH FROM tbl_HoaDon WHERE @MaKH = MaKH)
		BEGIN
			RETURN
				(SELECT SUM(SoLuong * GiaBan)
				FROM tbl_ChiTietHoaDon
				LEFT JOIN tbl_HoaDon
				ON tbl_ChiTietHoaDon.MaHD = tbl_HoaDon.MaHD
				WHERE @MaKH = MaKH
				GROUP BY MaKH)
		END
		ELSE
		BEGIN
			RETURN 0
		END
END
GO

DECLARE @TongTien MONEY
EXECUTE @TongTien = TongTien_Return_Value 'KH05'
SELECT @TongTien AS TongSoTien
GO

-- 4. Tạo Stored Procedure gồm 2 tham số output @MaVT NVARCHAR(5) và @TenVT NVARCHAR(30).
-- Trả về mã và tên vật tư của vật tư có giá trị bán cao nhất.
CREATE PROCEDURE TongTien_VatTu_Caonhat
(@MaVT NVARCHAR(5) OUTPUT, @TenVT NVARCHAR(30) OUTPUT)
AS
BEGIN
	SET @MaVT =
		(SELECT MaVT
		FROM
			(SELECT TOP(1) tbl_ChiTietHoaDon.MaVT, TenVT, SUM(GiaBan*SoLuong) AS TongSoTien
			FROM tbl_ChiTietHoaDon
			INNER JOIN tbl_VatTu
			ON tbl_ChiTietHoaDon.MaVT = tbl_VatTu.MaVT
			GROUP BY tbl_ChiTietHoaDon.MaVT, TenVT
			ORDER BY 3 DESC) AS tbl_Temp_1)
	SET @TenVT =
		(SELECT TenVT
		FROM
			(SELECT TOP(1) tbl_ChiTietHoaDon.MaVT, TenVT, SUM(GiaBan*SoLuong) AS TongSoTien
			FROM tbl_ChiTietHoaDon
			INNER JOIN tbl_VatTu
			ON tbl_ChiTietHoaDon.MaVT = tbl_VatTu.MaVT
			GROUP BY tbl_ChiTietHoaDon.MaVT, TenVT
			ORDER BY 3 DESC) AS tbl_Temp_1)
END

DECLARE @Ma_VT NVARCHAR(5), @Ten_VT NVARCHAR(30)
EXECUTE TongTien_VatTu_Caonhat @Ma_VT OUTPUT, @Ten_VT OUTPUT
SELECT @Ma_VT AS Ma_Vat_Tu, @Ten_VT AS Ten_Vat_Tu

