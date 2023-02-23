/*--1. Tạo Database và bảng--*/
/*Tạo Database*/
CREATE DATABASE BTL; 
USE BTL;
GO

-- Tạo bảng Nhân viên
CREATE TABLE tbl_NhanVien( 
	iMaNV INT NOT NULL, 
	sTenNV NVARCHAR(50),
	sGioitinh NVARCHAR(10),
	dNgaysinh DATETIME,
	sSoDT VARCHAR(11),
	dNgayvaolam DATE, 
	fLuongcoban FLOAT, 
	fPhucap FLOAT
);

-- Tạo bảng Khách hàng
CREATE TABLE tbl_KhachHang( 
	iMaKH INT NOT  NULL, 
	sTenKH NVARCHAR(50),
	sGioitinh NVARCHAR(10), 
	sDiachi NVARCHAR(50), 
	dNgaysinh DATE,
	sSoDT VARCHAR(11), 
	sSoCMND VARCHAR(20) 
	ALTER TABLE dbo.tbl_KhachHang
    ALTER COLUMN dNgaysinh DATETIME
);

-- Tạo bảng Phòng
CREATE TABLE tbl_Phong( 
	iMaPhong INT NOT NULL, 
	sTenphong NVARCHAR(50), 
	iMaLP INT NOT NULL
);

-- Tạo bảng Dịch vụ
CREATE TABLE tbl_DichVu( 
	iMaDV INT NOT NULL, 
	sTenDV NVARCHAR(50),
	iSoluong INT, 
	fGiaDV FLOAT
);

-- Tạo bảng Hóa đơn 
CREATE TABLE tbl_HoaDon( 
	iMaHD INT NOT NULL, 
	iMaKH INT NOT NULL, 
	iMaNV INT NOT NULL,
	iMaPhong INT NOT  NULL, 
	dNgaylap DATE, 
	sTrangthai NVARCHAR(50)
);
ALTER TABLE dbo.tbl_HoaDon ALTER COLUMN dNgaylap DATETIME
-- Tạo bảng Loại phòng 
CREATE TABLE tbl_LoaiPhong( 
	iMaLP INT NOT NULL, 
	sTenLP NVARCHAR(50),
	fGiaphong FLOAT
);

-- Tạo bảng Chi tiết hóa đơn
CREATE TABLE tbl_ChiTietHoaDon( 
	iMaHD INT NOT NULL,
	iMaDV INT NOT NULL,
	dNgaythutien DATETIME, 
	sTrangthai NVARCHAR(50)
);


/*--2. Tạo các ràng buộc--*/
-- Tạo ràng buộc Primary Key
ALTER TABLE tbl_LoaiPhong ADD CONSTRAINT PK_iMaLP PRIMARY KEY (iMaLP);

ALTER TABLE tbl_Phong ADD CONSTRAINT PK_iMaPhong PRIMARY KEY  (iMaPhong); 

ALTER TABLE tbl_KhachHang ADD CONSTRAINT PK_iMaKH PRIMARY KEY(iMaKH);

ALTER TABLE tbl_NhanVien ADD CONSTRAINT PK_iMaNV PRIMARY KEY (iMaNV); 

ALTER TABLE tbl_DichVu ADD CONSTRAINT PK_iMaDV PRIMARY KEY  (iMaDV); 

ALTER TABLE tbl_HoaDon ADD CONSTRAINT PK_iMaHD PRIMARY KEY (iMaHD);

ALTER TABLE tbl_ChiTietHoaDon ADD CONSTRAINT PK_CT PRIMARY KEY (iMaHD,iMaDV);

-- Tạo ràng buộc Foreign Key
ALTER TABLE tbl_ChiTietHoaDon ADD CONSTRAINT FK_dichvu_ChiTietHoaDon	FOREIGN KEY(iMaDV)REFERENCES  tbl_DichVu(iMaDV);
ALTER TABLE tbl_ChiTietHoaDon DROP CONSTRAINT FK_dichvu_ChiTietHoaDon	

ALTER  TABLE tbl_ChiTietHoaDon ADD CONSTRAINT FK_hoadon_ChiTietHoaDon	FOREIGN KEY(iMaHD) REFERENCES  tbl_HoaDon(iMaHD);
ALTER TABLE tbl_ChiTietHoaDon DROP CONSTRAINT FK_hoadon_ChiTietHoaDon

ALTER TABLE tbl_Phong ADD CONSTRAINT FK_LP_Phong FOREIGN KEY(iMaLP) REFERENCES tbl_LoaiPhong(iMaLP);

ALTER TABLE tbl_HoaDon ADD CONSTRAINT FK_HD_NV FOREIGN  KEY  (iMaNV) REFERENCES tbl_NhanVien(iMaNV);

ALTER TABLE tbl_HoaDon ADD CONSTRAINT FK_HD_KH FOREIGN KEY  (iMaKH) REFERENCES tbl_KhachHang(iMaKH);

ALTER TABLE tbl_HoaDon ADD  CONSTRAINT FK_HD_Phong FOREIGN KEY (iMaPhong) REFERENCES tbl_Phong(iMaPhong);

-- Tạo ràng buộc Check
ALTER  TABLE  tbl_HoaDon ADD CONSTRAINT CK_HoaDon CHECK (dNgaylap<=GETDATE());

ALTER TABLE tbl_LoaiPhong ADD CONSTRAINT CK_LoaiPhong CHECK  (fGiaphong = 3000000 OR fGiaphong = 2000000);

-- Tạo ràng buộc Default 
ALTER TABLE tbl_HoaDon ADD CONSTRAINT CK_DF DEFAULT GETDATE()  FOR dNgaylap;

/*--3. Insert dữ liệu--*/
-- Chèn dữ liệu vào bảng Loại phòng
INSERT INTO tbl_LoaiPhong  
VALUES 	(1,  N'Thường',2000000),
		(2,  N'Vip',  3000000);

SELECT * FROM dbo.tbl_LoaiPhong

-- Chèn dữ liệu vào bảng Nhân viên
INSERT INTO tbl_NhanVien 
VALUES
	(1,N'Nguyễn  Văn  Hà',  N'Nam','1997-05-12'  ,'0954127736','2012-10-20',  4000000,  400),
	(2,N'Nguyễn  Thị  Ngọc',  N'Nữ','1995-04-02'  ,'0165322997','2011-01-25',  3000000,  300),
	(3,N'Dương  Văn  Hải',  N'Nam',  '1993-12-20','0963554723','2013-04-12',  3500000,  400),
	(4,N'Trần  Hoàng  Anh',  N'Nữ',  '1998-05-13','01652123846','2010-11-05',  3500000,  500),
	(5,N'Trịnh  Huy  Khánh',  N'Nam','1996-10-04','0912983472','2015-10-15',  3000000,  400),
	(6,N'Lê  Minh  Duy',N'Nam','1995-09-28','01697086390','2016-09-28',6000000,200);

SELECT * FROM dbo.tbl_NhanVien


-- Chèn dữ liệu vào bảng Khách hàng
INSERT INTO tbl_KhachHang 
VALUES
	(1,N'Nguyễn  Duy  Thành',N'Nam',N'Hà  Nội','1998-05-07','0912345682',  '122334757438'), 
	(2,  N'Nguyễn  Duy  Huỳnh',N'Nam',N'Hà  Nội','1998-01-24','01657234971'  ,'126567579'),
	(3,  N'Đỗ  Thị  Tuyên',N'Nữ',N'Bắc  Giang','1998-10-22','0936627112'  ,'122246565863'),
	(4,  N'Lê  Thị  Yên',  N'Nữ',  N'Bắc  Giang',  '1998-04-13',  '01651243564'  ,'125775266'),
	(5,  N'Trần  Văn  Cường',N'Nam',N'Bắc  Giang','1997-09-20','0912623213'  ,'126778342'), 
	(6,  N'Nguyễn  Khánh  Linh',N'Nữ',N'Hưng  Yên','1998-07-23','0969480270','125768142'), 
	(7,  N'Nguyễn  Văn  Huấn',N'Nam',N'Phú  Thọ','1998-05-11','01699572119'  ,  '145811911');

