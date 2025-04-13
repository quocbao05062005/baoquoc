USE MASTER 
GO
CREATE DATABASE Qlybanhang123
ON PRIMARY
( NAME = 'QuanlyBH1', FILENAME = 'D:\CSDL\quanlybanhang.mdf' , SIZE = 4048KB , MAXSIZE =
10240KB , FILEGROWTH = 20%)
LOG ON
( NAME = 'Qlybanhang123_log', FILENAME = 'D:\CSDL\quanlybanhang_log1.ldf' , SIZE = 1024KB , MAXSIZE =
10240KB , FILEGROWTH = 10%)
GO

use Qlybanhang123
GO
CREATE TABLE NhomSanPham (
 [MaNhom] [int] PRIMARY KEY,
 [TenNhom] [nvarchar](15) NULL )
GO
GO
CREATE TABLE [dbo].[Nhanvien](
 [MaNV] [nchar](5) PRIMARY KEY,
 [TenNV] [nvarchar](40) NOT NULL,
 [DiaChi] [nvarchar](60) NULL,
 [Dienthoai] [nvarchar](24) NULL )
GO

GO
CREATE TABLE [dbo].[NhaCungCap](
 [MaNCC] [int] NOT NULL,
 [TenNcc] [nvarchar](40) NOT NULL,
 [Diachi] [nvarchar](60) NULL,
 [Phone] [nvarchar](24) NULL,
 [SoFax] [nvarchar](24) NULL,
 [DCMail] [nvarchar](50) NULL,
PRIMARY KEY ( [MaNCC]) )
GO

GO
CREATE TABLE [dbo].[KhachHang](
 [MaKh] [nchar](5) NOT NULL,
 [TenKh] [nvarchar](40) NOT NULL,
 [LoaiKh] [nvarchar](3) NULL,
 [DiaChi] [nvarchar](60) NULL,
 [Phone] [nvarchar](24) NULL,
PRIMARY KEY ([MaKh]) ) 
GO
ALTER TABLE KhachHang ADD SoFax Nvarchar(24)
ALTER TABLE KhachHang ADD DCMail Nvarchar(50)
CREATE TABLE [dbo].[SanPham](
 [MaSp] [int] NOT NULL,
 [TenSp] [nvarchar](40) NOT NULL,
 [MaNCC] [int] NULL,
 [MoTa] [nvarchar](50) NULL,
 [MaNhom] [int] NULL,
 [Đonvitinh] [nvarchar](20) NULL,
 [GiaGoc] [money] NULL,
 [SLTON] [int] NULL,
PRIMARY KEY ([MaSp]) )
GO

CREATE TABLE [dbo].[HoaDon](
 [MaHD] [int] NOT NULL,
 [NgayLapHD] [datetime] NULL,
 [NgayGiao] [datetime] NULL,
 [Noichuyen] [nvarchar](60) NOT NULL,
 [MaNV] [nchar](5) NULL,
 [MaKh] [nchar](5) NULL,
PRIMARY KEY ([MaHD]) )
GO

