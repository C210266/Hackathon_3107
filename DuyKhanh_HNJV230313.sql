create database school;
use school;

-- I.
create table dmkhoa(
MaKhoa varchar(20) primary key ,
TenKhoa varchar(255) 
);

create table dmnganh(
MaNganh int primary key,
TenNganh varchar(255) ,
MaKhoa varchar(255),
foreign key (MaKhoa) references dmkhoa(MaKhoa)
);

create table dmhocphan(
MaHP int primary key,
TenHP varchar(255),
Sodvht int ,
MaNganh int ,
HocKy int ,
foreign key (MaNganh) references dmnganh(MaNganh)
);

create table dmlop(
MaLop varchar(20) primary key ,
TenLop varchar(255),
MaNganh int ,
KhoaHoc int  ,
HeDT varchar(255) ,
NamNhapHoc int ,
foreign key (MaNganh) references dmnganh(MaNganh)
);

create table sinhvien(
MaSV int primary key,
HoTen varchar(255) ,
MaLop varchar(20),
GioiTinh tinyint(1),
NgaySinh Date ,
Diachi varchar(255) ,
foreign key (MaLop) references dmlop(MaLop)
);

create table diemhp(
MaSV int ,
MaHP int ,
DiemHp float,
foreign key (MaSV) references sinhvien(MaSV),
foreign key (MaHP) references dmhocphan(MaHP)
);

-- Thêm dữ liệu vào bảng dmkhoa
INSERT INTO dmkhoa (MaKhoa, TenKhoa) VALUES
('CNTT', 'Công nghệ thông tin'),
('KT', 'Kế toán'),
('SP', 'Sư phạm');

-- Thêm dữ liệu vào bảng dmnganh
INSERT INTO dmnganh (MaNganh, TenNganh, MaKhoa) VALUES
(140902, 'Sư phạm toán tin', 'SP'),
(480202, 'Tin học ứng dụng', 'CNTT');

-- Thêm dữ liệu vào bảng dmhocphan
INSERT INTO dmhocphan (MaHP, TenHP, Sodvht, MaNganh, HocKy) VALUES
(1, 'Toán cao cấp A1', 4, 480202, 1),
(2, 'Tiếng anh 1', 3, 480202, 1),
(3, 'Vật lí đại cương', 4, 480202, 1),
(4, 'Tiếng anh 2', 7, 480202, 1),
(5, 'Tiếng anh 1', 3, 140902, 2),
(6, 'Xác suất thống kê', 4, 480202, 2);

-- Thêm dữ liệu vào bảng dmlop
INSERT INTO dmlop (MaLop, TenLop, MaNganh, KhoaHoc, HeDT, NamNhapHoc) VALUES
('CT11', 'Cao đẳng tin học', 480202, 11, 'TC', 2013),
('CT12', 'Cao đẳng tin học', 480202, 12, 'CD', 2013),
('CT13', 'Cao đẳng tin học', 480202, 13, 'TC', 2014);

-- Thêm dữ liệu vào bảng sinhvien
INSERT INTO sinhvien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, Diachi) VALUES
(1, 'Phan Thanh', 'CT12', 0, '1999-09-12', 'Tuy Phước'),
(2, 'Nguyên Thị Cẩm', 'CT12', 1, '1994-01-12', 'Quy Nhơn'),
(3, 'Võ Thị Hà', 'CT12', 1, '1995-07-02', 'An Nhơn'),
(4, 'Trần Hoài Nam', 'CT12', 0, '1994-04-05', 'Tây Sơn'),
(5, 'Trần Văn Hoàng', 'CT13', 0, '1995-08-04', 'Vĩnh Thạnh'),
(6, 'Đặng Thị Thảo', 'CT13', 1, '1995-06-12', 'Quy Nhơn'),
(7, 'Lê Thị Sen', 'CT13', 1, '1994-08-12', 'Phủ Mỹ'),
(8, 'Nguyễn Văn Huy', 'CT11', 0, '1995-06-04', 'Tuy Phước'),
(9, 'Trần Thị Hoa', 'CT11', 1, '1994-08-09', 'Hoài Nhơn');

