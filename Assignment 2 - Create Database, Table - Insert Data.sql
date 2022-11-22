-- Tạo Database
CREATE DATABASE Assignment2
USE Assignment2
GO

-- Tạo các bảng:
-- 1. Bảng VIEWER:
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'VIEWER')
DROP TABLE VIEWER

CREATE TABLE VIEWER (
    Viewer_ID NVARCHAR(5) CONSTRAINT PK_VIEWER PRIMARY KEY,
    [Password] NVARCHAR(30) NOT NULL,
    Full_Name NVARCHAR(50) NOT NULL,
    Gender NVARCHAR(8) NOT NULL CONSTRAINT CK_VIEWER_Gender CHECK(Gender IN ('Male','Female')),
    Email NVARCHAR(50) NOT NULL CONSTRAINT UC_VIEWER_Email UNIQUE,
    Joining_Date DATE NOT NULL CONSTRAINT DF_VIEWER_Joining_Date DEFAULT CURRENT_TIMESTAMP
)

INSERT INTO VIEWER (Viewer_ID, [Password], Full_Name, Gender, Email,Joining_Date)
VALUES  ('V001','#tranducminh#','Tran Duc Minh','Male','tranducminh@gmail.com','2022-11-12'),
        ('V002','@thinhnguyen@','Nguyen Xuan Thinh','Male','xuanthinhnguyen@gmail.com','2021-06-24'),
        ('V003','HuyDinh3979','Dinh Thanh Huy','Male','huythanhdinh@yahoo.com','2021-03-18'),
        ('V004','Manhnguyentran68','Tran Nguyen Manh','Male','nguyenmanh@cmc.com.vn','2020-12-10'),
        ('V005','maihuong_maersk_vn','Nguyen Thi Mai Huong','Female','maihuongnguyen@maersk.com','2020-05-28'),
        ('V006','PhanTuCMACGM','Phan Thi Thanh Tu','Female','tuphan@cma-cgm.com.vn','2022-02-19'),
        ('V007','tuananh1993#','Tran Anh Tuan','Male','trananhtuan@homecredit.vn','2021-06-23'),
        ('V008','LoanVietcombank@1990','Tran Thi Thanh Loan','Female','thanhloantranthi@vcb.com.vn','2020-01-03'),
        ('V009','DangQuynh#FTU2#','Dang Truc Quynh','Female','trucquynhdang@ftu2.edu.vn','2022-08-06'),
        ('V010','NhatLinh061220','Nguyen Vu Nhat Linh','Female','nhatlinhnguyen@fpt.edu.vn','2021-10-22'),
        ('V011','$Duongngocduc','Duong Ngoc Duc','Male','ngocducduong@gmail.com','2022-02-27'),
        ('V012','thanhthao22101995','Tran Thi Thanh Thao','Female','tranthithanhthaon@yahoo.com','2021-03-15'),
        ('V013','TramAnh79','Ngo Thi Tram Anh','Female','tramanhngo@yahoo.com','2021-03-19'),
        ('V014','$HaThuTran#','Tran Thu Ha','Female','thuha@cmc.com.vn','2022-10-09'),
        ('V015','VietHoang6886','Nguyen Trung Viet Hoang','Male','viethoangnguyen@homecredit.vn','2020-05-11'),
        ('V016','_HungTran_','Tran Van Hung','Male','tranvanhung@cmc.com.vn','2021-09-07'),
        ('V017','*NguyenNgocLong@FTU2*','Nguyen Ngoc Long','Male','trananhtuan@ftu2.edu.vn','2021-04-23'),
        ('V018','%LinhDieu%','Nguyen Dieu Linh','Female','dieulinh@ftu2.edu.vn','2022-07-19'),
        ('V019','KhanhVu#CodingFPT','Vu Nam Khanh','Male','vunamkhanh@fpt.edu.vn','2022-08-02'),
        ('V020','$@Minhhang020125*','Le Minh Hang ','Female','minhhangle@maersk.com','2020-12-11')

SELECT *
FROM VIEWER

-- 2. Bảng REPORTER:
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'REPORTER')
DROP TABLE REPORTER

CREATE TABLE REPORTER (
    Reporter_ID NVARCHAR(5) CONSTRAINT PK_REPORTER PRIMARY KEY,
    [Password] NVARCHAR(30) NOT NULL,
    Full_Name NVARCHAR(50) NOT NULL,
    Gender NVARCHAR(8) NOT NULL CONSTRAINT CK_REPORTER_Gender CHECK(Gender IN ('Male','Female')),
    Email NVARCHAR(50) NOT NULL CONSTRAINT UC_REPORTER_Email UNIQUE,
    Pseudonym NVARCHAR(50)
)