GO
CREATE TABLE [dbo].[CT_HoaDon](
 [MaHD] [int] NOT NULL,
 [MaSp] [int] NOT NULL,
 [Soluong] [smallint] NULL,
 [Dongia] [money] NULL,
 [ChietKhau] [money] NULL,
PRIMARY KEY CLUSTERED
(
 [MaHD] ASC,
 [MaSp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[HoaDon] ADD CONSTRAINT [HD_df] DEFAULT (getdate()) FOR
[NgayLapHD]
GO

ALTER TABLE [dbo].[KhachHang] WITH CHECK ADD CONSTRAINT [kh_ck] CHECK 
(([LoaiKH]='VL' OR [LoaiKH]='TV' OR [LoaiKH]='VIP'))
GO
ALTER TABLE [dbo].[KhachHang] CHECK CONSTRAINT [kh_ck]
GO

ALTER TABLE [dbo].[SanPham] WITH CHECK ADD CONSTRAINT [Sanpham_ck1] CHECK 
(([slton]>(0)))
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [Sanpham_ck1]
GO

ALTER TABLE [dbo].[SanPham] WITH CHECK ADD CONSTRAINT [sp_ck] CHECK (([SlTon]>(0)))
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [sp_ck]
GO

ALTER TABLE [dbo].[HoaDon] WITH CHECK ADD CONSTRAINT [HD_ck] CHECK 
(([NgayLapHD]>=getdate()))
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [HD_ck]
GO

ALTER TABLE [dbo].[CT_HoaDon] WITH CHECK ADD CHECK (([chietkhau]>=(0)))
GO

ALTER TABLE [dbo].[CT_HoaDon] WITH CHECK ADD CHECK (([soluong]>(0)))
GO

ALTER TABLE [dbo].[SanPham] WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO

ALTER TABLE [dbo].[SanPham] WITH CHECK ADD FOREIGN KEY([MaNhom])
REFERENCES [dbo].[NhomSanPham] ([MaNhom])
GO

ALTER TABLE [dbo].[HoaDon] WITH CHECK ADD FOREIGN KEY([MaKh])
REFERENCES [dbo].[KhachHang] ([MaKh])
GO

ALTER TABLE [dbo].[HoaDon] WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[Nhanvien] ([MaNV])
GO

ALTER TABLE [dbo].[CT_HoaDon] WITH CHECK ADD FOREIGN KEY([MaHD])
REFERENCES [dbo].[HoaDon] ([MaHD])
GO

ALTER TABLE [dbo].[CT_HoaDon] WITH CHECK ADD FOREIGN KEY([MaSp])
REFERENCES [dbo].[SanPham] ([MaSp])
GO
USE Master 
USE Qlybanhang123
GO
INSERT INTO KhachHang (MaKh, TenKh, LoaiKh, DiaChi, Phone, SoFax, DCMail)
VALUES 
    ('KH001', 'Che quang quoc bao', 'VL', 'Ho Chi Minh', '0969048021', '0241234567', 'bcquocquoc0506@gmail.com'),
    ('KH002', 'Ha Thi Thanh Hoa', 'TV', 'Ho Chi Minh', '0976720266', '0287654321', 'Hathithanhhoa@gmail.com'),
    ('KH003', 'Che Quang Bao', 'VIP', 'Hue', '0969377052', '0234567890', 'chebao0506@gmai.com');

USE Qlybanhang123
GO
SELECT * FROM KhachHang;
SELECT * FROM Nhanvien;
SELECT * FROM NhaCungCap;
SELECT * FROM NhomSanPham;
SELECT * FROM SanPham;
SELECT * FROM HoaDon;
SELECT * FROM CT_HoaDon;
SELECT * FROM dbo.KhachHang;
GO
SELECT * FROM sys.tables WHERE name = 'HoaDon';


USE Qlybanhang123
ALTER TABLE HoaDon ADD MaNV NCHAR(5);
ALTER TABLE HoaDon ADD CONSTRAINT FK_HoaDon_Nhanvien FOREIGN KEY (MaNV) REFERENCES Nhanvien(MaNV);
INSERT INTO KhachHang(MaKh, TenKh, LoaiKh, DiaChi, Phone, SoFax, DCMail)
VALUES ('Kh001', 'CHE QUANG QUOC BAO', 'VIP', 'QGV-TP.HCM', '0969048021', '159753', 'bcquocquoc0506@gmail.com');
INSERT INTO KhachHang(MaKh, TenKh, LoaiKh, DiaChi, Phone, SoFax, DCMail)
VALUES ('Kh002', 'CHE QUANG BAO', 'TV', 'Q1-TP.HCM', '0969048021', '357951', 'baone56@gmail.com');
INSERT INTO KhachHang(MaKh, TenKh, LoaiKh, DiaChi, Phone, SoFax, DCMail)
VALUES ('Kh003', 'HA THI THANH HOA', 'VIP', 'Q1-TP.HCM', '0976720266', '895623', 'hoane@gmail.com')
INSERT INTO Nhanvien (MaNV, TenNV, DiaChi, Dienthoai)
VALUES ('NV001', 'NGUYEN VAN A', 'GO VAP', '0946456746');
INSERT INTO Nhanvien (MaNV, TenNV, DiaChi, Dienthoai)
VALUES ('NV011', 'NGUYEN THI HOA', 'HOC MON', '094567462');
INSERT INTO Nhanvien (MaNV, TenNV, DiaChi, Dienthoai)
VALUES ('NV016', 'NGUYEN XUAN CON', 'CU CHI', '0969048021');
GO
INSERT INTO NhaCungCap (MaNCC, TenNcc, Diachi, Phone, SoFax, DCMail)
VALUES (00001, 'CONG TY TNHH BAODZ', 'QUANG TRUNG - GO VAP', '0969048021', '159753', 'baodz@gmail.com');
INSERT INTO NhaCungCap (MaNCC, TenNcc, Diachi, Phone, SoFax, DCMail)
VALUES (00002, 'CONG TY TNHH BAONE', 'NGUYEN VAN LUONG - GO VAP', '0969048021', '357951', 'baone56@gmail.com');
INSERT INTO NhaCungCap (MaNCC, TenNcc, Diachi, Phone, SoFax, DCMail)
VALUES (00003, 'CONG TY TNHH BAOGIOI', 'LE THI HA - HOC MON', '0969048021', '123654', 'baogioi56@gmail.com');
INSERT INTO NhomSanPham (MANHOM, TenNhom)
VALUES (1, 'DIENTHOAI');
INSERT INTO NhomSanPham (MANHOM, TenNhom)
VALUES (2, 'PHUKIEN');
INSERT INTO NhomSanPham (MANHOM, TenNhom)
VALUES (3, 'KHAC');
INSERT INTO SanPham (MaSp, TenSp, Đonvitinh, GiaGoc, SLTON, MaNhom, MaNCC, MoTa)
VALUES (1, 'DIENTHOAI IPHONE', 'CAI',23500000, 200, 1, 00001, 'IPHONE  17');
INSERT INTO SanPham (MaSp, TenSp,Đonvitinh, GiaGoc, SLTON, MaNhom, MaNCC, MoTa)
VALUES (10, 'TAI NGHE', 'CAI',500000, 100, 1, 00001, 'TAI NGHE IPHONE');
INSERT INTO SanPham (MaSp, TenSp,Đonvitinh, GiaGoc, SLTON, MaNhom, MaNCC, MoTa)
VALUES (2, 'DIENTHOAI SAMSUNG', 'CAI',14900000, 50, 1, 00002, 'DIEN THOAI SAMSUNGS23');
INSERT INTO HoaDon (MaHD, NgayLapHD, MaKh, NgayGiao, Noichuyen)
VALUES (1, '06-03-2025', 'KH001', '08-03-2025', 'DANG THUC VINH, THOI TAM THON, HOCMON');
INSERT INTO HoaDon (MaHD, NgayLapHD, MaKh, NgayGiao, Noichuyen)
VALUES (2, '06-03-2025', 'KH002', '10-03-2025', 'LE THI HA, THOI TAM THON, HOCMON');
INSERT INTO HoaDon (MaHD, NgayLapHD, MaKh, NgayGiao, Noichuyen)
VALUES (3, '06-03-2025', 'KH001', '08-03-2025', 'LY THUONG KIET, TAM DONG, HOCMON');
INSERT INTO CT_HoaDon (MaHD, MaSp, Dongia, Soluong)
VALUES (1, 1, 25000000, 5);
INSERT INTO CT_HoaDon (MaHD, MaSp, Dongia, Soluong)
VALUES (2, 2, 15000000, 10);
INSERT INTO CT_HoaDon (MaHD, MaSp, Dongia, Soluong)
VALUES (3, 10, 450000, 5);

use Qlybanhang123

SELECT * FROM Customers;
CREATE TABLE Customers (CustomerID INT PRIMARY KEY,
    CompanyName VARCHAR(255) NOT NULL,
    Address TEXT,
    City VARCHAR(100),
    Region VARCHAR(100),
    Country VARCHAR(100));

INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country) VALUES
(1, 'Tech Corp', '123 Tech Street', 'Hanoi', 'North', 'Vietnam'),
(2, 'Green Groceries', '456 Market Lane', 'Ho Chi Minh City', 'South', 'Vietnam'),
(3, 'ABC Traders', '789 Business Road', 'Da Nang', 'Central', 'Vietnam'),
(4, 'XYZ Retailers', '101 Commerce Ave', 'Can Tho', 'South', 'Vietnam'),
(5, 'Home Living', '202 Cozy St', 'Hai Phong', 'North', 'Vietnam');

INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country) VALUES
(6, 'Tech Corp', '123 Tech Street', 'LonDon', 'North', 'Vietnam');
CREATE TABLE Suppliers (
    SupplierID int PRIMARY KEY,
    SupplierName nvarchar(60),
    Address nvarchar(100)
);


CREATE TABLE Products (
    ProductID int NOT NULL PRIMARY KEY,
    ProductName nvarchar(60),
    SupplierID int,
    UnitPrice int,
    UnitInStock int,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);
INSERT INTO Suppliers (SupplierID, SupplierName) VALUES
(1, 'ABC Supplies'),
(2, 'XYZ Distributors'),
(3, 'Fresh Foods Inc.'),
(4, 'Tech Gadgets Ltd.'),
(5, 'Home Essentials Co.');

INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock) VALUES
(1, N'Laptop Dell', 4, '1200', '50'),
(2, N'Bàn phím cơ', 4, '80', '200'),
(3, N'Rau sạch', 3, '10', '500'),
(4, N'Bột giặt', 5, '5', '300'),
(5, N'Nước giải khát', 3, '2', '1000');
UPDATE SanPham
SET TenSp = 'sua vinamilk', Đonvitinh = 'HOP', GiaGoc = 20000, SLTON = 100, MaNhom = 1, MaNCC = 2, MoTa = 'Mô tả sản phẩm'
WHERE MaSp = 1;
/** Tuần 9: 
Bài tập 1: Insert - CACH 2:
Câu 2: Khi bảng CT_HoaDon vẫn còn dữ liệu liên kết đến SanPham thông qua khóa ngoại MaSp,
 thì bạn không thể xóa SanPham được do vi phạm ràng buộc toàn vẹn.**/
 /*Câu 3: Bạn phải xóa bảng con trước, hoặc tắt tạm thời ràng buộc khóa ngoại*/