-- Thêm dữ liệu vào bảng diemhp
INSERT INTO diemhp (MaSV, MaHP, DiemHp) VALUES
(2, 2, 5.9),
(2, 3, 4.5),
(3, 1, 4.3),
(3, 2, 6.7),
(3, 3, 7.3),
(4, 1, 4),
(4, 2, 5.2),
(4, 3, 3.5),
(5, 1, 9.8),
(5, 2, 7.9),
(5, 3, 7.5),
(6, 1, 6.1),
(6, 2, 5.6),
(6, 3, 4),
(7, 1, 6.2);

-- II .
-- 1.
select sv.MaSV,HoTen,MaLop,DiemHP,MaHP from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV
where diemHP >=5;

-- 2.
select sv.MaSV,HoTen,MaLop,DiemHP,MaHP from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV
where diemHP >=5
order by MaLop, HoTen;
-- 3.
select sv.MaSV, HoTen,MaLop,DiemHP,HocKy from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV
                                                          join dmhocphan dmhp on dmhp.MaHP = hp.MaHP
where hp.DiemHP between 5 and 7 and dmhp.HocKy = 1;

-- 4 .
select MaSV, HoTen, sv.MaLop, TenLop,MaKhoa from sinhvien sv join dmlop lp on sv.MaLop = lp.MaLop
join dmnganh ng on ng.MaNganh = lp.MaNganh
where ng.MaKhoa = 'CNTT';

-- 5.
select sv.MaLop, TenLop,count(*) from sinhvien sv join dmlop lp on sv.MaLop = lp.MaLop
group by MaLop;

-- 6. 
select HocKy, hp.MaSV,Sum(diemHP * Sodvht)/Sum(Sodvht) DiemTBC from diemhp hp join dmhocphan dmhp on hp.MaHP = dmhp.MaHP
where dmhp.Hocky = 1
group by hp.MaSV
order by hp.MaSV;

-- 7.
select sv.MaLop,lop.TenLop,
case
	when sv.GioiTinh = 0 then "Nam"
	when sv.GioiTinh = 1 then "Nữ"
end 'GioiTinh',
case
	when sv.GioiTinh = 0 then count(sv.MaSV)
	when sv.GioiTinh = 1 then count(sv.MaSV)
end 'SoLuong' from sinhvien sv
join dmlop lop on sv.MaLop = lop.MaLop
group by sv.MaLop,sv.GioiTinh;

-- 8
select  hp.MaSV,Sum(diemHP * Sodvht)/Sum(Sodvht) DiemTBC from diemhp hp join dmhocphan dmhp on hp.MaHP = dmhp.MaHP
where dmhp.Hocky = 1
group by hp.MaSV;

-- 9
select sv.MaSV, HoTen,count(diemHP < 5) SLuong from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV
where diemHP < 5
group by MaSV;

-- 10
select MaHP, count(diemHP)  SL_SV_Thieu from diemhp 
where diemHP < 5
group by diemhp.MaHP;

-- 11.
 select sv.MaSV,HoTen, sum(Sodvht) Tongdvht from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV
 join dmhocphan dmhp on dmhp.MaHP = hp.MaHP
 where diemHP < 5
 group by sv.MaSV
 order by sv.MaSV;
                    
-- 12. 
select sv.MaLop, TenLop,count(MaSV) from dmlop lp join sinhvien sv on lp.MaLop = sv.MaLop
group by sv.MaLop
having count(MaSV) > 2;

-- 13.
select sv.MaSV, HoTen, count(diemHP) from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV
where diemHP < 5
group by sv.MaSV
having count(diemHP) >= 2;

-- 14. 
select HoTen, count(*) Soluong from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV
where hp.MaHP IN (1, 2, 3) 
group by sv.HoTen
having count(hp.MaHP) >= 3;