INSERT INTO REPORTER (Reporter_ID, [Password], Full_Name, Gender, Email, Pseudonym)
VALUES  ('R001','QuangMinhDang_ThoiDai','Dang Quanh Minh','Male','quangminhhs@gmail.com','Nhat Minh'),
        ('R002','#ThuHoai#','Phan Thi Thu Hoai','Female','thuhoaicskh@gmail.com','Phan Thu Hoai'),
        ('R003','#BuivanTien_BVPL&','Bui Van Tien','Male','buitienbvpl@gmail.com','Bui Tien'),
        ('R004','_HoangPhuc.NLD_','Tran Van Phuc','Male','hoangphuc.nguoilaodong@gmail.com','Hoang Phuc'),
        ('R005','%TanNgoc1103%','Uong Ngoc Tan','Male','uongngoctan@gmail.com','Uong Ngoc Tan'),
        ('R006','04342-HangTran','Tran Thi Hang','Female','hangnb.vnhn@gmail.com',NULL),
        ('R007','Huyen7542','Ngo Thi Huyen','Female','huyennt.ttvh@gmail.com','Ngo Huyen'),
        ('R008','^XuanHuong2889^','Ho Xuan Huong','Female','xuanhuongdspl@gmail.com','Xuan Huong'),
        ('R009','65LinhLinhTHQH92','Vo Van Linh','Male','linh.linh.vo@gmail.com','Linh Linh'),
        ('R010','NguyenDucTho3301','Nguyen Duc Tho','Male','ductho86@gmail.com',NULL),
        ('R011','PTHNhung_0705462919','Pham Thi Hong Nhung','Female','pthnhung03119@gmail.com',NULL),
        ('R012','**TamPhung2785**','Nguyen Tam Phung','Male','tamphungbao@gmail.com','Nguyen Tam'),
        ('R013','@@DungVT77','Vo Thi Dung','Female','vothidung77@gmail.com',NULL),
        ('R014','_phongnguyen0903598162_','Le Nguyen Phong','Male','phongnguyen@gmail.com','Phong Nguyen'),
        ('R015','$thuytran**','Tran Thi Thuy','Female','thuytranthi@gmail.com',NULL),
        ('R016','VOVThuyLamTran','Tran Thi Thanh Thuy','Female','lamthuyvov@gmail.com','Lam Thuy'),
        ('R017','__KhoaNam_TuoiTre__','Nguyen Quoc Binh','Male','khoanamtuoitre@gmail.com','Khoa Nam'),
        ('R018','XuanNhiPLVN82','Tran Thi Nhi','Female','xuannhiplvn82@gmail.com','Tran Thi Nhi')

SELECT *
FROM REPORTER

-- 3. Tạo bảng EDITOR:
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'EDITOR')
DROP TABLE EDITOR

CREATE TABLE EDITOR (
    Editor_ID NVARCHAR(5) CONSTRAINT PK_EDITOR PRIMARY KEY,
    [Password] NVARCHAR(30) NOT NULL,
    Full_Name NVARCHAR(50) NOT NULL,
    Gender NVARCHAR(8) NOT NULL CONSTRAINT CK_EDITOR_Gender CHECK(Gender IN ('Male','Female')),
    Email NVARCHAR(50) NOT NULL CONSTRAINT UC_EDITOR_Email UNIQUE
)

INSERT INTO EDITOR (Editor_ID, [Password], Full_Name, Gender, Email)
VALUES  ('E001','**LeAnhTuanBRVT**','Le Anh Tuan','Male','leanhtuan@nhandan.org.vn'),
        ('E002','#duong_manh#','Doan Manh Duong','Male','duongttxvn@gmail.com'),
        ('E003','@lykhanh_824','Nguyen Trung Khanh Ly','Female','tangkhanhly17584@gmail.com'),
        ('E004','LinhNga@tainguyenmoitruong@','Tran Thi Nga','Female','linhngatnmt@gmail.com'),
        ('E005','%nhamnguyenNDT%','Nguyen Thi Nham','Female','nguyennhambc@gmail.com'),
        ('E006','$0903965643$$NguyenMinh#','Vo Ngoc Nguyen Minh','Male','nguyenminhvo@gmail.com'),
        ('E007','LuuSonVN-VOV','Nguyen Luu Son','Male','luusonvov@gmail.com'),
        ('E008','&LanDo&','Do Thi Tuyet Lan','Female','dttlan2004@gmail.com'),
        ('E009','ThuhuynhDieuVTV','Huynh Dieu Thu','Female','huynhdieuthuvtv@gmail.com'),
        ('E010','nguyenvancuong46BR','Nguyen Van Cuong','Male','nguyenvancuongndds@gmail.com'),
        ('E011','%thanhhuyenbrt#','Tran Thi Thanh Huyen','Female','huyenbrt@gmail.com'),
        ('E012','*thinhdaobrt*','Dao Quoc Thinh','Male','quocthinhbrt@gmail.com')

SELECT *
FROM EDITOR

-- 4. Tạo bảng CATEGORY:
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'CATEGORY')
DROP TABLE CATEGORY

CREATE TABLE CATEGORY (
    Category_ID NVARCHAR(8) CONSTRAINT PK_CATEGORY PRIMARY KEY,
    Category_Name NVARCHAR(30) NOT NULL,
    Parent_ID NVARCHAR(8)
)

