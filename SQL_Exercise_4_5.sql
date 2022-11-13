-- Create QL_BanHang Database:
CREATE DATABASE QL_BanHang;
GO

-- Create KHACHHANG Table:
CREATE TABLE tbl_KhachHang (
	MaKH nvarchar(5) CONSTRAINT PK_tbl_KhachHang PRIMARY KEY,
	TenKH nvarchar(30) NOT NULL,
	DiaChi nvarchar(300) NOT NULL,
	DienThoai nvarchar(10) NULL CONSTRAINT CHK_len_dienthoai CHECK(LEN(DienThoai) <= 8),
	Email varchar(30) NULL
);

-- Add data into KHACHHANG Table:
INSERT INTO tbl_KhachHang (MaKH, TenKH, DiaChi, DienThoai, Email)
VALUES	('KH01', 'Nguyen Thi Be', 'Tan Binh', '08457895', 'bnt@yahoo.com'),
		('KH02', 'Le Hoang Nam', 'Binh Chanh', '09878987', 'namlehoang@gmail.com'),
		('KH03', 'Tran Thi Chieu', 'Tan Binh', '08457895', NULL),
		('KH04', 'Mai Thi Que Anh', 'Binh Chanh', NULL, NULL),
		('KH05', 'Le Van Sang', 'Quan 10', NULL, 'sanglv@hcm.vnn.vn'),
		('KH06', 'Tran Hoang Khai', 'Tan Binh', '08457897', NULL);

SELECT * FROM tbl_KhachHang;
GO

-- Create VATTU Table:
CREATE TABLE tbl_VatTu (
	MaVT nvarchar(5) CONSTRAINT PK_tbl_VatTu PRIMARY KEY,
	TenVT nvarchar(30) NOT NULL,
	DonViTinh nvarchar(20) NOT NULL,
	GiaMua money NOT NULL CONSTRAINT CHK_giamua CHECK(GiaMua > 0),
	SoLuongTon int NOT NULL CONSTRAINT CHK_soluongton CHECK(SoLuongTon >= 0)
);

-- Add data into VATTU Table:
INSERT INTO tbl_VatTu (MaVT, TenVT, DonViTinh, GiaMua, SoLuongTon)
VALUES	('VT01', 'Xi mang', 'Bao', 50000, 5000),
		('VT02', 'Cat', 'Khoi', 45000, 50000),
		('VT03', 'Gach ong', 'Vien', 120, 800000),
		('VT04', 'Gach the', 'Vien', 110, 800000),
		('VT05', 'Da lon', 'Khoi', 25000, 100000),
		('VT06', 'Da nho', 'Khoi', 33000, 100000),
		('VT07', 'Lam gio', 'Cai', 15000, 50000);

SELECT * FROM tbl_VatTu;
GO

-- Create HOADON Table:
CREATE TABLE tbl_HoaDon (
	MaHD nvarchar(10) CONSTRAINT PK_tbl_HoaDon PRIMARY KEY,
	NgayHD datetime NOT NULL,
	MaKH nvarchar(5),
	TongGiatri money NOT NULL,
	CONSTRAINT FK_tbl_HoaDon FOREIGN KEY(MaKH) REFERENCES tbl_KhachHang(MaKH)
);

-- Add data into HOADON Table:
INSERT INTO tbl_HoaDon (MaHD, NgayHD, MaKH, TongGiatri)
VALUES	('HD001', '2000-05-12', 'KH01', 82000),
		('HD002', '2000-05-25', 'KH02', 150),
		('HD003', '2000-05-25', 'KH01', 55000),
		('HD004', '2000-05-25', 'KH04', 270),
		('HD005', '2000-05-26', 'KH04', 82000),
		('HD006', '2000-06-02', 'KH03', 120),
		('HD007', '2000-06-22', 'KH04', 125),
		('HD008', '2000-06-25', 'KH03', 102000),
		('HD009', '2000-08-15', 'KH04', 48000),
		('HD010', '2000-09-30', 'KH01', 57000),
		('HD011', '2000-12-27', 'KH06', 100000),
		('HD012', '2000-12-27', 'KH01', 103150);

SELECT	MaHD, FORMAT(NgayHD,'dd/MM/yyyy') AS NgayHD, MaKH, TongGiatri
FROM tbl_HoaDon;
GO

-- Create CHITIETHOADON Table:
CREATE TABLE tbl_ChiTietHoaDon (
	MaHD nvarchar(10),
	MaVT nvarchar(5),
	SoLuong int CONSTRAINT DF_Soluong_1 DEFAULT 1,
	GiaBan money NOT NULL,
	CONSTRAINT FK_MaHD_tbl_ChiTietHoaDon FOREIGN KEY (MaHD) REFERENCES tbl_HoaDon (MaHD),
	CONSTRAINT FK_MaVT_tbl_ChiTietHoaDon FOREIGN KEY (MaVT) REFERENCES tbl_VatTu (MaVT),
	CONSTRAINT CHK_SoLuong CHECK (SoLuong > 0)
);

-- Add data into CHITIETHOADON Table:
INSERT INTO tbl_ChiTietHoaDon (MaHD, MaVT, SoLuong, GiaBan)
VALUES	('HD001', 'VT01', 5, 52000),
		('HD001', 'VT05', 10, 30000),
		('HD002', 'VT03', 10000, 150),
		('HD003', 'VT02', 20, 55000),
		('HD004', 'VT03', 50000, 150),
		('HD004', 'VT04', 20000, 120),
		('HD005', 'VT05', 10, 30000),
		('HD005', 'VT06', 15, 35000),
		('HD005', 'VT07', 20, 17000),
		('HD006', 'VT04', 10000, 120),
		('HD007', 'VT04', 20000, 125),
		('HD008', 'VT01', 100, 55000),
		('HD008', 'VT02', 20, 47000),
		('HD009', 'VT02', 25, 48000),
		('HD010', 'VT01', 25, 57000),
		('HD011', 'VT01', 20, 55000),
		('HD011', 'VT02', 20, 45000),
		('HD012', 'VT01', 20, 55000),
		('HD012', 'VT02', 10, 48000),
		('HD012', 'VT03', 10000, 150);

SELECT * FROM tbl_ChiTietHoaDon;
GO













