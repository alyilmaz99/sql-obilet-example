
----İstenen----
Select y.TC,y.İsim,y.Soyİsim,y.Telefon,ş.Şirketİsmi from Yolcu y
	inner join Bilet b on y.TC=b.YolcuTc 
	inner join Sefer s on s.SeferId=b.BiletinSeferiId 
	inner join Şirket ş on ş.ŞirketId=s.DüzenleyenŞirketId 
	where ş.Şirketİsmi='Pamukkale' and (Select i.İsim from Durak d inner join İlçe ilç on ilç.İlçeId=d.İlçeId inner join İl i on i.İlId=ilç.İlId where d.DurakId=b.BinişDurağı)='İzmir' 
	and  (Select i.İsim from Durak d inner join İlçe ilç on ilç.İlçeId=d.İlçeId inner join İl i on i.İlId=ilç.İlId where d.DurakId=b.İnişDurağı)='İstanbul'
	and  month(b.Tarih)=(select DATEPART(MONTH,GETDATE()))
intersect

Select y.TC,y.İsim,y.Soyİsim,y.Telefon,ş.Şirketİsmi from Yolcu y
	inner join Bilet b on y.TC=b.YolcuTc 
	inner join Sefer s on s.SeferId=b.BiletinSeferiId 
	inner join Şirket ş on ş.ŞirketId=s.DüzenleyenŞirketId 
	where ş.Şirketİsmi='Pamukkale' and (Select i.İsim from Durak d inner join İlçe ilç on ilç.İlçeId=d.İlçeId inner join İl i on i.İlId=ilç.İlId where d.DurakId=b.BinişDurağı)='Ankara' 
	and  (Select i.İsim from Durak d inner join İlçe ilç on ilç.İlçeId=d.İlçeId inner join İl i on i.İlId=ilç.İlId where d.DurakId=b.İnişDurağı)='İstanbul'
	and  month(b.Tarih)=(select DATEPART(MONTH,GETDATE()))

SELECT y.İsim,ş.Şirketİsmi,b.Tarih FROM Yolcu y
INNER JOIN Bilet b ON b.YolcuTc = y.TC
INNER JOIN Sefer s ON s.SeferId = b.BiletinSeferiId
INNER JOIN Şirket ş ON ş.ŞirketId=s.DüzenleyenŞirketId
WHERE b.Tarih>'2020-12-31' and b.Tarih<'2022-01-01' and ş.Şirketİsmi='Türk Hava Yollari' and MONTH(b.Tarih) IN (
SELECT TOP 3 MONTH(b.Tarih) AS 'Ay' FROM Bilet b
INNER JOIN Sefer s ON s.SeferId = b.BiletinSeferiId
INNER JOIN Şirket ş ON ş.ŞirketId=s.DüzenleyenŞirketId
where b.Tarih>'2020-12-31' and b.Tarih<'2022-01-01' and ş.Şirketİsmi='Türk Hava Yollari'
GROUP BY MONTH(b.Tarih)
ORDER BY COUNT(b.KoltukNo)  ASC)
-----Son---

---Select 1-----
SELECT  top 3 MIN(DATEDIFF(dd,Tarih,GETDATE())) as [Kaç Gün Önce Alındı?] ,b.SıraNo,p.PeronNo FROM Bilet b
INNER JOIN Peron p ON b.BinişPeronu = p.PeronId  
GROUP BY p.PeronNo , b.SıraNo order by [Kaç Gün Önce Alındı?] asc

--Select 2 En Çok Bilet Alan 3 yolcu---
SELECT top 3 COUNT(YolcuTc) as [kaç bilet aldı],y.İsim,y.Soyİsim FROM Yolcu y 
inner join Bilet on Bilet.YolcuTc=y.TC
GROUP BY YolcuTc,y.İsim,y.Soyİsim
-----Select 3 Esenler Otogardan Geçen Tüm Güzergahlar---------
SELECT g.Adı from Durak d inner join Güzergah_Sahip_Durak gsd on d.DurakId=gsd.DurakId inner join Güzergah g on g.GüzergahId=gsd.GüzergahId where d.Adı='Esenler Otogar'