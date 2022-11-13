-- Exercise 6:
-- 1. Hiển thị danh sách tất cả khách hàng gồm Mã Khách hàng, Tên Khách hàng, Địa chỉ, Điện thoại và Email.
SELECT * FROM tbl_KhachHang;

-- 2. Hiển thị danh sách các Khách hàng có địa chỉ "Tan Binh" gồm Mã Khách hàng, Tên Khách hàng, Địa chỉ, Điện thoại và Email.
-- Sắp xếp theo Mã khách hàng.
SELECT * FROM tbl_KhachHang
WHERE DiaChi = 'Tan Binh';

-- 3. Hiển thị danh sách các Khách hàng đã có số điện thoại và Email.
-- Gồm Mã Khách hàng, Tên Khách hàng, Địa chỉ, Điện thoại và Email.
SELECT * FROM tbl_KhachHang
WHERE	DienThoai is NOT NULL AND
		Email is NOT NULL;

-- 4. Hiển thị danh sách tất cả các vật tư, gồm Mã Vật tư, Tên Vật tư, Đơn vị tính và Giá mua.
SELECT MaVT, TenVT, DonViTinh, GiaMua
FROM tbl_VatTu;

-- 5. Hiển thị danh sách các vật tư gồm Mã vật tư, Tên vật tư, Đơn vị tính.
-- Giá mua trong khoảng 20.000 - 40.000. Sắp xếp theo giá mua giảm dần.
SELECT MaVT, TenVT, DonViTinh
FROM tbl_VatTu
WHERE GiaMua BETWEEN 20000 AND 40000
ORDER BY GiaMua DESC;

-- 6. Hiển thị danh sách các vật tư là "Gạch" (bao gồm các loại gạch) gồm Mã Vật tư, Tên Vật tư, Đơn vị tính và Giá mua.
SELECT MaVT, TenVT, DonViTinh, GiaMua FROM tbl_VatTu
WHERE TenVT like 'Gach%';

-- 7. Hiển thị số lượng vật tư trong Cơ sở dữ liệu.
SELECT COUNT(MaVT) AS SoLuongVattu FROM tbl_VatTu;

-- 8. Hiển thị cho biết, mỗi hoá đơn đã mua bao nhiêu loại vật tư. Thông tin gồm: Mã hoá đơn, Số loại vật tư trong hoá đơn.
SELECT	MaHD,
		COUNT(MaVT) AS SoLuongVattu_MoiHoaDon
FROM tbl_ChiTietHoaDon
GROUP BY MaHD;

-- 9. Hiển thị cho biết, tổng tiền của mỗi hoá đơn. Thông tin lấy về gồm: Mã hoá đơn, Tổng tiền của mỗi hoá đơn.
-- Tổng tiền của mỗi hoá đơn là tổng tiền của các vật tư trong hoá đơn đó.
SELECT MaHD, TongGiatri AS TongTien FROM tbl_HoaDon;

-- 10. Hiển thị cho biết, mỗi Khách hàng đã mua bao nhiêu hoá đơn. Thông tin lấy về gồm: Mã Khách hàng, Số lượng hoá đơn.
SELECT	KH.MaKH, COUNT(HD.MaHD) AS SoLuongHoaDon
FROM tbl_KhachHang AS KH
LEFT JOIN tbl_HoaDon AS HD ON KH.MAKH = HD.MAKH
GROUP BY KH.MaKH;
GO