SELECT * FROM dbo.tbl_KhachHang 

-- Chèn dữ liệu vào bảng Dịch vụ
INSERT INTO tbl_DichVu  
VALUES
	(1,  N'DV mạng internet',  1,  250000),
	(2,  N'Điện',  50,  50000),
	(3,  N'DV gửi xe',  1,  50000),
	(4,  N'Nước',  5,  300000),
	(5,  N'Vệ sinh môi trường',  1,  300000);

SELECT * FROM dbo.tbl_DichVu

-- Chèn dữ liệu vào bảng Phòng
INSERT INTO tbl_Phong  
VALUES 
	(1,  N'P01',1),
	(2,  N'P02',2),
	(3,  N'P03',2),
	(4,  N'P04',1),
	(5,  N'P05',1),
	(6,  N'P06',2),
	(7,  N'P07',1);

SELECT * FROM dbo.tbl_Phong


-- Chèn dữ liệu vào bảng Hóa đơn 
INSERT INTO tbl_HoaDon  
VALUES
	(1,	1,	2,	1,'2021-05-05', N'Đã đóng'),
	(2,	2,	1,	2,'2021-02-01', N'Đã đóng'),
	(3,	4,	4,	3,'2020-04-15', N'Chưa đóng'),
	(4,	5,	3,	4,'2020-08-01', N'Đã đóng'),
	(5,	3,	4,	5,'2019-03-01', N'Chưa đóng'),
	(6,	6,	2,	6,'2019-07-22', N'Chưa đóng'),
	(7,	7,	1,	7,'2018-09-29', N'Đã đóng');

SELECT * FROM dbo.tbl_HoaDon


-- Chèn dữ liệu vào bảng chi tiết hóa đơn 
INSERT INTO tbl_ChiTietHoaDon  
VALUES 
(2,1,'2020-11-13',  N'Chưa đóng'),
(2,2,'2020-11-13',  N'Đã đóng'),
(2,3,'2020-11-10',  N'Đã đóng'),
(3,4,'2021-07-05',  N'Chưa đóng'),
(4,3,'2021-06-03',  N'Chưa đóng'),
(4,1,'2020-12-03',  N'Đã đóng'),
(5,1,'2020-12-05',  N'Chưa đóng'),
(5,2,'2021-03-05',  N'Chưa đóng'),
(6,3,'2021-02-05',  N'Chưa đóng'),
(1,4,'2019-08-22',  N'Chưa đóng'),
(1,3,'2019-09-22',  N'Đã đóng'),
(7,2,'2021-08-22',  N'Đã đóng');
DELETE FROM dbo.tbl_ChiTietHoaDon

SELECT * FROM dbo.tbl_ChiTietHoaDon


/* -- Truy vấn dữ liệu -- */
---* Truy vấn 1 bảng * --
-- 1.  Lấy  ra  họ  tên,  giới  tính,  ngày  sinh  của  những  nhân  viên  nữ 
SELECT sTenNV, sGioitinh,dNgaysinh
FROM dbo.tbl_NhanVien WHERE sGioitinh = N'Nữ';

-- 2.  Lấy  ra  những  khách  hàng  sinh  năm  1997 
SELECT * FROM dbo.tbl_KhachHang
WHERE YEAR(dNgaysinh) = 1997;

-- 3.  Đưa  ra  mã  dịch  vụ,  tên  dịch  vụ  có  tổng  tiền  của  dịch  vụ  nhỏ  hơn  200000 
SELECT iMaDV,sTenDV, SUM(iSoluong*fGiaDV) AS TongTien
FROM dbo.tbl_DichVu GROUP BY iMaDV, sTenDV
HAVING SUM(iSoluong*fGiaDV)<200000;

-- 4.  Đưa  ra  tuổi  cao  nhất  của  khách  hàng
SELECT TOP 1 sTenKH, MAX(YEAR(GETDATE())-YEAR(dNgaysinh))  AS TuoiMax
FROM dbo.tbl_KhachHang GROUP BY sTenKH
ORDER BY TuoiMax DESC;

-- 5.  Lấy  ra  những  khách  hàng  có  địa  chỉ  ở  Bắc  Giang 
SELECT * FROM  dbo.tbl_KhachHang
WHERE sDiachi=N'Bắc  Giang';

-- Truy vấn từ nhiều bảng
-- 1. Lấy  ra  họ  tên  những  khách  hàng  đã  trả  thuê  phòng  trong  năm  2020
SELECT dbo.tbl_HoaDon.iMaKH, dbo.tbl_KhachHang.sTenKH,  dbo.tbl_HoaDon.sTrangthai 
FROM dbo.tbl_KhachHang INNER JOIN dbo.tbl_HoaDon 
ON tbl_HoaDon.iMaKH = tbl_KhachHang.iMaKH
INNER JOIN dbo.tbl_ChiTietHoaDon  
ON tbl_ChiTietHoaDon.iMaHD = tbl_HoaDon.iMaHD 
WHERE tbl_ChiTietHoaDon.sTrangthai = N'đã đóng' 
AND YEAR(dNgaythutien) = 2020
GROUP BY dbo.tbl_HoaDon.iMaKH, dbo.tbl_KhachHang.sTenKH,  dbo.tbl_HoaDon.sTrangthai;

-- 2.  Tính  tổng  tiền  các  dịch  vụ  mà  mỗi  khách  hàng  phải  trả 
SELECT dbo.tbl_HoaDon.iMaHD, dbo.tbl_KhachHang.sTenKH, SUM(dbo.tbl_DichVu.iSoluong*dbo.tbl_DichVu.fGiaDV)  AS  TongTien
FROM dbo.tbl_KhachHang INNER JOIN dbo.tbl_HoaDon  
ON tbl_HoaDon.iMaKH = tbl_KhachHang.iMaKH
INNER JOIN  dbo.tbl_ChiTietHoaDon 
ON tbl_ChiTietHoaDon.iMaHD = tbl_HoaDon.iMaHD 
INNER JOIN  dbo.tbl_DichVu  
ON tbl_DichVu.iMaDV = tbl_ChiTietHoaDon.iMaDV
GROUP BY dbo.tbl_HoaDon.iMaHD, dbo.tbl_KhachHang.sTenKH;

--3.  Đếm  số  hoá  đơn  đã  lập  của  từng  nhân  viên
SELECT dbo.tbl_HoaDon.iMaNV, dbo.tbl_NhanVien.sTenNV,  COUNT(dbo.tbl_HoaDon.iMaHD) AS TongHD
FROM dbo.tbl_HoaDon  
INNER JOIN dbo.tbl_NhanVien  
ON tbl_NhanVien.iMaNV = tbl_HoaDon.iMaNV
GROUP BY dbo.tbl_HoaDon.iMaNV, dbo.tbl_NhanVien.sTenNV 
ORDER BY COUNT(dbo.tbl_HoaDon.iMaHD) DESC

--4.  Cho  biết  danh  sách  mã  hóa  đơn  có  nhân  viên  lập  giới  tính  là  nữ 
SELECT iMaHD, sGioitinh FROM dbo.tbl_HoaDon  
INNER JOIN dbo.tbl_NhanVien 
ON tbl_NhanVien.iMaNV = tbl_HoaDon.iMaNV
WHERE sGioitinh=N'Nữ';

--5.  Cho  biết  danh  sách  những  khách  hàng  chưa  trả  tiền  dịch  vụ  nào  trong  tháng  11 
SELECT dbo.tbl_HoaDon.iMaKH, dbo.tbl_KhachHang.sTenKH,  dbo.tbl_DichVu.sTenDV, dbo.tbl_ChiTietHoaDon.sTrangthai
FROM dbo.tbl_HoaDon 
INNER JOIN dbo.tbl_KhachHang  
ON tbl_KhachHang.iMaKH = tbl_HoaDon.iMaKH
INNER JOIN dbo.tbl_ChiTietHoaDon  
ON tbl_ChiTietHoaDon.iMaHD = tbl_HoaDon.iMaHD
INNER  JOIN  dbo.tbl_DichVu 
ON tbl_DichVu.iMaDV = tbl_ChiTietHoaDon.iMaDV
WHERE MONTH(dNgaythutien)=11 
AND tbl_ChiTietHoaDon.sTrangthai=N'Chưa đóng';
GO