/* BAITAP2: UPDATE: */

UPDATE SanPham SET GiaGoc = 100000 WHERE TenSp LIKE 'T%';
SELECT MaSp, TenSp, GiaGoc FROM SanPham
WHERE TenSp LIKE 'T%';

UPDATE SanPham SET SLTON = SLTON / 2 WHERE Donvitinh LIKE '%HOP%';
SELECT MaSp, TenSp, Donvitinh, SLTON FROM SanPham
WHERE Donvitinh LIKE '%HOP%';

ALTER TABLE SanPham NOCHECK CONSTRAINT FK__SanPham__MaNCC__22AA2996;
UPDATE NhaCungCap SET MaNCC = 100 WHERE MaNCC = 1;
ALTER TABLE SanPham CHECK CONSTRAINT FK__SanPham__MaNCC__22AA2996;

/* CAU 4*/
UPDATE KhachHang SET DiemTL = DiemTL + 100
WHERE MaKh IN (SELECT DISTINCT MaKh
    FROM HoaDon
    WHERE MONTH(NgayLapHD) = 7 AND YEAR(NgayLapHD) = 1997);
SELECT KH.MaKh, TenKh, DiemTL FROM KhachHang KH
JOIN HoaDon HD ON KH.MaKh = HD.MaKh
WHERE MONTH(HD.NgayLapHD) = 7 AND YEAR(HD.NgayLapHD) = 1997;