INSERT INTO CATEGORY (Category_ID, Category_Name, Parent_ID)
VALUES  ('CAT001','Xa hoi',NULL),
        ('CAT002','Chung Khoan','CAT011'),
        ('CAT003','Bat Dong san','CAT011'),
        ('CAT004','Ngan hang','CAT012'),
        ('CAT005','Doanh nghiep','CAT012'),
        ('CAT006','Vi mo','CAT011'),
        ('CAT007','Thiet bi dien tu','CAT014'),
        ('CAT008','The thao','CAT013'),
        ('CAT009','Song','CAT013'),
        ('CAT010','Xe','CAT014'),
        ('CAT011','Tai chinh - Dau tu',NULL),
        ('CAT012','Kinh doanh',NULL),
        ('CAT013','Giai tri va cuoc song',NULL),
        ('CAT014','Xe va Cong nghe',NULL)

SELECT *
FROM CATEGORY

-- 5. Tạo bảng Article:
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'ARTICLE')
DROP TABLE ARTICLE

CREATE TABLE ARTICLE (
    Article_ID NVARCHAR(5) CONSTRAINT PK_ARTICLE PRIMARY KEY,
    Category_ID NVARCHAR(8),
    Author NVARCHAR(5),
    Approver NVARCHAR(5),
    Article_Name NVARCHAR(255) NOT NULL CONSTRAINT UC_ARTICLE_Article_Name UNIQUE,
    Summary TEXT NOT NULL,
    Full_Content TEXT NOT NULL,
    Creating_Date DATETIME2(0) NOT NULL,
    Posting_Date DATETIME2(0),
    Updating_Date DATETIME2(0),
    [Status] NVARCHAR(20) NOT NULL CONSTRAINT CK_ARTICLE_Status CHECK([Status] IN ('Approved','Not Approved')),
    Access_Number INT NOT NULL CONSTRAINT DF_ARTICLE_Access_Number DEFAULT 0,
    CONSTRAINT FK_ARTICLE_Category_ID_CATEGORY FOREIGN KEY(Category_ID) REFERENCES CATEGORY(Category_ID),
    CONSTRAINT FK_ARTICLE_Author_REPORTER FOREIGN KEY(Author) REFERENCES REPORTER(Reporter_ID),
    CONSTRAINT FK_ARTICLE_Approver_EDITOR FOREIGN KEY(Approver) REFERENCES EDITOR(Editor_ID)
)