/*  --  TẠO  VIEW  (10  CÂU)  --*/
--1. Tạo view cho biết những khách hàng đã đóng tiền dịch vụ  và tiền phòng 
CREATE VIEW vw_KHDongTien
AS
SELECT tbl_HoaDon.iMaKH,tbl_KhachHang.sTenKH
FROM tbl_KhachHang  
INNER JOIN tbl_HoaDon  
ON tbl_HoaDon.iMaKH = tbl_KhachHang.iMaKH
INNER JOIN tbl_ChiTietHoaDon 
ON tbl_ChiTietHoaDon.iMaHD = tbl_HoaDon.iMaHD 
WHERE tbl_HoaDon.sTrangthai = N'Đã thuê' 
AND tbl_HoaDon.iMaHD NOT IN 
(SELECT iMaHD FROM dbo.tbl_ChiTietHoaDon WHERE sTrangthai = N'Chưa đóng')
GROUP BY tbl_HoaDon.iMaKH, dbo.tbl_KhachHang.sTenKH
GO
SELECT * FROM dbo.tbl_HoaDon

SELECT * FROM vw_KhDongTien;
GO

--2. Tạo view cho biết tổng tiền dịch vụ của từng hoá đơn
CREATE VIEW vwTongTienDV
AS
SELECT dbo.tbl_ChiTietHoaDon.iMaHD,SUM(fGiaDV*iSoluong) AS  TongTienDV 
FROM dbo.tbl_DichVu 
INNER JOIN dbo.tbl_ChiTietHoaDon
ON tbl_ChiTietHoaDon.iMaDV = tbl_DichVu.iMaDV 
GROUP BY dbo.tbl_ChiTietHoaDon.iMaHD;
GO
SELECT * FROM vwTongTienDV;
GO

--3. Tạo view cho biết 3 khách hàng đã trả nhiều tiền nhất 
CREATE VIEW vwTop3KH
AS
SELECT TOP 3 dbo.tbl_ChiTietHoaDon.iMaHD,  dbo.tbl_KhachHang.sTenKH, (dbo.tbl_LoaiPhong.fGiaphong+SUM(dbo.tbl_DichVu.iSoluong*dbo.tbl_DichVu.fGiaDV))
AS Tongtien
FROM dbo.tbl_HoaDon  
INNER JOIN dbo.tbl_KhachHang  
ON tbl_KhachHang.iMaKH = tbl_HoaDon.iMaKH
INNER JOIN dbo.tbl_ChiTietHoaDon  
ON tbl_ChiTietHoaDon.iMaHD = tbl_HoaDon.iMaHD
INNER JOIN dbo.tbl_Phong 
ON tbl_Phong.iMaPhong = tbl_HoaDon.iMaPhong 
INNER JOIN dbo.tbl_LoaiPhong 
ON tbl_LoaiPhong.iMaLP = tbl_Phong.iMaLP 
INNER JOIN dbo.tbl_DichVu  
ON tbl_DichVu.iMaDV = tbl_ChiTietHoaDon.iMaDV
GROUP BY dbo.tbl_ChiTietHoaDon.iMaHD,  dbo.tbl_KhachHang.sTenKH, dbo.tbl_LoaiPhong.fGiaphong 
ORDER BY Tongtien DESC;
GO
SELECT * FROM vwTop3KH;
GO

--4. Tạo view thống kê số lượng nhân viên theo giới tính 
CREATE VIEW vwSlGioiTinh 
AS
SELECT dbo.tbl_NhanVien.sGioitinh,  COUNT(dbo.tbl_NhanVien.iMaNV) AS SoLuong 
FROM dbo.tbl_NhanVien
WHERE sGioitinh=N'Nam' 
OR sGioitinh=N'Nữ' 
GROUP BY dbo.tbl_NhanVien.sGioitinh;
GO

SELECT * FROM vwSlGioiTinh;
GO

--5. Tạo view thống kê số lượng khách hàng có độ tuổi > 21 
CREATE VIEW vwSlKh22
AS
SELECT (CONVERT(INT, GETDATE()-dbo.tbl_KhachHang.dNgaysinh)/365) AS Dotuoi, COUNT(dbo.tbl_KhachHang.iMaKH) AS SoKH
FROM dbo.tbl_KhachHang
WHERE CONVERT(INT, GETDATE()-dNgaysinh)/365 > 21
GROUP BY CONVERT(INT, GETDATE()-dbo.tbl_KhachHang.dNgaysinh)/365;
GO

SELECT * FROM vwSlKh22;
GO 

--6. Đưa ra danh sách khách hàng đã đóng tiền phòng nhưng chưa đóng tiền dịch vụ nào trong tháng 11
CREATE VIEW vwKHchuadongDVT11 
AS
SELECT dbo.tbl_HoaDon.iMaKH, dbo.tbl_KhachHang.sTenKH,  dbo.tbl_DichVu.sTenDV, dbo.tbl_ChiTietHoaDon.sTrangthai
FROM dbo.tbl_HoaDon 
INNER JOIN dbo.tbl_KhachHang 
ON tbl_KhachHang.iMaKH = tbl_HoaDon.iMaKH
INNER JOIN dbo.tbl_ChiTietHoaDon 
ON tbl_ChiTietHoaDon.iMaHD = tbl_HoaDon.iMaHD
INNER JOIN dbo.tbl_DichVu 
ON tbl_DichVu.iMaDV = tbl_ChiTietHoaDon.iMaDV
WHERE tbl_HoaDon.sTrangthai = N'Đã thuê' 
AND tbl_ChiTietHoaDon.sTrangthai = N'Chưa đóng'
AND MONTH(dbo.tbl_ChiTietHoaDon.dNgaythutien) = 11
GO

SELECT * FROM vwKHchuadongDVT11
GO

--7.Tạo view tính trung bình cộng tiền dịch vụ phải trả trong năm 2020 
CREATE VIEW vwTBCtienDV2020
AS
SELECT dbo.tbl_HoaDon.iMaHD, AVG(dbo.tbl_DichVu.iSoluong*dbo.tbl_DichVu.fGiaDV) AS TBC
FROM dbo.tbl_HoaDon  
INNER JOIN dbo.tbl_ChiTietHoaDon 
ON tbl_ChiTietHoaDon.iMaHD = tbl_HoaDon.iMaHD
INNER JOIN dbo.tbl_DichVu  
ON tbl_DichVu.iMaDV = tbl_ChiTietHoaDon.iMaDV
WHERE YEAR(dNgaythutien) = 2020
GROUP BY dbo.tbl_HoaDon.iMaHD 
GO

SELECT * FROM vwTBCtienDV2020
GO
--8. Tạo view cho biết danh sách khách hàng ở phòng Vip 
CREATE VIEW vwKHVIP
AS
SELECT dbo.tbl_KhachHang.iMaKH,dbo.tbl_LoaiPhong.sTenLP, dbo.tbl_KhachHang.sTenKH, COUNT(dbo.tbl_KhachHang.iMaKH) AS Soluong
FROM dbo.tbl_KhachHang 
INNER JOIN dbo.tbl_HoaDon  
ON tbl_HoaDon.iMaKH = tbl_KhachHang.iMaKH
INNER JOIN dbo.tbl_Phong  
ON tbl_Phong.iMaPhong = tbl_HoaDon.iMaPhong 
INNER JOIN dbo.tbl_LoaiPhong  
ON tbl_LoaiPhong.iMaLP = tbl_Phong.iMaLP 
WHERE dbo.tbl_LoaiPhong.sTenLP= N'Vip'
GROUP BY dbo.tbl_KhachHang.iMaKH,dbo.tbl_LoaiPhong.sTenLP, dbo.tbl_KhachHang.sTenKH
GO

SELECT * FROM vwKHVIP
GO