INSERT INTO HoaDon (MaHD, NgayLapHD, MaKh, NgayGiao, Noichuyen)
VALUES
(4, '1997-07-01', 'KH001', '1997-07-05', 'DANG THUC VINH, THOI TAM THON, HOCMON'),
(5, '1997-07-02', 'KH002', '1997-07-06', 'LE THI HA, THOI TAM THON, HOCMON'),
(6, '1997-07-03', 'KH003', '1997-07-07', 'LY THUONG KIET, TAM DONG, HOCMON');

/* CAU 5*/
INSERT INTO SanPham (MaSp, TenSp, Đonvitinh, GiaGoc, SLTON, MaNhom, MaNCC, MoTa)
VALUES (3, 'DIENTHOAI NOKIA', 'CAI', 5000000, 5, 1, 00002, 'Điện thoại Nokia 3310');
UPDATE SanPham SET GiaGoc = GiaGoc * 0.9 WHERE SLTON < 10;
SELECT MaSp, TenSp, SLTON, GiaGoc FROM SanPham
WHERE SLTON < 10;

/* CAU 6*/
INSERT INTO NhaCungCap (MaNCC, TenNcc, Diachi, Phone, SoFax, DCMail)
VALUES (4, 'Nha Cung Cap 4', 'Dia chi 4', '123456789', '123456789', 'email4@example.com');
INSERT INTO NhaCungCap (MaNCC, TenNcc, Diachi, Phone, SoFax, DCMail)
VALUES (7, 'Nha Cung Cap 7', 'Dia chi 7', '987654321', '987654321', 'email7@example.com');
INSERT INTO SanPham (MaSp, TenSp, Đonvitinh, GiaGoc, SLTON, MaNhom, MaNCC, MoTa)
VALUES (6, 'Laptop Dell', 'CAI', 12000000, 50, 1, 4, 'Laptop Dell XPS 13');
INSERT INTO SanPham (MaSp, TenSp, Đonvitinh, GiaGoc, SLTON, MaNhom, MaNCC, MoTa)
VALUES (7, 'Bàn phím cơ', 'CAI', 800000, 200, 2, 7, 'Bàn phím cơ RGB');
UPDATE CT_HoaDon SET Dongia = SP.GiaGoc
FROM CT_HoaDon CT
JOIN SanPham SP ON CT.MaSp = SP.MaSp
WHERE SP.MaNCC IN (4, 7);
SELECT CT.MaHD, CT.MaSp, CT.Dongia, SP.GiaGoc, SP.MaNCC
FROM CT_HoaDon CT
JOIN SanPham SP ON CT.MaSp = SP.MaSp
WHERE SP.MaNCC IN (4, 7);