INSERT INTO ARTICLE (Article_ID, Category_ID, Author, Approver, Article_Name, Summary, Full_Content, Creating_Date, Posting_Date, Updating_Date, [Status])
VALUES  ('A001','CAT002','R003','E006','Phai sinh van dang la cuu canh cho nha dau tu khi chung khoan lam nguy',
        'Du thi truong co so dang trong giai doan giam diem manh khi cac co phieu lien tuc pha day thi phai sinh van dang co su soi dong nhat tu truoc den nay',
        'Theo tong ket cua HNX, tren thi truong phai sinh, HDTL VN30 trong thang 10/2022 co giao dich tang manh voi khoi luong giao dich binh quann dat 423.041 hop dong / phien, tang 66,73% so voi thang truoc, tuong ung gia tri giao dich binh quan theo danh nghia hop dong dat 43.566 ty dong, tang 39,89% so voi thang truoc.',
        '2022-11-16 15:10:12','2022-11-16 15:31:24','2022-11-16 15:31:24','Approved'),
        ('A002','CAT008','R001','E003','Morais: "Phai la HLV dac biet moi quan ly duoc Ronaldo"',
        'Jose Morais, cuu tro ly cua Jose Mourinho tai Real, bao ve Cristiano Ronaldo va chi trich cach HLV Erik Ten Hag doi xu voi ngoi sao 37 tuoi',
        'Theo Morais, cach xu ly khong mem mong cua Ten Hag khien moi thu phuc tap hon. "Mot HLV dac biet phai biet cach doi pho voi nhung tinh huong nhu su viec tai Man Utd luc nay, bang giao tiep tich cuc".',
        '2022-10-23 08:28:07','2022-10-25 12:37:56','2022-10-25 14:16:18','Approved'),
        ('A003','CAT003','R003','E010','"Nguoi dan loi" cho hanh trinh gian nan tim nha',
        'Tim mua nha dat du voi muc dich nao (de o, cho thue, dau tu) deu la mot hanh trinh gian nan va luon can thong tin, can mot nha tu van tin cay de dan loi',
        'Ong Nguyen Quoc Anh - Pho Tong Giam doc Batdongsan.com.vn co loi khuyen danh cho cac nha dau tu ca nhan: "Thay vi tap trung vao loai hinh dau co thi nen tim den nhung san pham Bat dong san co gia tri su dung cao va tai nhung khu vuc co kinh te da phat trien on dinh".',
        '2022-09-14 07:55:09','2022-09-15 08:02:12','2022-09-15 08:02:12','Approved'),
        ('A004','CAT001','R002','E012','Quoc hoi dong y bo sung thong tin "noi sinh" vao ho chieu moi',
        'Quoc hoi dong y bo sung thong tin "noi sinh" vao ho chieu cap cho cong dan Viet Nam, dong thoi giao Chinh phu chi dao cac bo, nganh lien quan sua doi, bo sung van ban quy pham',
        'Mot trong nhung noi dung dang chu y duoc neu trong Nghi quyet la viec Quoc hoi dong y bo sung thong tin "noi sinh" vao ho chieu cap cho cong dan Viet Nam. Quoc hoi giao Chinh phu chi dao cac bo, nganh lien quan sua doi, bo sung van ban quy pham phap luat theo tham quyen de trien khai thuc hien.',
        '2022-11-16 19:52:18',NULL,NULL,'Not Approved'),
        ('A005','CAT010','R012','E008','Diem mat 6 mau SUV nhanh, manh nhat Viet Nam',
        'Tai Viet Nam, nhung chiec SUV hieu suat cao dang la nhung chiec xe duoc nhieu nguoi quan tam',
        'Aston Martin DBX707, Lamboghini Urus, Porsche Cayenne Turbo GT, Maserati Levante Trofeo, Mercedes-AMG G63, Rolls-Royce Cullinan.',
        '2021-05-22 14:23:27','2021-05-23 08:00:18','2021-05-23 08:00:18','Approved'),
        ('A006','CAT006','R006','E007','2020 la nam dau tien Viet Nam giu on dinh vi mo trong khung hoang',
        'Lan dau tien Viet Nam chiu tieu cuc cua bat on, khung hoang toan cau nhung on dinh vi mo van duoc giu vung',
        'Theo ong Nguyen Xuan Thanh, neu nhin vao lich su phat trien kinh te cua Viet Nam trong 30 nam thi co le day la lan dau tien Viet Nam chiu tieu cuc cua bat on, khung hoang toan cau nhung on dinh vi mo van duoc giu vung.',
        '2021-01-11 11:36:38','2021-01-11 19:33:10','2021-01-12 07:34:16','Approved'),
        ('A007','CAT004','R005','E011','Nghi quyet 42 co phai "dac quyen" cua nganh Ngan hang?',
        'Nghi quyet 42 duoc ban hanh, co nhung y kien cho rang, Quoc hoi, Chinh phu da trao nhieu dac quyen cho nganh Ngan hang',
        'Nghi quyet 42 ve xu ly no xau duoc Quoc hoi ban hanh vao thang 08/2017 va du kien den thang 08/2022 se het hieu luc. Ke tu khi ban hanh den nay, Nghi quyet duoc danh gia la co tac dong tich cuc doi voi he thong Ngan hang trong viec xu ly no xau.',
        '2022-06-03 10:12:36',NULL,NULL,'Not Approved'),
        ('A008','CAT005','R004','E001','Cac doanh nghiep Duc se mo rong tai Viet Nam?',
        'Chuyen tham cua thu tuong Duc tai Viet Nam vua qua co the se la dong luc cho cac doanh nghiep nuoc nay mo rong tai Viet Nam',
        'Viec thu tuong Duc Olaf Scholz dung chan tai Viet Nam, tren duong tham du hoi nghi thuong dinh cac nha lanh dao G20 o Indonesia da nhan manh vai tro ngay cang tang cua Viet Nam trong chuoi cung ung toan cau khi nhieu cong ty Duc nhac den viec da dang hoa hoat dong san xuat bang cach mo rong su hien dien ra ngoai Trung Quoc.',
        '2022-10-23 12:39:58','2022-10-25 09:35:23','2022-10-25 09:35:23','Approved'),
        ('A009','CAT007','R007','E002','7 thach thuc Smartphone man hinh gap phai giai quyet de xung tam cach mang cong nghe',
        'Du ra mat da lau va tro nen quen thuoc voi nguoi dung cong nghe, cac Smartphone man hinh gap van con nhieu viec phai lam neu muon tao nen mot cuoc cach mang thuc su',
        'Nep nhan tren man hinh, Thieu kha nang chong bui, Ngoai hinh "kem sang" cua man hinh gap, Ung dung ho tro, Cau hinh thap hon so voi Smartphone cung thoi, Gia ca, It lua chon ve nha cung cap.',
        '2021-03-16 03:24:17','2021-03-16 08:45:48','2021-03-16 09:48:57','Approved'),
        ('A010','CAT009','R009','E009','Tai sao nguoi Nhat khong an ca song ma chi thich ca bien?',
        'Trong cuoc song, nguoi Nhat khong an ca song va it an ca nuoc ngot. Ho chu yeu an ca bien. Tai sao ho lai co thoi quen nhu vay?',
        'Vi ho cho rang ca song khong sach, Nganh cong nghiep danh bat ca bien phat trien va ca bien ngon hon, Ca song khong ngon do dac thu dia hinh, Lo ngai ve o nhiem kim loai nang.',
        '2022-02-17 05:12:15','2022-02-18 10:11:18','2022-02-18 10:11:18','Approved'),
        ('A011','CAT002','R008','E004','Chung khoan tiep tuc xu huong tang',
        'Cac cong ty chung khoan cho rang mac du duoc khuyen nghi than trong nhung nha dau tu van chon loc mua vao va thi truong se tiep tuc di len dinh cu 1535 cua VN-Index',
        'Theo cong ty chung khoan DAS, thi truong dang tiep tuc nhip phuc hoi huong ve vung dinh cu, voi khoi luong giao dich tiep tuc cai thien tich cuc. Nhom co phieu von hoa vua va nho van dang hut dong tien, cung voi do cac co phieu von hoa lon nhom ngan hang va bat dong san giu duoc muc tang nhe, gop phan ho tro chi so chung.',
        '2022-02-17 05:12:15',NULL,NULL,'Not Approved'),
        ('A012','CAT004','R010','E007','Nhung Ngan hang nao dang co ty le an toan von cao nhat?',
        'CAR cua mot so Ngan hang dang cao hon tu gap ruoi den gan gap doi so voi yeu cau toi thieu 8%',
        'Theo ket qua kinh doanh 9 thang, mot so Ngan hang co CAR cao nhat la Techcombank 15,7%, HDBank 15,3%, VPBank 15%, VIB 12,4%, ACB va MSB cung dat 12,5%, TPB 12,25%.',
        '2022-09-30 17:30:26','2022-10-01 09:09:23','2022-10-01 09:09:23','Approved'),
        ('A013','CAT001','R014','E005','Chua co CCCD gan chip, lam cach nao de tra cuu ma dinh danh ca nhan?',
        'Trong truong hop chua co CCCD gan chip, nguoi dan co the tra cuu ma dinh danh theo cach sau',
        '1. Truy cap vao he thong Cong dich vu cong quan ly cu tru: https://dichvucong.dancuquocgia.gov.vn/, 2. Dang nhap / Dang ky tai khoan DVC quoc gia, 3. Xem ma dinh danh ca nhan.',
        '2022-07-14 08:29:30','2022-07-16 07:10:27','2022-07-16 08:12:29','Approved'),
        ('A014','CAT005','R015','E010','Doanh nghiep xuat khau dieu giam lo nho ... vo',
        'Bien dong ty gia va lai suat khien cac nha nhap khau than trong, xuat khau giam manh, doanh nghiep trong nuoc cung kho khan nen khong mua tru hang nhieu nhu truoc',
        'Trong khi xuat khau nhan dieu sut giam manh gay kho khan cho doanh nghiep thi viec gia ban dau vo dieu co the bu khoang 10% doanh thu, giup cac doanh nghiep dieu giam lo.',
        '2021-04-19 14:11:23',NULL,NULL,'Not Approved'),
        ('A015','CAT008','R018','E003','Alcaraz chinh thuc giu ngoi so 1 the gioi',
        'Hai doi thu canh tranh tu danh mat co hoi, Carlos Alcaraz chinh thuc giu ngoi so 1 the gioi nam 2022',
        'Truoc khi buoc vao su kien ATP Finals 2022, Carlos Alcaraz khong the thi dau, vi vay anh danh mat quyen tu quyet va dat so phan ngoi so 1 the gioi vao tay Stefanos Tsitsipas va Rafael Nadal. Tuy nhien, sau khi 2 luot dau vong bang ATP Finals 2022 khep lai, Alcaraz da chac chan giu ngoi so 1 the gioi vao nam 2022.',
        '2022-10-10 18:10:20',NULL,NULL,'Not Approved'),
        ('A016','CAT006','R007','E002','"Loc" de co cac du an dau tu FDI chat luong',
        'Can co cong cu sang loc du an dau tu nuoc ngoai danh cho cac tinh thanh pho, tu do thuc day thuc hanh kinh doanh co trach nhiem va phat trien ben vung thong qua sang loc nha dau tu',
        'Ap dung cong cu sang loc du an dau tu tai Viet Nam se ho tro chinh quyen cac tinh, thanh pho xac dinh cac tac dong tieu cuc thuc te va tiem an cua du an FDI, danh gia tinh hieu qua va phu hop cua phuong an, quy trinh ngan ngua, giam thieu cac tac dong nay cua nha dau tu tai giai doan tham dinh.',
        '2022-11-17 12:45:20','2022-11-17 08:34:52','2022-11-17 08:34:52','Approved'),
        ('A017','CAT006','R002','E008','GDP 9 thang 2021 tang 8,83%, muc tang cao nhat trong 11 nam qua',
        'Tong san pham trong nuoc quy 3 da tang 13,67% so voi cung ky nam 2021, theo do GDP cua 9 thang da tang 8,83% va day la muc tang cao nhat trong giai doan 2011-2022',
        'Co cau nen kinh te 9 thang ghi nhan khu vuc nong, lam nghiep va thuy san chiem ty trong 11,27%, khu cong nghiep va xay dung chiem 38,69%, khu vuc dich vu chiem 41,31%, thue san pham tru tro cap san pham chiem 8,73%.',
        '2021-09-28 22:48:14','2021-09-29 14:17:46','2021-09-29 14:17:46','Approved'),
        ('A018','CAT004','R005','E010','Nhin lai nganh ngan hang nam 2021',
        'Nhung cuoc doi chu day bat ngo, su len ngoi cua lop lanh dao tre, cong nghe va dinh huong moi trong mang ban le co the coi la nhung diem nhan trong buc tranh ngan hang nam 2021',
        '1. Nhung cuoc doi chu bat ngo, lop lanh dao tre len ngoi (NCB, KienLongBank, Vietbank, SCB, LPB), 2. Ngan hang o at tang von, ca chuc ty co phieu phat hanh moi, 3. Lai suat thap ky luc, 4. No xau tang manh, ty le bao no xau cao ky luc, 5. Chuyen doi so, ngan hang ban le.',
        '2021-12-29 03:16:25','2021-12-29 20:00:43','2021-12-29 20:10:40','Approved'),
        ('A019','CAT007','R001','E001','Mataverse "khat" nhan tai',
        'Chi can co hieu biet ve Metaverse, ban se duoc cac cong ty cong nghe san don, dua ra muc luong hau hinh va tham chi la van dung nhung chieu tro marketing de keo ve',
        'Ty le choi cua cac vi tri lien quan den Metaverse rat thap vi khong nhieu nguoi thuc su co hieu biet ve linh vuc nay. Nhung ung vien co san ky nang ve Metaverse se duoc cac cong ty san don va co quyen lua chon lam viec o bat cu dau. Su khan hiem nhan tai trong linh vuc nay da buoc cac cong ty den tu nhieu linh vuc khac nhau phai dua nhau de thu hut nhan su.',
        '2022-11-09 05:19:39','2022-11-10 21:53:46','2022-11-10 21:53:46','Approved'),
        ('A020','CAT010','R009','E011','Anh thuc te Kia Sonet 2022 moi ra mat tai Viet Nam, lieu co thanh cong nhu Seltos?',
        'Nhung hinh anh thuc te dau tien ve Kia Sonet 2022 da xuat hien, mau xe nay duoc du bao se tiep noi thanh cong cua "dan anh" Kia Seltos',
        'Theo do, Kia Sonet 2022 duoc phan phoi voi 4 phien ban cung muc gia dao dong tu 499-609 trieu dong: Kia Sonet Deluxe MT (499 trieu dong), Kia Sonet Deluxe (539 trieu dong), Kia Sonet Luxury (579 trieu dong), Kia Sonet Premium (609 trieu dong).',
        '2021-10-08 13:15:38','2021-10-11 06:52:33','2021-10-11 06:52:33','Approved'),
        ('A021','CAT009','R001','E007','Nguoi giau va xu huong song xanh',
        'Moi truong song la yeu to chinh tac dong den tam ly va ung xu cua con nguoi. Dieu nay cung tao nen khac biet trong nhu cau an cu cua nguoi dan duoc phan cap theo muc thu nhap',
        'Nhieu du an biet thu nha pho cao cap duoc trien khai o cac vi tri rat dep hoi tu day du cac yeu to ve tu nhien nhu song, ho va phu xanh boi cac cong vien. Cu dan khong chi duoc hit tho khong khi trong lanh, hoa minh thu gian cung thien nhien tuoi tan, ma con duoc tan huong tron ven nhung tien ich dang cap quoc te giup cuoc song nhu duoc nghi duong moi ngay. Tham chi nhieu gia dinh coi noi minh song la oc dao hoan hao, khong can thiet phai dat chan ra ngoai "sa mac" nang gio bui bam ben ngoai.',
        '2021-07-19 19:29:30','2021-07-20 13:30:36','2021-07-21 15:34:20','Approved'),
        ('A022','CAT008','R001','E004','Chelsea vo dich Champions League voi thanh tich co mot khong hai trong lich su',
        'Chelsea da dang quang vo dich Champions League mua nay voi thanh tich phong ngu vo tien khoang hau trong lich su',
        'Ke tu khi Tuchel len nam quyen, Chelsea tro thanh mot doi bong cuc ky da dang voi nen tang la hang phong ngu vung chai. The Blues co the da phong ngu phan cong, co the kiem soat bong ap dao, co the tan cong don dap khien doi phuong khong kip tro tay. Chinh su da dang cua Chelsea khien cac doi bong khac phai de dat trong viec lua chon cach tiep can o nhung tran dau cup va giup ho co co hoi giu sach luoi nhieu hon.',
        '2021-05-29 22:37:45','2021-05-30 21:26:37','2021-05-30 21:26:37','Approved'),
        ('A023','CAT001','R004','E006','Luong si quan quan doi thay doi nhu the nao khi luong co so tang len 1,8 trieu?',
        'Tu ngay 01/07/2023, khi luong co so tang len 1,8 trieu dong / thang thi bang luong quan doi 2023 se co nhung thay doi',
        'Dai tuong: 18.720.000, Thuong tuong: 17.640.000, Trung tuong: 16.560.000, Thieu tuong: 15.480.000, Dai ta: 14.400.000, Thuong ta: 13.140.000, Trung ta: 11.880.000, Thieu ta: 10.800.000, Dai uy: 9.720.000, Thuong uy: 9.000.000, Trung uy: 8.280.000, Thieu uy: 7.560.000, Thuong si: 6.840.000, Trung si: 6.300.000, Ha si: 5.760.000.',
        '2022-11-16 23:58:15',NULL,NULL,'Not Approved'),
        ('A024','CAT003','R018','E008','Danh gia ky luong 2 phuong an dau tu nang cap, mo rong Cang Hang khong Con Dao',
        'Pho Thu tuong Le Van Thanh yeu cau cac co quan lien quan danh gia ky luong 2 phuong an dau tu nang cap, mo rong Cang Hang khong Con Dao',
        'Theo Cuc Hang khong, co 2 phuong an dau tu dong bo san bay Con Dao: Phuong an 1 theo Luat Dau tu, Luat Dau tu cong va Phuong an 2 theo Luat Dau tu PPP.',
        '2022-06-18 12:54:17','2022-06-19 07:22:55','2022-06-19 07:22:55','Approved'),
        ('A025','CAT001','R002','E003','Met moi voi xang dau, nhieu nguoi chuyen sang phuong tien cong cong',
        'Xang dau lien tuc tang gia, nhieu cua hang tam dong hoac ban "nho giot", do xang kho khan va met moi xep hang. Tinh canh keo dai da va dang khien nhieu nguoi dan nhieu dia phuong cam thay met moi',
        'Theo Trung tam Quan ly giao thong cong cong Ha Noi, luong hanh khach di xe buyt trong thang 10 la gan 24,5 trieu luot, tang gan 4 trieu luot so voi thang 9, tuong duong 18%.',
        '2022-11-14 15:33:24','2022-11-15 10:34:58','2022-11-15 10:34:58','Approved'),
        ('A026','CAT002','R005','E008','Thang 03/2022, VN-INDEX tang 0,14% va DPM co mat trong nhom doanh nghiep co von hoa hon 1 ty USD',
        'Gia tri von hoa niem yet tren HOSE dat hon 5,9 trieu ty dong, tang 0,28% so voi thang truoc, dat khoang 70,3% GDP nam 2021 (GDP theo gia hien hanh)',
        'Thanh khoan thi truong co phieu thang 03 ghi nhan gia tri va khoi luong giao dich binh quan phien lan luot dat tren 26.414 ty dong va 806,8 trieu co phieu, tang lan luot 13,82% ve gia tri va 14,28% ve khoi luong binh quan so voi thang 02.',
        '2022-04-01 21:10:23','2022-04-02 08:10:52','2022-04-02 08:10:52','Approved'),
        ('A027','CAT005','R015','E009','Dien Quang va Metropoli: Lien minh phat trien do thi Viet Nam',
        'Gop phan phat trien do thi thong minh dua Viet Nam tro thanh mot nuoc cong nghiep theo huong hien dai hoa day manh chuyen doi so quoc gia, phat trien kinh te so tren nen tang khoa hoc - cong nghe',
        'Su thanh lap chuoi lien ket cung phat trien do thi thong minh lan nay, khong chi mang den nhung gia tri thiet thuc cho cac ben ma con tao ra nhung doi moi tich cuc gop phan xay dung, phat trien cac du an ve kien tao do thi thong minh tren khap Viet Nam.',
        '2022-04-26 14:21:28','2022-04-27 09:11:23','2022-04-27 09:11:23','Approved'),
        ('A028','CAT008','R007','E002','Eden Hazard chot thoi diem chia tay Real Madrid',
        'Tra loi phong van to Marca, Eden Hazard cho biet, cau thu nay san sang roi Real Madrid khi mua giai nam nay khep lai',
        'Chia se voi to Marca, khi duoc hoi ve tuong lai cua minh, Eden Hazard cho biet: "Ra di vao thang 01/2023 la dieu khong the vi toi co gia dinh va toi thich thanh pho nay. Tuy nhien, vao mua he, toi co the ra di".',
        '2022-09-11 11:23:38','2022-09-12 08:20:34','2022-09-12 08:20:34','Approved'),
        ('A029','CAT010','R016','E009','Ford Territory ra mat tai Viet Nam, gia tu 822 trieu dong, canh tranh Mazda CX-5',
        'CUV co C Ford Territory ban ra thi truong voi 3 phien ban, gia tu 822 trieu dong, canh tranh voi hang loat dong xe Nhat Ban, Han Quoc tren thi truong',
        'Sau nhung lan xuat hien chay thu tren duong pho, ba phien ban cua mau CUV co C nay da duoc cong bo chieu 10/10/2022. Muc gia cho 3 phien ban Trend, Titanium, Titanium X lan luot la 822 trieu, 899 trieu và 935 trieu dong.',
        '2022-10-10 20:48:39','2022-10-11 09:22:47','2022-10-11 10:20:21','Approved'),
        ('A030','CAT006','R008','E006','Tinh thu hut nguoi di cu nhat Viet Nam',
        'Cac thanh pho lon thuong duoc chon vi ly do doan tu gia dinh va co hoi viec lam, con da so moi nguoi chon tinh nay vi moi truong tu nhien tot hon',
        'Tinh thu hut nguoi di cu nhat la Lam Dong (6,16%), noi duoc xem nhu trung tam kinh te cua Tay Nguyen. Lam Dong xep tren Can Tho (4,03%).',
        '2022-11-17 02:06:28','2022-11-17 09:42:27','2022-11-17 09:42:27','Approved'),
        ('A032','CAT003','R002','E005','Nuoc ngoai phat trien chung cu co thoi han, vi sao lai kho ap dung o Viet Nam?',
        'Cuc Quan ly nha va thi truong bat dong san Bo Xay dung thuong dan chung quy dinh cua Han Quoc, Thai Lan ve quy dinh so huu nha chung cu co thoi han va nhat la Co quan phat trien nha o Singapore ban can ho nha chung cu so huu co thoi han 99 nam. Song, chuyen gia cho rang, neu ap dung o Viet Nam se co nhieu bat cap',
        'Ngoai ganh nang ve mat quan ly cung sinh ra hang loat cac bat cap. Bat cap la quyen so huu nha chung cu lai phu thuoc vao ket luan kiem dinh cua co quan co tham quyen. Bat cap tiep theo la ke ca cac nha chung cu duoc tiep tuc cong nhan so huu khong co thoi han gan lien voi quyen su dung dat on dinh lau dai ma phai pha do de xay dung lai thi sau khi xay dung nha chung cu nay chi duoc "cong nhan quyen so huu co thoi han".',
        '2022-11-20 08:16:18',NULL,NULL,'Not Approved')