--9. Tạo view cho biết nhân viên nào có lương cao nhất 
CREATE VIEW vw_NVluongMax
AS
SELECT TOP 1 dbo.tbl_NhanVien.iMaNV,  dbo.tbl_NhanVien.sTenNV, SUM(dbo.tbl_NhanVien.fLuongcoban+dbo.tbl_NhanVien.fPhucap)  AS Luong FROM dbo.tbl_NhanVien
GROUP BY dbo.tbl_NhanVien.iMaNV, dbo.tbl_NhanVien.sTenNV ORDER BY Luong DESC
GO

SELECT * FROM vw_NVluongMax
GO

--10.  Tạo  view  cho  biết  nhân  viên  có  tuổi  cao  nhất 
CREATE VIEW  vwNVtuoiMAX
AS
SELECT TOP 1 dbo.tbl_NhanVien.iMaNV,  dbo.tbl_NhanVien.sTenNV, (CONVERT(INT, GETDATE()-dbo.tbl_NhanVien.dNgaysinh)/365) AS Tuoi FROM dbo.tbl_NhanVien
GROUP BY dbo.tbl_NhanVien.iMaNV, dbo.tbl_NhanVien.sTenNV, dbo.tbl_NhanVien.dNgaysinh
ORDER BY Tuoi DESC;
GO

SELECT * FROM vwNVtuoiMAX
GO


/*  --------------TẠO  STORED  PROCEDURE  HIỆN  DỮ  LIỆU  (10  CÂU) 	*/
--1. Tạo Stored Procedure có tham số truyền vào là tháng, cho biết những khách hàng nào chưa trả tiền phòng trong tháng đó.
CREATE PROCEDURE sp_KhachHangChuaTraTienPhong 
@Month DATETIME
AS
BEGIN
SELECT dbo.tbl_HoaDon.iMaKH, dbo.tbl_KhachHang.sTenKH, dbo.tbl_HoaDon.sTrangthai
	FROM dbo.tbl_KhachHang 
	INNER JOIN dbo.tbl_HoaDon
	ON tbl_HoaDon.iMaKH = tbl_KhachHang.iMaKH
	WHERE dbo.tbl_KhachHang.iMaKH IN (SELECT iMaKH FROM dbo.tbl_HoaDon
	INNER JOIN dbo.tbl_ChiTietHoaDon 
ON tbl_ChiTietHoaDon.iMaHD = tbl_HoaDon.iMaHD
WHERE MONTH(dNgaythutien) = @Month
AND  dbo.tbl_HoaDon.sTrangthai  =  N'Chưa đóng')
END
GO

--DROP PROC dbo.sp_KhachHangChuaTraTienPhong

EXECUTE sp_KhachHangChuaTraTienPhong 12;
GO



--2. Viết thủ tục:
-- Tham số truyền vào: năm, mã loại phòng
-- Thực hiện tăng giá loại phòng lên gấp rưỡi cho những phòng thuộc loại phòng Thường
CREATE PROCEDURE sp_TangGiaPhong
	@Year DATE,@MaLP INT 
AS
BEGIN
	UPDATE dbo.tbl_LoaiPhong SET fGiaphong=fGiaphong*1.5
	WHERE dbo.tbl_LoaiPhong.iMaLP IN (SELECT iMaLP FROM  dbo.tbl_Phong WHERE sTenLP = N'Thường')
END
GO

EXECUTE sp_TangGiaPhong '2020','1';
GO

SELECT * FROM dbo.tbl_LoaiPhong
GO

--3. Tạo thủ tục thống kê tổng số hoá đơn đã lập của từng nhân viên 
CREATE PROCEDURE sp_ThongKeSoHD
	@MaNV INT 
AS
BEGIN
	SELECT dbo.tbl_NhanVien.iMaNV, dbo.tbl_NhanVien.sTenNV, COUNT(dbo.tbl_ChiTietHoaDon.iMaHD) AS TongSoHD
	FROM dbo.tbl_NhanVien
	INNER JOIN dbo.tbl_HoaDon ON tbl_HoaDon.iMaNV = tbl_NhanVien.iMaNV
	INNER JOIN dbo.tbl_ChiTietHoaDon ON tbl_ChiTietHoaDon.iMaHD = tbl_HoaDon.iMaHD
	WHERE dbo.tbl_NhanVien.iMaNV=@MaNV
	GROUP BY dbo.tbl_NhanVien.iMaNV, dbo.tbl_NhanVien.sTenNV
END
GO

EXECUTE sp_ThongKeSoHD '1';
GO
 
--4. Tạo thủ tục có tham số truyền vào là năm, cho biết trung bình cộng tiền dịch vụ phải trả của từng khách hàng
CREATE PROC sp_TBCTienDV
	@Year DATETIME
AS
BEGIN
	SELECT dbo.tbl_KhachHang.iMaKH,  dbo.tbl_KhachHang.sTenKH,
	AVG(dbo.tbl_DichVu.fGiaDV*dbo.tbl_DichVu.iSoluong) AS TongtienDV FROM dbo.tbl_KhachHang
	INNER JOIN dbo.tbl_HoaDon  
	ON tbl_HoaDon.iMaKH = tbl_KhachHang.iMaKH 
	INNER JOIN dbo.tbl_ChiTietHoaDon 
	ON tbl_ChiTietHoaDon.iMaHD = tbl_HoaDon.iMaHD
	INNER JOIN dbo.tbl_DichVu 
	ON tbl_DichVu.iMaDV = tbl_ChiTietHoaDon.iMaDV
	WHERE YEAR(dNgaythutien) = YEAR(@Year)
	GROUP BY dbo.tbl_KhachHang.iMaKH, dbo.tbl_KhachHang.sTenKH
END
GO

EXEC sp_TBCTienDV '2021';
GO

--5. Tạo thủ tục có tham số truyền vào là tên dịch vụ, cho biết có bao nhiêu phòng sử dụng dịch vụ trên
CREATE PROC sp_PhongSuDungDV 
	@TenDV NVARCHAR(50)
AS
BEGIN
	SELECT dbo.tbl_DichVu.sTenDV,  COUNT(dbo.tbl_Phong.iMaPhong) AS SoPhongSuDungDV
	FROM dbo.tbl_Phong
	INNER JOIN dbo.tbl_HoaDon 
	ON tbl_HoaDon.iMaPhong = tbl_Phong.iMaPhong 
	INNER JOIN dbo.tbl_ChiTietHoaDon 
	ON tbl_ChiTietHoaDon.iMaHD = tbl_HoaDon.iMaHD
	INNER JOIN dbo.tbl_DichVu 
	ON tbl_DichVu.iMaDV = tbl_ChiTietHoaDon.iMaDV
	WHERE dbo.tbl_DichVu.sTenDV = @TenDV 
	GROUP BY dbo.tbl_DichVu.sTenDV
END
GO

EXEC sp_PhongSuDungDV N'DV gửi xe';
GO

--6. Tạo thủ tục cho biết danh sách nhân viên đã lập hoá đơn trong ngày với ngày là tham số truyền vào
CREATE PROC sp_NVLapHDVoiNgay 
	@Ngay DATETIME
AS
BEGIN
	SELECT dbo.tbl_HoaDon.iMaNV, dbo.tbl_NhanVien.sTenNV, dbo.tbl_HoaDon.dNgaylap
	FROM dbo.tbl_HoaDon 
	INNER JOIN dbo.tbl_NhanVien 
	ON tbl_NhanVien.iMaNV = tbl_HoaDon.iMaNV
	WHERE DAY(dNgaylap) = DAY(@Ngay);
END
GO

EXEC sp_NVLapHDVoiNgay '2020-11-01';
GO

--7. Viết thủ tục:
-- Tham số truyền vào là mã khách hàng
-- Thực hiện kiểm tra xem khách hàng đã đóng tiền phòng hay chưa 
CREATE PROC sp_CkDongTien
	@MaKH INT
