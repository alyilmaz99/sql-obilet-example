CREATE DATABASE BiletDatabase
ON PRIMARY(NAME='BiletDb' ,FILENAME=N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Bilet_db.mdf',SIZE=5MB,MAXSIZE=200MB,FILEGROWTH=10MB)
LOG ON (NAME='BiletDb_log' ,FILENAME=N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Bilet_log.ldf',SIZE=2MB,MAXSIZE=100MB,FILEGROWTH=2MB)
GO
use BiletDatabase
--İl Tablosunun Oluşturulması--
CREATE Table İl(
İlId int IDENTITY(1,1) PRIMARY KEY,
İsim nvarchar(20) UNIQUE NOT NULL
)
GO
--İlçe
CREATE Table İlçe(
İlçeId int IDENTITY(1,1) PRIMARY KEY,
İsim nvarchar(20) UNIQUE NOT NULL,
İlId int FOREIGN KEY REFERENCES İl(İlId) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL
)
GO
--Durak
CREATE Table Durak(
DurakId int IDENTITY(1,1) PRIMARY KEY,
Adı nvarchar(20) UNIQUE NOT NULL,
İlçeId int FOREIGN KEY REFERENCES İlçe(İlçeId) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL
)
GO
--Güzergah
CREATE Table Güzergah(
GüzergahId int IDENTITY(1,1) PRIMARY KEY,
Adı nvarchar(20) UNIQUE NOT NULL,
)
GO
--Güzergahların Geçtiği İller
CREATE Table İl_Olur_Güzergah(
Id int Identity(1,1) PRIMARY KEY,
İlId int FOREIGN KEY REFERENCES İl(İlId) ON DELETE CASCADE ON UPDATE NO ACTION NOT NULL,
GüzergahId int FOREIGN KEY REFERENCES Güzergah(GüzergahId) ON DELETE NO ACTION ON UPDATE NO ACTION
)
GO
--Güzergahlarda Olan Duraklar
CREATE Table Güzergah_Sahip_Durak(
Id int Identity(1,1) PRIMARY KEY,
SıraId int,
DurakId int FOREIGN KEY REFERENCES Durak(DurakId) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL,
GüzergahId int FOREIGN KEY REFERENCES Güzergah(GüzergahId) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL
)
GO


--Peron
CREATE Table Peron(
PeronId int IDENTITY(1,1) PRIMARY KEY,
PeronNo int  NOT NULL,
DurakId int FOREIGN KEY REFERENCES Durak(DurakId) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL
)
GO
--Şirket
CREATE Table Şirket(
ŞirketId int IDENTITY(1,1) PRIMARY KEY,
Şirketİsmi nvarchar(20)  NOT NULL,
Logo nvarchar(100)
)
GO

--Güzergahlarda Sefer Yapan Şirketler
CREATE Table Şirket_Sahip_Güzergah(
Id int Identity(1,1) PRIMARY KEY,
ŞirketId int FOREIGN KEY REFERENCES Şirket(ŞirketId) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL,
GüzergahId int FOREIGN KEY REFERENCES Güzergah(GüzergahId) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL
)
GO


--Araç
CREATE Table Araç(
AraçId int IDENTITY(1,1) PRIMARY KEY,
Üretici nvarchar(20)  NOT NULL,
Kapasite int Not Null,
AraçTipi nvarchar(10) not null,
Model nvarchar(10) NOT NULL,
AktiflikDurumu smallint default 0 Not Null,
AlışTarihi smalldatetime Not Null,
AraçKodu nvarchar(10) NOT NULL,
ŞirketId int FOREIGN KEY REFERENCES Şirket(ŞirketId) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL 
)
GO
--Şube
CREATE Table Şube(
ŞubeId int IDENTITY(1,1) PRIMARY KEY,
Telefon Char(10) Not Null,
Adres nvarchar(max) not null,
ŞirketId int FOREIGN KEY REFERENCES Şirket(ŞirketId) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL 
)
GO
--Personel
CREATE Table Personel(
PersonelId int IDENTITY(1,1) PRIMARY KEY,
İsim nvarchar(10) Not Null,
Soyİsim nvarchar(10) Not Null,
Telefon varchar(15) Not Null,
Mail nvarchar(50) Not Null,
ŞubeId int FOREIGN KEY REFERENCES Şube(ŞubeId) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL 
)
GO
--Bilet Tipi
CREATE Table BiletTipi(
Id int IDENTITY(1,1) PRIMARY KEY,
İsim nvarchar(20) Not Null,
Ücret float Not Null,
ŞirketId int FOREIGN KEY REFERENCES Şirket(ŞirketId) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL 
)
GO
--Sefer
CREATE Table Sefer(
SeferId int IDENTITY(1,1) PRIMARY KEY,
Enlem nvarchar(20),
Boylam nvarchar(20),
Türü smallint not null,
GidişYeri nvarchar(50) NOT NULL,
KalkışDurağı int FOREIGN KEY REFERENCES Durak(DurakId) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
BitişDurağı int FOREIGN KEY REFERENCES Durak(DurakId) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL,
VarışSaatTarihi datetime Not Null,
KalkışSaatTarihi datetime Not Null,
KullanılacakAraçId int FOREIGN KEY REFERENCES Araç(AraçId) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
DüzenleyenŞirketId int FOREIGN KEY REFERENCES Şirket(ŞirketId) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL 
)
GO
--Yolcu
CREATE Table Yolcu(
TC VARCHAR(11) PRIMARY KEY,
İsim nvarchar(20)  NOT NULL,
Soyİsim nvarchar(20)  NOT NULL,
Cinsiyet bit Not Null,
Telefon NVARCHAR(20),
Mail nvarchar(20)  NOT NULL,
Yaş int  NOT NULL,
)
GO

--Bilet
CREATE Table Bilet(
SıraNo int IDENTITY(1,1) PRIMARY KEY ,
CheckInDurumu bit,
CheckInTarihSaati datetime,
Ücret float Not Null,
Tarih date Not Null,
KoltukNo int not null,
KesilmeTarihi datetime not null,
Durumu bit default 1 not null,
Seri char(1) not null,
BagajAğırlığı float not null,
BiletTipi int FOREIGN KEY REFERENCES BiletTipi(Id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
BiletiKesenPersonelId int FOREIGN KEY REFERENCES Personel(PersonelId) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL,
YolcuTc VARCHAR(11) FOREIGN KEY REFERENCES Yolcu(TC) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
BinişDurağı int FOREIGN KEY REFERENCES Durak(DurakId) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
İnişDurağı int FOREIGN KEY REFERENCES Durak(DurakId) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL,
BinişPeronu int FOREIGN KEY REFERENCES Peron(PeronId) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL,
İnişPeronu int FOREIGN KEY REFERENCES Peron(PeronId) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL,
BiletinSeferiId int FOREIGN KEY REFERENCES Sefer(SeferId) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL,
)
GO

--Personellerin Çalıştığı Seferler
CREATE Table Personellerin_Çalıştığı_Seferler(
Id int IDENTITY(1,1) PRIMARY KEY,
SeferId int FOREIGN KEY REFERENCES Sefer(SeferId) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL,
PersonelId int FOREIGN KEY REFERENCES Personel(PersonelId) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL,
)
GO
--Ödeme Tipi
CREATE Table ÖdemeTipi(
Id int IDENTITY(1,1) PRIMARY KEY,
İsim nvarchar(20)  NOT NULL,
)
GO
--Seferlerin Durakları
CREATE Table Seferlerin_Durakları(
Id int IDENTITY(1,1) PRIMARY KEY,
DuraktanÇıkışTarihSaati datetime  NOT NULL,
DurağaGirişTarihSaati datetime  NOT NULL,
Sıra int not null,
DurakId int FOREIGN KEY REFERENCES Durak(DurakId) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL,
SeferId int FOREIGN KEY REFERENCES Sefer(SeferId) ON DELETE NO ACTION ON UPDATE NO ACTION NOT NULL,
)
GO

--Ödeme Bilgisi
CREATE Table ÖdemeBilgisi(
Id int IDENTITY(1,1) PRIMARY KEY,
KartNo char(12),
KartTürü bit,
CvcNo char(3),
Nakit float,
ÖdemeTipiniIdsi  int FOREIGN KEY REFERENCES ÖdemeTipi(Id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
BiletId  int FOREIGN KEY REFERENCES Bilet(SıraNo) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL
)
GO















