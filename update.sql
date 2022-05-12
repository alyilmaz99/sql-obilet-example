
-----Update 1 -------- Ak Turizm ve Ak Aksu Turizm birleşme kararı aldı ve yeni şubelerini Maraşta açtılar. İsimlerini Ede Turizm koydular

UPDATE Şirket
Set Şirketİsmi ='EDE TURIZM'
From Şirket
inner join Şube on Şirket.ŞirketId=Şube.ŞubeId
where Şirketİsmi='Ak Turizm' or Şirketİsmi='Ak Aksu Turizm'  

-----Update 2 ---------İsmine göre cinsiyeti yanlışlıkla Erkek girilen 2 kişinin cinsiyeti kız yapıldı 

UPDATE Yolcu
Set Cinsiyet =1
From Yolcu
inner join Bilet on Bilet.YolcuTc=Yolcu.TC
where Yolcu.İsim='ElifFeyza' or Yolcu.İsim='Almina'

---Update 3  Chechintarihi null olmayan biletlerin check in durumunu 1 yap----
Update Bilet
Set CheckInDurumu=1
where CheckInTarihSaati IS NOT NULL

---Update 4 350 kapasiteden az uçaklar pandemi nedeniyle aktifliğine son verildi-----
Update Araç
Set AktiflikDurumu=0
where AraçTipi='Uçak' and Kapasite<350
--Update 5 Bilet Ücretlerini Bilet Tipinin Ücretine Eşitle--
Update Bilet
Set Ücret=bt.Ücret
from Bilet b inner join BiletTipi bt on b.BiletTipi=bt.Id
where b.Ücret <>bt.Ücret
---Update 6 Pamukkale Esenlerde Çalışanın rastgele 2 işçi Pamukkale Aştiye Aktardı
Update Personel
Set ŞubeId=11
where İsim in(Select TOP 2 İsim FROM Personel where ŞubeId=1 order by NEWID())