AS
BEGIN
	SELECT dbo.tbl_HoaDon.iMaKH, dbo.tbl_KhachHang.sTenKH, dbo.tbl_HoaDon.sTrangthai
	FROM dbo.tbl_HoaDon
	INNER JOIN dbo.tbl_KhachHang  
	ON tbl_KhachHang.iMaKH = tbl_HoaDon.iMaKH
	WHERE dbo.tbl_HoaDon.iMaKH = @MaKH
END
GO

EXEC sp_CkDongTien '1'
GO

--8. Tạo thủ tục lấy ra danh sách khách hàng thuộc loại phòng và đã đóng tiền chưa 
CREATE PROC sp_DSKHLoaiPhong
	@LoaiPhong NVARCHAR(50) 
AS
BEGIN
	SELECT dbo.tbl_HoaDon.iMaKH, dbo.tbl_KhachHang.sTenKH, dbo.tbl_LoaiPhong.sTenLP, dbo.tbl_HoaDon.sTrangthai
	FROM dbo.tbl_KhachHang  
	INNER JOIN dbo.tbl_HoaDon  
	ON tbl_HoaDon.iMaKH = tbl_KhachHang.iMaKH
	INNER JOIN dbo.tbl_Phong  
	ON tbl_Phong.iMaPhong = tbl_HoaDon.iMaPhong 
	INNER JOIN dbo.tbl_LoaiPhong  
	ON tbl_LoaiPhong.iMaLP = tbl_Phong.iMaLP 
	WHERE sTenLP = N'Vip'
END
GO

EXEC sp_DSKHLoaiPhong N'Vip'
GO

--9. Tạo thủ tục lấy ra danh sách nhân viên theo độ tuổi, có  tuổi là tham số truyền vào
CREATE PROC sp_DSNvTheoDoTuoi 
	@Tuoi INT
AS
BEGIN
	SELECT dbo.tbl_NhanVien.iMaNV, dbo.tbl_NhanVien.sTenNV,  (CONVERT(INT,GETDATE() - dbo.tbl_NhanVien.dNgaysinh))/365  AS  Tuoi 
	FROM dbo.tbl_NhanVien
	WHERE ((CONVERT(INT, GETDATE() - dbo.tbl_NhanVien.dNgaysinh))/365) = @Tuoi
END
GO
 
EXEC sp_DSNvTheoDoTuoi 24
GO

--10. Viết thủ tục:
-- Tham số truyền vào là tên dịch vụ
-- Thực hiện giảm giá 50% cho những khách hàng sử dụng dịch  vụ đó 
CREATE PROC sp_GiamGiaDV
	@TenDV NVARCHAR(50)
AS
BEGIN
	UPDATE dbo.tbl_DichVu SET fGiaDV = fGiaDV*0.5
	WHERE sTenDV = @TenDV
END 
GO

EXEC sp_GiamGiaDV N'DV mạng internet'
GO



/* 	========TẠO  TRIGGER  (10  câu)======== 	*/
--1.  Tạo  trigger  kiểm  tra  tuổi  của  nhân  viên 
CREATE  TRIGGER  ck_TuoiNV
ON  tbl_NhanVien 
AFTER  INSERT
AS
BEGIN
	DECLARE  @Ngaysinh  DATETIME
	SET  @Ngaysinh  =  (SELECT  dNgaysinh  FROM  INSERTED) 
	IF  (CONVERT(INT,  GETDATE()  -  @Ngaysinh)/365  <15)
		BEGIN
			PRINT  N'Chưa  đủ  tuổi  đi  làm  !'; 
			ROLLBACK  TRANSACTION
		END
	ELSE
			PRINT  N'Đã  đủ  tuổi  đi  làm  !  Nhập  thành  công  !'
END 
GO

INSERT  INTO  tbl_NhanVien 
VALUES 
(9,  N'Đỗ  Thu  Huyền  Trang',N'Nữ', '2005-10-25','0397086560','2020-12-22',3500000,270);

SELECT  *  FROM  dbo.tbl_NhanVien
GO
--2.  Tạo  trigger  kiểm  tra  tính  chính  xác  của  số  điện  thoại  nhập  vào  của  nhân  viên 
CREATE  TRIGGER  ck_SDTNv
ON  dbo.tbl_NhanVien
FOR  INSERT,  UPDATE 
AS
BEGIN
	DECLARE  @SDT  VARCHAR(10)
	SET  @SDT  =  (SELECT  sSoDT  FROM  Inserted)
		IF  (LEN(@SDT)>10  OR  LEN(@SDT)<10  OR  LEFT(@SDT,1)  !=  '0') 
			BEGIN
				PRINT  N'Số  điện  thoại:  '+  @SDT  +  N'  không  hợp  lệ  !'
				PRINT  N'Số  điện  thoại  phải  có  10  số  và  bắt  đầu  bằng  số  0  !'
				ROLLBACK TRAN
			END
END
GO

INSERT  INTO  tbl_NhanVien  VALUES  (11,  N'Nguyễn  Hàn  Trọng  Vĩ',N'Nam', '1998-10-22','0976108761','2016-10-22',4500000,150);
UPDATE  dbo.tbl_NhanVien  SET  sSoDT='69696969696' WHERE  iMaNV  =  11
SELECT  *  FROM  tbl_NhanVien;
GO

--3.  Tạo  trigger  kiểm  soát  giới  tính  của  nhân  viên  chỉ  là  nam  hoặc  nữ 
CREATE  TRIGGER  ck_GTNv
ON  dbo.tbl_NhanVien 
FOR  INSERT,  UPDATE 
AS
BEGIN
	DECLARE  @Gt  NVARCHAR(10)
	SET  @Gt  =  (SELECT  sGioitinh  FROM  Inserted)
	IF  (@Gt  NOT  IN  (N'Nam',N'Nữ'))
		BEGIN
			PRINT  N'Giới  tính  '+@Gt+  N'  không  hợp  lệ  !' 
			ROLLBACK TRAN
		END 
		ELSE
			PRINT  N'Giới  tính  hợp  lệ  !  Nhập  thành  công  !'
END 

--DROP  TRIGGER  ck_GTNv 
GO

INSERT  INTO  tbl_NhanVien  VALUES  (12,  N'Lê  Phương  Mai',N'Nữ', '1993-12-14','0397086960','2015-12-09',3540000,220);
UPDATE  dbo.tbl_NhanVien  SET  sGioitinh=  N'Nữ' WHERE  iMaNV  =  '12'
SELECT  *  FROM  tbl_NhanVien;
GO

--4.  Tạo  trigger  kiểm  soát  ngày  lập  phải  nhỏ  hơn  ngày  thu  tiền 
CREATE  TRIGGER  ck_NgayLap
ON  tbl_ChiTietHoaDon 
FOR  INSERT,  UPDATE 
AS
BEGIN
	DECLARE  @Ngaylap  DATETIME,  @Ngaythutien  DATETIME
	SET  @Ngaylap  =  (SELECT  dNgaylap  FROM  dbo.tbl_HoaDon,inserted
	WHERE  tbl_HoaDon.iMaHD  =  inserted.iMaHD)
	SET  @Ngaythutien  =  (SELECT  dNgaythutien  FROM  inserted) 
	IF  (@Ngaylap>@Ngaythutien)
		PRINT  N'Nhập  sai  !  Ngày  lập  hóa  đơn  phải  nhỏ  hơn  ngày  thu tiền'
	ELSE
		PRINT  N'Ngày  lập  hóa  đơn  thỏa  mãn  !  Nhập  thành  công  !'
END

INSERT  INTO  tbl_ChiTietHoaDon  VALUES  (7,3,'2017-10-26',  N'Đã  đóng');

SELECT  *  FROM  tbl_ChiTietHoaDon;
GO

--5.  Tạo  trigger  giới  hạn  tuổi  làm  việc  của  nhân  viên  nam  và  nữ 
CREATE  TRIGGER  ck_doTuoi
ON  tbl_NhanVien 
FOR  INSERT,  UPDATE 
AS 
BEGIN
	DECLARE  @Tuoi  INT
	SET  @Tuoi=  (SELECT  YEAR(GETDATE())-YEAR(dNgaysinh)  FROM  inserted) 
	IF  (@Tuoi>50)
	BEGIN
		PRINT  N'Đã  quá  tuổi  đi  làm  !  Nhập  không  thành  công' 
		ROLLBACK  TRANSACTION
	END
	ELSE
		PRINT  N'Độ  tuổi  thỏa  mãn  !  Nhập  thành  công  !'
