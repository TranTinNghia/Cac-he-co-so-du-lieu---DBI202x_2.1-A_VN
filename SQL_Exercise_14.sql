-- 1. Tạo Hàm, nhập vào một Mã Vật tư, tìm giá mua của vật tư đó là bao nhiêu.
ALTER FUNCTION Tim_GiaMua_VatTu (@MaVT NVARCHAR(5))
RETURNS INT
AS
BEGIN
	DECLARE @GiaMua INT
	SELECT @GiaMua = GiaMua FROM tbl_VatTu WHERE @MaVT = MaVT
	RETURN @GiaMua
END
GO

IF (SELECT dbo.Tim_GiaMua_VatTu('VT02') AS GiaMua_CuaVatTu) IS NOT NULL
BEGIN
	SELECT dbo.Tim_GiaMua_VatTu('VT02') AS GiaMua_CuaVatTu
END
ELSE
BEGIN
	PRINT N'Mã vật tư không tồn tại'
END
GO

-- 2. Tạo Hàm, nhập vào một Mã Khách hàng, tìm tên của Khách hàng đó.
ALTER FUNCTION Tim_Ten_KhachHang (@MaKH NVARCHAR(5))
RETURNS NVARCHAR(30)
AS
BEGIN
	DECLARE @TenKhachHang NVARCHAR(30)
	SELECT @TenKhachHang = TenKH FROM tbl_KhachHang WHERE MaKH = @MaKH
	RETURN @TenKhachHang
END
GO

IF (SELECT dbo.Tim_Ten_KhachHang('KH06') AS Ten_KhachHang) IS NOT NULL
BEGIN
	SELECT dbo.Tim_Ten_KhachHang('KH06') AS Ten_KhachHang
END
ELSE
BEGIN
	PRINT N'Mã Khách hàng không tồn tại'
END
GO

-- 3. Tạo Hàm, nhập vào một Mã Khách hàng, tính xem đã mua tổng cộng bao nhiêu tiền.
ALTER FUNCTION TongTien_KhachHangTra (@MaKH NVARCHAR(5))
RETURNS INT
AS
BEGIN
	DECLARE @TongTien_KhachTra INT
	SELECT 	@TongTien_KhachTra = SUM(TongGiatri) FROM tbl_HoaDon WHERE @MaKH = MaKH GROUP BY MaKH
	RETURN @TongTien_KhachTra
END
GO

IF (SELECT dbo.TongTien_KhachHangTra('KH02') AS TongTien_KhachTra) IS NOT NULL
BEGIN
	SELECT dbo.TongTien_KhachHangTra('KH02') AS TongTien_KhachTra
END
ELSE
BEGIN
	PRINT N'Mã Khách hàng không tồn tại'
END
GO

-- 4. Tạo Hàm, tìm xem vật tư nào bán nhiều tiền nhất, trả về Mã Vật tư đó.
ALTER FUNCTION Tim_MaVatTu_SoTienLonNhat()
RETURNS NVARCHAR(5)
AS
BEGIN
	DECLARE @MaVT NVARCHAR(5)
	SELECT @MaVT = MaVT
	FROM tbl_ChiTietHoaDon
	GROUP BY MaVT
	HAVING SUM(GiaBan * SoLuong) =
		(SELECT MAX(TongTien) AS TongTien_LonNhat
		FROM
			(SELECT MaVT, SUM(GiaBan * SoLuong) AS TongTien
			FROM tbl_ChiTietHoaDon
			GROUP BY MaVT) AS TEMP
		)
	RETURN @MaVT
END
GO

SELECT dbo.Tim_MaVatTu_SoTienLonNhat() AS Ma_VatTu_CanTim


