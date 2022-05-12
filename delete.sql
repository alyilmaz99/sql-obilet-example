-----------------------------------DELETE 1--------------------------
----Arac IDsi 7 den kucuk olan seferlerin uyelerini sil
---Sefer bilet yolcu 
DELETE FROM Yolcu WHERE Yolcu.TC IN (SELECT TC FROM Yolcu Y INNER JOIN Bilet B ON B.YolcuTc = Y.TC INNER JOIN Sefer S ON 
S.SeferID = B.BiletinSeferiId WHERE S.KullanılacakAraçId < 7)

------------------------------------DELETE 2-------------------------
--2016 yılından önce alınmış mercedes markalı araçları sil
DELETE FROM Araç WHERE Araç.AlışTarihi<'2016-01-01' and Araç.Üretici='Mercedes'

---Delete 3 Şirketler İstanbul-Kars Seferi yapmama kararı aldı----
DELETE FROM Şirket_Sahip_Güzergah 
WHERE GüzergahId IN (SELECT şsg.GüzergahId FROM Şirket_Sahip_Güzergah şsg INNER JOIN  Güzergah g
on şsg.GüzergahId=g.GüzergahId where g.Adı LIKE '%Kars%')

-----------Delete 3 Herhangi Bir Güzergahın Geçmediği İllerin Rastgele 3 Tanesini sil------
Delete from İl
where İlId in(Select Top 3 i.İlId from İl i where i.İlId not in(Select iog.İlId from İl_Olur_Güzergah iog) ORDER BY NEWID())

-------------Delete 4 Hiç Bir Bilet Kesmeyen yada Sefere Katılmayan Personellerden rastgele 3 ünü Silmek----------------
Delete from Personel
Where PersonelId in(Select Top 3 p.PersonelId from Personel p where p.PersonelId not in(Select b.BiletiKesenPersonelId from Bilet b)
and p.PersonelId not in (Select pçs.PersonelId from Personellerin_Çalıştığı_Seferler pçs) Order By NEWID())
------------------------------------DELETE 5 ------------------------
DELETE FROM Peron WHERE PeronNo IN (SELECT P.PeronNo FROM Peron P INNER JOIN Bilet B 
ON B.BinişPeronu = P.PeronId INNER JOIN BiletTipi Bt ON Bt.Id = B.BiletTipi 
WHERE Bt.İsim = 'Ekonomi' AND B.BagajAğırlığı = 30
UNION
SELECT P.PeronNo FROM Peron P INNER JOIN Bilet B 
ON B.İnişPeronu = P.PeronId INNER JOIN BiletTipi Bt ON Bt.Id = B.BiletTipi 
WHERE Bt.İsim = 'Ekonomi' AND B.BagajAğırlığı = 40
)