END
GO
INSERT  INTO  tbl_NhanVien  
VALUES  
(13,N'Nguyễn  Văn  Tiến',N'Nam', '1990-09-28','0397086390','2016-09-28',2300000,200);

SELECT  *  FROM  tbl_NhanVien;
GO

--6.  Tạo  trigger  không  cho  sửa  trường  mã  hoá  đơn  trong  bảng  tbl_ChiTietHoaDon 
CREATE  TRIGGER  TG_KoSuaHD
ON  tbl_ChiTietHoaDon 
AFTER UPDATE
AS
BEGIN
	IF  UPDATE(iMaHD)
	BEGIN
		PRINT  N'Không  được  sửa  mã  hóa  đơn  trong  bảng tbl_ChiTietHoaDon!'
		ROLLBACK  TRANSACTION
	END
END
 
UPDATE  dbo.tbl_ChiTietHoaDon  SET  iMaHD  =  2  WHERE  iMaHD  =13
GO

--7.  Tạo  trigger  kiểm  soát  ngày  vào  làm  phải  sau  ngày  sinh 
CREATE  TRIGGER  TG_NgayVaoLam
ON  tbl_NhanVien 
FOR  INSERT,  UPDATE
AS
BEGIN
	IF  UPDATE(dNgayvaolam)
		BEGIN
			DECLARE  @Ngayvaolam  DATETIME,  @Ngaysinh  DATETIME 
			SELECT  @Ngayvaolam  =  dNgayvaolam  FROM  Inserted 
			SELECT  @Ngaysinh  =  dNgaysinh FROM Inserted
			IF (@Ngayvaolam<@Ngaysinh) 
			BEGIN
				PRINT N'Ngày  vào  làm  phải  lớn  hơn  ngày sinh'
				ROLLBACK TRANSACTION
			END
			ELSE 
				PRINT N'Update/Insert độ tuổi đã hợp lệ!'
		END
END

INSERT  INTO  tbl_NhanVien  VALUES  (15,N'Lỗ  Hồng  Quân',
N'Nam','1996-09- 28','0397086390','2015-08-20',2300000,160);

SELECT * FROM dbo.tbl_NhanVien
GO 

--8.  Tạo  trigger  không  thể  thay  đổi  đơn  giá  trong  bảng  tbl_DichVu 
CREATE  TRIGGER  TG_KhongdoidongiaDV
ON  tbl_DichVu 
FOR UPDATE
AS
BEGIN
	IF UPDATE(fGiaDV) BEGIN
		PRINT N'Không  thể  đổi  đơn  giá  trong  bảng  Dịch  Vụ  !' 
		ROLLBACK  TRANSACTION
		END
END
GO

UPDATE  tbl_DichVu  SET  fGiaDV  =  250000  WHERE  fGiaDV  =  200000;
GO
--9.  Tạo  trigger  kiểm  soát  nhân  viên  có  mã  nhân  viên  là  1,3,4  mới  được  lập  hoá  đơn 
CREATE  TRIGGER  sp_KiemSoatNVLapHD
ON  tbl_HoaDon
FOR  INSERT,  UPDATE 
AS
BEGIN
	DECLARE @MaNV1 INT
	SELECT  @MaNV1  =  (SELECT  iMaNV  FROM  inserted)
	IF  (@MaNV1  !=  1  and  @MaNV1  !=  4  and  @MaNV1  !=  3)
	BEGIN
		PRINT  N'Chỉ nhân viên có mã nhân viên là  1, 3, 4 mới được lập hóa  đơn'
		ROLLBACK  TRANSACTION
	END
END
GO

INSERT  INTO  tbl_HoaDon  VALUES  (9,  5,  3,  4,'2017-10-29',  N'Đã  thuê');
GO

SELECT  *  FROM  dbo.tbl_HoaDon 
SELECT  *  FROM  tbl_HoaDon;
GO

--10.  Tạo  trigger  kiểm  soát  giới  tính  của  khách  hàng  chỉ  là  nam  hoặc  nữ 
CREATE  TRIGGER  sp_GTKhachHang
ON  tbl_KhachHang 
FOR  INSERT,  UPDATE 
AS
BEGIN
	DECLARE  @GT  NVARCHAR(10)
	SET  @GT  =  (SELECT  sGioitinh  FROM  inserted) 
	IF  (@GT  NOT  IN  (N'Nam',  N'Nữ'))
		BEGIN
			PRINT  N'Giới  tính  khách  hàng  bạn  nhập  không  hợp  lệ  !' ROLLBACK  TRANSACTION
		END
		ELSE
		PRINT  N'Giới  tính  khách  hàng  hợp  lệ  !'
END
GO

INSERT  INTO  tbl_KhachHang  VALUES  (9, N'Nữ',  N'Phú  Thọ', '1999-02-11',  '01696772118'  ,  '143811921',N'Lê  Kim  Thủy');
SELECT  *  FROM  dbo.tbl_KhachHang
GO

------------------------ Cấp quyền và phân quyền ------------------------------------
-- Tạo tài khoản người dùng cho mỗi thành viên trong nhóm
CREATE LOGIN AnhDung WITH PASSWORD = '123456',
DEFAULT_DATABASE = BTL;
CREATE USER Dung FOR LOGIN AnhDung;
GO

CREATE LOGIN DangDong WITH PASSWORD = '123456',
DEFAULT_DATABASE = BTL;
CREATE USER Dong FOR LOGIN DangDong;
GO

CREATE LOGIN PhuongNam WITH PASSWORD = '123456',
DEFAULT_DATABASE = BTL;
CREATE USER Nam FOR LOGIN PhuongNam;
GO

CREATE LOGIN TuThang WITH PASSWORD = '123456',
DEFAULT_DATABASE = BTL;
CREATE USER Thang FOR LOGIN TuThang;
GO 
-- Phân quyền
-- Cấp phát cho người dùng có tên Dung quyền thực thi ALL trên bảng tbl_NhanVien
GRANT ALL PRIVILEGES
ON dbo.tbl_NhanVien
TO Dung;

-- Cấp phát cho người dùng Dong quyền SELECT, INSERT, UPDATE, DELETE và REFERENCES 
-- trên bảng tbl_KhachHang và được chuyển tiếp quyền cho người dùng khác
GRANT SELECT, UPDATE, DELETE, REFERENCES
ON dbo.tbl_KhachHang
TO Dong
WITH GRANT OPTION;

-- Cấp phát quyền tạo bảng, khung nhìn cho người dùng có tên là Nam
GRANT CREATE TABLE, CREATE VIEW
TO Nam;

-- Cáp phát cho người dùng Thang tất cả quyền cơ sở dữ liệu trên bảng tbl_HoaDon
GRANT ALL 
ON dbo.tbl_HoaDon
TO Thang;

-- Thu hồi quyền thực thi lệnh INSERT trên bảng tbl_NhanVien với người dùng Dung
REVOKE INSERT
ON dbo.tbl_NhanVien
TO Dung;

-- Không cho phép người dùng Dong thực hiện lệnh CREATE TABLE trên CSDL
REVOKE CREATE TABLE
TO Dong;

-- Cấm người dùng Nam DELETE trên bảng tbl_NhanVien
DENY DELETE
ON dbo.tbl_NhanVien
TO Nam;


-- Phân tán cơ sở dữ liệu
-- Linked Server 1 sang server 2
EXEC sys.sp_addlinkedserver @server = 'PhanTan',     -- sysname
                            @srvproduct = N'SQLServer',  -- nvarchar(128)
                            @provider = N'SQLNCLI',    -- nvarchar(128)
                            @datasrc = N'DESKTOP-3S2G78C\SQLEXPRESS'
EXEC sys.sp_linkedservers

EXEC sys.sp_addlinkedsrvlogin @rmtsrvname = 'PhanTan', -- sysname
                              @rmtuser = 'sa',    -- sysname
                              @rmtpassword = '123' -- sysname