/* BAI TAP 3*/
/* CAU 1*/
/* Không thể xóa trực tiếp nếu như hóa đơn đó đã có dữ liệu liên quan trong bảng CT_HoaDon (bảng con) do ràng buộc khóa ngoại.
Phải xóa chi tiết hóa đơn trước rồi mới xóa hóa đơn. */
DELETE FROM CT_HoaDon
WHERE MaHD IN (SELECT MaHD FROM HoaDon
    WHERE MONTH(NgayLapHD) = 7 AND YEAR(NgayLapHD) = 1996);
DELETE FROM HoaDon
WHERE MONTH(NgayLapHD) = 7 AND YEAR(NgayLapHD) = 1996;

/*CAU 2*/
DELETE FROM CT_HoaDon
WHERE MaHD IN (SELECT MaHD FROM HoaDon HD
    JOIN KhachHang KH ON HD.MaKh = KH.MaKh
    WHERE KH.LoaiKh = 'VL' AND YEAR(NgayLapHD) = 1996);
DELETE FROM HoaDon
WHERE MaHD IN (SELECT MaHD FROM HoaDon HD
    JOIN KhachHang KH ON HD.MaKh = KH.MaKh
    WHERE KH.LoaiKh = 'VL' AND YEAR(NgayLapHD) = 1996);
 /*CAU 3*/
 DELETE FROM SanPham
WHERE MaSp NOT IN (SELECT DISTINCT MaSp FROM HoaDon HD
    JOIN CT_HoaDon CT ON HD.MaHD = CT.MaHD
    WHERE YEAR(NgayLapHD) = 1996);

 /* CAU 4*/
 DELETE FROM CT_HoaDon
WHERE MaHD IN (SELECT MaHD FROM HoaDon HD
    JOIN KhachHang KH ON HD.MaKh = KH.MaKh
    WHERE KH.LoaiKh = 'VL');
DELETE FROM HoaDon
WHERE MaKh IN (SELECT MaKh FROM KhachHang
    WHERE LoaiKh = 'VL');
DELETE FROM KhachHang WHERE LoaiKh = 'VL';

 /* CAU 5 */
SELECT * INTO HoaDon797
FROM HoaDon
WHERE MONTH(NgayLapHD) = 7 AND YEAR(NgayLapHD) = 1997;
/* XOA */
TRUNCATE TABLE HoaDon797;