SELECT *
FROM ARTICLE

-- 6. Bảng Viewer_Article:
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'VIEWER_ARTICLE')
DROP TABLE VIEWER_ARTICLE

CREATE TABLE VIEWER_ARTICLE (
    Viewer_ID NVARCHAR(5) NOT NULL,
    Article_ID NVARCHAR(5) NOT NULL,
    Reading_Date DATETIME2(0) NOT NULL,
    Commenting_Date DATETIME2(0),
    Comment_Content TEXT
    CONSTRAINT PK_VIEWER_ARTICLE PRIMARY KEY(Viewer_ID, Article_ID),
    CONSTRAINT FK_VIEWER_ARTICLE_Viewer_ID FOREIGN KEY(Viewer_ID) REFERENCES VIEWER(Viewer_ID),
    CONSTRAINT FK_VIEWER_ARTICLE_Article_ID FOREIGN KEY(Article_ID) REFERENCES ARTICLE(Article_ID)
)

INSERT INTO VIEWER_ARTICLE (Viewer_ID, Article_ID, Reading_Date, Commenting_Date, Comment_Content)
VALUES  ('V003','A022','2021-06-03 00:23:57','2021-06-03 00:30:21','London is blue!'),
        ('V006','A012','2022-10-12 12:26:36',NULL,NULL),
        ('V003','A028','2022-09-15 20:25:12','2022-09-15 20:28:29','Hazard nen quay lai Chelsea'),
        ('V015','A028','2022-09-18 07:32:46','2022-09-18 07:33:24','Quay lai Chelsea de tim lai chien thang'),
        ('V010','A025','2022-11-16 17:39:12','2022-11-16 17:41:09','Cho do xang rat lau.'),
        ('V020','A030','2022-11-17 11:20:58','2022-11-17 11:21:02','Bo pho ve que!'),
        ('V009','A030','2022-11-17 14:20:23','2022-11-17 14:21:19','Khi hau trong lanh, mat me. Thanh pho dang song.'),
        ('V014','A030','2022-11-17 10:12:25','2022-11-17 10:15:11','Kiem tien mua nha o Da Lat'),
        ('V002','A017','2021-10-11 23:10:27','2021-10-11 23:12:48','Chuc mung Viet Nam ta.'),
        ('V001','A021','2021-08-21 12:08:09',NULL,NULL),
        ('V002','A003','2022-09-16 08:07:18',NULL,NULL),
        ('V012','A001','2022-11-17 15:49:58','2022-11-17 15:50:50','Day o quanh day'),
        ('V006','A005','2021-06-23 09:10:15',NULL,NULL),
        ('V006','A008','2022-10-27 14:17:19','2022-10-27 14:19:16','Co hoi moi cho Viet Nam cung nhu nuoc ban.'),
        ('V017','A021','2021-08-25 08:11:22',NULL,NULL),
        ('V015','A029','2022-10-12 16:29:30','2022-10-12 16:30:24','Dep, hien dai, tuy nhien gia van chua hap dan.'),
        ('V016','A025','2022-11-15 22:26:48','2022-11-15 22:28:57','Can dam bao du nguon cung xang dau cho nguoi dan!'),
        ('V014','A016','2022-11-18 07:12:28',NULL,NULL),
        ('V008','A013','2022-09-13 13:25:39','2022-09-13 13:30:22','Tuong doi de tra cuu.'),
        ('V014','A013','2022-10-19 12:33:38','2022-10-19 12:36:16','Da tra cuu thanh cong')

SELECT *
FROM VIEWER_ARTICLE