EXEC sys.sp_dropserver @server = 'PhanTan',  -- sysname
                       @droplogins = 'droplogins' -- char(10)

-- Cơ sở dữ liệu Trạm 1
CREATE DATABASE QLThuPhiNCCTram1 COLLATE Vietnamese_CI_AS;
USE QLThuPhiNCCTram1;

-- Tạo các bảng
CREATE  TABLE  tbl_LoaiPhong1( 
	iMaLP  INT  NOT  NULL  PRIMARY  KEY, 
	sTenLP  NVARCHAR(50),
	fGiaphong  FLOAT
);

CREATE  TABLE  tbl_Phong1(
	iMaPhong  INT  NOT  NULL  PRIMARY  KEY,
	sTenphong  NVARCHAR(50), 
	iMaLP  INT  NOT  NULL,
	CONSTRAINT  FK_Phong_LP  FOREIGN  KEY  (iMaLP)  REFERENCES  tbl_LoaiPhong1(iMaLP)
);

CREATE  TABLE  tbl_KhachHang1( 
	iMaKH  INT  NOT  NULL  PRIMARY  KEY, 
	sTenKH  NVARCHAR(50),
	sGioitinh  NVARCHAR(10), 
	sDiachi  NVARCHAR(50), 
	dNgaysinh  DATETIME, 
	sSoDT  VARCHAR(11), 
	sSoCMND  VARCHAR(20)
);

CREATE  TABLE  tbl_NhanVien1(
	iMaNV  INT  NOT  NULL  PRIMARY  KEY, 
	sTenNV  NVARCHAR(50),
	sGioitinh  NVARCHAR(10), 
	dNgaysinh  DATETIME, 
	sSoDT  VARCHAR(11),
	dNgayvaolam  DATETIME, 
	fLuongcoban  FLOAT, 
	fPhucap  FLOAT
);

CREATE  TABLE  tbl_DichVu1(
	iMaDV  INT  NOT  NULL  PRIMARY  KEY, 
	sTenDV  NVARCHAR(50),
	iSoluong  INT, 
	fGiaDV  FLOAT
);

CREATE  TABLE  tbl_HoaDon1(
	iMaHD  INT  NOT  NULL  PRIMARY  KEY, 
	iMaKH  INT  NOT  NULL,
	iMaNV  INT  NOT  NULL,
	iMaPhong  INT  NOT  NULL, 
	dNgaylap  DATETIME, 
	sTrangthai  NVARCHAR(50),
	CONSTRAINT  FK_HD_KH  FOREIGN  KEY  (iMaKH)  REFERENCES  tbl_KhachHang1(iMaKH), 
	CONSTRAINT  FK_HD_NV  FOREIGN  KEY  (iMaNV)  REFERENCES  tbl_NhanVien1(iMaNV),
	CONSTRAINT  FK_HD_Phong  FOREIGN  KEY  (iMaPhong)  REFERENCES  tbl_Phong1(iMaPhong)
);

CREATE  TABLE  tbl_ChiTietHoaDon1( 
	iMaHD  INT  NOT  NULL,
	iMaDV  INT  NOT  NULL,
	dNgaythutien  DATETIME, sTrangthai  NVARCHAR(50),
	CONSTRAINT  PK_HD_DV  PRIMARY  KEY  (iMaHD,iMaDV),
	CONSTRAINT  FK_CTHD_DV  FOREIGN  KEY  (iMaDV)  REFERENCES  tbl_DichVu1(iMaDV), 
	CONSTRAINT  FK_CTHD_HD	FOREIGN  KEY  (iMaHD)  REFERENCES  tbl_HoaDon1(iMaHD)
);

-- Thêm loại phòng
INSERT  INTO  tbl_LoaiPhong1 
VALUES  
(1,  N'Thường',2000000),
(2,  N'Vip',  3000000);

-- Thêm nhân viên
INSERT  INTO  tbl_NhanVien1  
VALUES  
(1,N'Nguyễn  Văn  Hà',  N'Nam','1997-05-12','0954127736','2012-10-20',  4000000,  400),
(2,N'Nguyễn  Thị  Ngọc',  N'Nữ','1995-04-02','0165322997','2011-01-25',  3000000,  300),
(3,N'Dương  Văn  Hải',  N'Nam',  '1993-12-20','0963554723','2013-04-12',  3500000,  400);

-- Thêm khách hàng
INSERT  INTO  tbl_KhachHang1  
VALUES  
(1,  N'Nguyễn  Duy  Thành',  N'Nam',  N'Hà  Nội', '1998-05-07',  '0912345682'  ,  '122334757438'),
(2,  N'Nguyễn  Duy  Huỳnh',  N'Nam',  N'Hà  Nội', '1998-01-24',  '01657234971'  ,'126567579'),
(3,  N'Đỗ  Thị  Tuyên',  N'Nữ',  N'Hà  Nội','1998-10- 22',  '0936627112'  ,'122246565863');

--  Thêm dịch vụ
INSERT  INTO  tbl_DichVu1 
VALUES  
(1,  N'DV  mạng  internet',  1,  250000),
(2,  N'Điện',  50,  200000),
(3,  N'DV  gửi  xe',  1,  50000),
(4,  N'Nước',  5,  100000),
(5,  N'Vệ  sinh  môi  trường',  1,  70000);

-- Thêm phòng
INSERT  INTO  tbl_Phong1  
VALUES 
(1,  N'P01',1),
(2,  N'P02',2),
(3,  N'P03',2),
(4,  N'P04',1),
(5,  N'P05',1),
(6,  N'P06',2),
(7,  N'P07',1);


-- Thêm hóa đơn
INSERT  INTO  tbl_HoaDon1 
VALUES  
(1,  1,  2,  1,'2017-11-05',  N'Đã  đóng'),
(2,  2,  1,  2,'2017-11-01',  N'Đã  đóng'),
(3,  1,  1,  3,'2017-11-15',N'Chưa  đóng'),
(4,  3,  3,  4,'2017-11-01',  N'Đã  đóng');

-- Thêm chi tiết hóa đơn
INSERT  INTO  tbl_ChiTietHoaDon1 
VALUES 
(2,1,'2017-11-13',  N'Chưa  đóng'),
(2,2,'2017-11-13',  N'Đã  đóng'),
(1,3,'2017-11-10',  N'Đã  đóng'),
(3,4,'2017-11-05',  N'Chưa  đóng'),
(4,5,'2017-11-03',  N'Chưa  đóng'),
(4,1,'2017-11-03',  N'Đã  đóng');


--  Tạo  mặt  lạ
CREATE  SYNONYM  NhanVienTram2
FOR  Phantan.QLThuPhiNCCTram2.DBO.tbl_NhanVien2;

CREATE  SYNONYM  KhachHangTram2
FOR  Phantan.QLThuPhiNCCTram2.DBO.tbl_KhachHang2;

CREATE  SYNONYM  CTHDTram2
FOR  Phantan.QLThuPhiNCCTram2.DBO.tbl_ChiTietHoaDon2;

CREATE SYNONYM NhanVienTram1
FOR PhanTan.QLThuPhiNCCTram1.dbo.tbl_KhachHang1
-- Phân tán ngang
-- Hiện  danh  sách  hai  bảng  tbl_NhanVien  ở  hai  trạm 
SELECT * FROM PhanTan.QLThuPhiNCCTram1.dbo.tbl_NhanVien1
UNION
SELECT * FROM NhanVienTram2
GO 

--  Tạo  view  cho  xem  danh  sách  tên  các  nhân  viên  đã  làm  lơn  hơn  hoặc  bằng  2  năm 
CREATE VIEW vwDanhSachNV1
AS
	SELECT * FROM QLThuPhiNCCTram1.dbo.tbl_NhanVien1 WHERE CONVERT(INT,GETDATE() - dNgayvaolam)/365  >=2 
	UNION
	SELECT * FROM NhanVienTram2 WHERE CONVERT(INT,GETDATE() - dNgayvaolam)/365  >=2
GO 

SELECT  *  FROM  vwDanhSachNV1;
GO 

--  Viết  lệnh  thêm  dữ  liệu  vào  bảng  tbl_KhachHang  và  đưa  vào  trạm  phù  hợp 
CREATE PROCEDURE sp_ThemKhachHang
	@MaKH  INT,  @TenKH  NVARCHAR(50),  @GT  NVARCHAR(10),  @Diachi  NVARCHAR(50), @Ngaysinh  DATE,  @SDT  VARCHAR(11),  @CMND  VARCHAR(20)
AS
	BEGIN
	IF  NOT  EXISTS  
		(SELECT  *  FROM  QLThuPhiNCCTram1.dbo.tbl_KhachHang1 , KhachHangTram2  WHERE  @MaKH  = QLThuPhiNCCTram1.dbo.tbl_KhachHang1.iMaKH  AND  @MaKH  =  KhachHangTram2.iMaKH)
		BEGIN
			IF(@Diachi  =  N'Hà  Nội')
				INSERT  INTO  QLThuPhiNCCTram1.dbo.tbl_KhachHang1  VALUES (@MaKH,@TenKH,@GT,@Diachi,@Ngaysinh,@SDT,@CMND)
			ELSE
				INSERT  INTO  KhachHangTram2  VALUES (@MaKH,@TenKH,@GT,@Diachi,@Ngaysinh,@SDT,@CMND)
		END
END
GO 
DROP PROCEDURE dbo.sp_ThemKhachHang
SELECT  *  FROM  QLThuPhiNCCTram1.dbo.tbl_KhachHang1
UNION
SELECT  *  FROM  dbo.KhachHangTram2 
GO

EXECUTE  sp_ThemKhachHang  4,  N'Minh  Thuý',N'Nữ',  N'Nam  Định','1996-11- 25','0976108764','122257752';
GO 

-- Cơ sở dữ liệu trạm 2
CREATE  DATABASE  QLThuPhiNCCTram2  COLLATE  Vietnamese_CI_AS; 
USE  QLThuPhiNCCTram2;
GO

CREATE  TABLE  tbl_LoaiPhong2( 
	iMaLP  INT  NOT  NULL  PRIMARY  KEY, 
	sTenLP  NVARCHAR(50),
	fGiaphong  FLOAT
) 

CREATE  TABLE  tbl_Phong2(
	iMaPhong  INT  NOT  NULL  PRIMARY  KEY,
	sTenphong  NVARCHAR(50), 
	iMaLP  INT  NOT  NULL,
	CONSTRAINT  FK_phong_loaiphong  FOREIGN  KEY  (iMaLP)  REFERENCES tbl_LoaiPhong2(iMaLP)
) 

CREATE  TABLE  tbl_KhachHang2( 
	iMaKH  INT  NOT  NULL  PRIMARY  KEY, 
	sTenKH  NVARCHAR(50),
	sGioitinh  NVARCHAR(10), 
	sDiachi  NVARCHAR(50), 
	dNgaysinh  DATETIME, 
	sSoDT  VARCHAR(11), 
	sSoCMND  VARCHAR(20)
)


CREATE  TABLE  tbl_NhanVien2(
	iMaNV  INT  NOT  NULL  PRIMARY  KEY, 
	sTenNV  NVARCHAR(50),
	sGioitinh  NVARCHAR(10), 
	dNgaysinh  DATETIME, 
	sSoDT  VARCHAR(11),
	dNgayvaolam  DATETIME, 
	fLuongcoban  FLOAT, 
	fPhucap  FLOAT
) 

CREATE  TABLE  tbl_DichVu2(
	iMaDV  INT  NOT  NULL  PRIMARY  KEY, 
	sTenDV  NVARCHAR(50),
	iSoluong  INT, 
	fGiaDV  FLOAT
) 

CREATE  TABLE  tbl_HoaDon2(
	iMaHD  INT  NOT  NULL  PRIMARY  KEY, 
	iMaKH  INT  NOT  NULL,
	iMaNV  INT  NOT  NULL,
	iMaPhong  INT  NOT  NULL, 
	dNgaylap  DATETIME, 
	sTrangthai  NVARCHAR(50),
	CONSTRAINT  FK_KH_HoaDon  FOREIGN  KEY  (iMaKH)  REFERENCES  tbl_KhachHang2(iMaKH), 
	CONSTRAINT  FK_NV_HoaDon  FOREIGN  KEY  (iMaNV)  REFERENCES  tbl_NhanVien2(iMaNV),
	CONSTRAINT  FK_Phong_HoaDon  FOREIGN  KEY  (iMaPhong)  REFERENCES
	tbl_Phong2(iMaPhong)
) 

CREATE  TABLE  tbl_ChiTietHoaDon2( 
	iMaHD  INT  NOT  NULL,
	iMaDV  INT  NOT  NULL,
	dNgaythutien  DATETIME, 
	sTrangthai  NVARCHAR(50),
	CONSTRAINT  PK_CT  PRIMARY  KEY  (iMaHD,  iMaDV),
	CONSTRAINT  FK_hoadon_ChiTietHoaDon  FOREIGN  KEY  (iMaHD)  REFERENCES tbl_HoaDon2(iMaHD),
	CONSTRAINT  FK_dichvu_ChiTietHoaDon  FOREIGN  KEY  (iMaDV)  REFERENCES tbl_DichVu2(iMaDV)
)
--  THÊM  LOẠI  PHÒNG

INSERT  INTO  tbl_LoaiPhong2  
VALUES  
(1,  N'Thường',2000000),
(2,  N'Vip',  3000000);

--  THÊM  NHÂN  VIÊN
INSERT  INTO  tbl_NhanVien2  
VALUES  
(1,N'Trần  Hoàng  Anh',  N'Nữ',  '1998-05- 13','01652123846','2010-11-05',  3500000,  500),
(2,N'Trịnh  Huy  Khánh',  N'Nam','1996-10-04','0912983472','2015-10-15',  3000000,  400),
(3,N'Lê  Minh  Duy',N'Nam','1995-09- 28','01697086390','2016-09-28',6000000,200);

-- THÊM KHÁCH HÀNG

INSERT  INTO  tbl_KhachHang2  
VALUES  
(1,  N'Trần  Văn  Cường',  N'Nam',  N'Bắc  Giang', '1997-09-20',  '0912623213'  ,'126778342'),
(2,  N'Nguyễn  Khánh  Linh',N'Nữ',N'Hưng Yên','1998-07-23','0969480270','125768142'),
(3,  N'Nguyễn  Văn  Huấn',  N'Nam',  N'Phú  Thọ', '1998-05-11',  '01699572119'  ,  '145811911');

--  THÊM  DỊCH  VỤ
INSERT  INTO  tbl_DichVu2 
VALUES  
(1,  N'DV  mạng  internet',  1,  250000),
(2,  N'Điện',  50,  200000),
(3,  N'DV  gửi  xe',  1,  50000),
(4,  N'Nước',  5,  100000),
(5,  N'Vệ  sinh  môi  trường',  1,  70000);

-- THÊM PHÒNG
INSERT  INTO  tbl_Phong2 
VALUES  
(1,  N'P01',1),
(2,  N'P02',2),
(3,  N'P03',2),
(4,  N'P04',1);

-- THÊM HOÁ ĐƠN
INSERT  INTO  tbl_HoaDon2 
VALUES  
(1,  1,  2,  1,'2017-11-05',  N'Đã  đóng'),
(2,  2,  1,  2,'2017-11-01',  N'Đã  đóng'),
(3,  1,  2,  3,'2017-11-15',N'Chưa  đóng'),
(4,  3,  3,  4,'2017-11-01',  N'Đã  đóng');

--  THÊM  CHI  TIẾT  HOÁ  ĐƠN
INSERT  INTO  tbl_ChiTietHoaDon2  
VALUES  
(2,1,'2017-11-13',  N'Chưa  đóng'),
(1,2,'2017-11-13',  N'Đã  đóng'),
(3,5,'2017-11-05',  N'Chưa  đóng'),
(4,3,'2017-11-03',  N'Chưa  đóng');

