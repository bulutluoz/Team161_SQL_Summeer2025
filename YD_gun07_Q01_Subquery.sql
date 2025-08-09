/*  
========================  ORNEK  ========================
 okul veri tabaninda Zeynep Demir hocadan ders alan ogrencilerin sayisini yazdirin.
=========================================================
 */
 
-- once ogretmenler tablosundan Zeynep Demir hocanin ogretmen_id’sini bulalim
SELECT ogretmen_id
FROM ogretmenler
WHERE isim = 'Zeynep' AND soyisim = 'Demir';

-- 12


-- Sonra dersler tablosundan ogretmen_id’si 12 olan ogrenci sayisi sorgulanir

SELECT COUNT(DISTINCT ogrenci_no) AS ogrenci_sayisi
FROM dersler
WHERE ogretmen_id = 12;




-- Kodlarin dinamik olmasi icin son sorgudan başlayarak sorgular İc ice yazilabilir.


SELECT COUNT(DISTINCT ogrenci_no) AS ogrenci_sayisi
FROM dersler
WHERE ogretmen_id = (
						SELECT ogretmen_id
						FROM ogretmenler
						WHERE isim = 'Zeynep' AND soyisim = 'Demir'
				);





 /*  
========================  ORNEK  ========================
 okul veri tabaninda 129 numarali ogrencinin ingilizce hocasinin 
 ismini ve soyismini yazdirin.
=========================================================
 */
 
SELECT ogretmen_id 
FROM dersler
WHERE ogrenci_no = 129 AND ders_adi = 'ingilizce';
-- 17


-- Kodlarin dinamik olmasi icin son sorgudan başlayarak sorgular İc ice yazilabilir.

SELECT isim, soyisim
FROM ogretmenler
WHERE ogretmen_id = (
						SELECT ogretmen_id 
						FROM dersler
						WHERE ogrenci_no = 129 AND ders_adi = 'ingilizce'
					);




 
 
 /*  
========================  ORNEK  ========================
 okul veri tabaninda bir dersten bir ogrencinin aldigi en yuksek notu bulun
bu notu veren hocanin ismini ve soyismini yazdirin.
=========================================================
 */
 
-- once dersler tablosundan bir dersten bir ogrencinin aldigi en yüksek ortalama bulunur

SELECT MAX(ortalama_not) AS en_yuksek_not
FROM dersler;

-- 95



-- Sonra dersler tablosundan bu ortalama notu veren hocanin ogretmen_id’si sorgulanir

SELECT ogretmen_id
FROM dersler
WHERE ortalama_not = 95;
-- 14



-- Son olarak ogretmenler tablosundan ogretmen_id’si 14 olan ogretmenin isim ve soyismi sorgulanir
-- ayni notu veren birden fazla hoca olabilecegi icin IN kullanilabilir

SELECT isim, soyisim
FROM ogretmenler
WHERE ogretmen_id IN (14);



-- Kodlarin dinamik olmasi icin son sorgudan başlayarak sorgular İc ice yazilabilir.

SELECT isim, soyisim
FROM ogretmenler
WHERE ogretmen_id IN (
						SELECT ogretmen_id
						FROM dersler
						WHERE ortalama_not = (
												SELECT MAX(ortalama_not)
												FROM dersler
                        )
                        );

-- Mehmet Koc



 

/* 
======================== SELECT ile SUBQUERY ===========================

SELECT ile SUBQUERY kullanimi :
  
-- SELECT -- hangi sutunlari(field) getirsin
-- FROM -- hangi tablodan(table) getirsin
-- WHERE -- hangi satirlari(record) getirsin
  
 * Yazdığımız QUERY'lerde SELECT satırında field isimleri kullanıyoruz. 
   Eğer SELECT satırında bir SUBQUERY yazılırsa, sonuç olarak tek bir kayıt değil bir field döndürür.

 * SELECT satirinda SUBQUERY yazacaksak SUM, COUNT, MIN, MAX ve AVG gibi 
  fonksiyonlar kullanilir. Bu fonksiyonlara AGGREGATE FUNCTION denir.
  
 => Interview Question : Subquery'i Select satirinda kullanirsaniz ne ile 
kullanmaniz gerekir?

=========================================================================\
*/ 
 

 /*  
========================  ORNEK  ========================
 Her bir ogretmenin, ismini, soyismini, bransini 
 ve dersini alan ogrencilerin notlarinin ortalamasini listeleyen bir QUERY yazin.
=========================================================
 */
 
 
-- SELECT isim, soyisim, ders_adi, ogretmenlerin_dersini_alan_ogrencilerin_not_ortalamasi
 
 
 SELECT isim, soyisim, ders_adi,(SELECT AVG(ortalama_not)
								 FROM dersler
								 WHERE ogretmenler.ogretmen_id = dersler.ogretmen_id) AS ogretmenin_genel_not_ortalamasi
FROM ogretmenler;                                 
 
 
/*


isim.   soyisim.   ders_adi.   ogretmenlerin_dersini_alan_ogrencilerin_not_ortalamasi
Ahmet.  Yildiz.    Matematik.  


Verilen görev incelendiğinde, ismini, soyismini, branş bilgilerinin ogretmenler tablosundan bulunabileceği görülecektir.
Not ortalamasi ise dersler tablosundaki kayitlardan Aggregate fonksiyonu kullanılarak elde edilebilir.
Iki tablo arasinda baglanti ogretmen_id ile kurulabilir.


SELECT isim,soyisim,ders_adi, (buraya ortlama notu hesaplayan bir sorgu gelmeli)
FROM ogretmenler;

ornegin sadece ogretmen_id 11 olan ogretmenin 
ogrencilerinin genel not ortalamasini goruntulemek icin
asagidaki query yazilabilirdi

SELECT AVG(ortalama_not)  
FROM dersler 
WHERE ogretmen_id = 11) AS '11 nolu ogretmenin ogrencilerinin genel not ortalamasi'

*/

SELECT ogretmen_id, AVG(ortalama_not)
FROM dersler
GROUP BY ogretmen_id;








 /*  
========================  ORNEK  ========================
 Her bir ogretmenin, ismini, soyismini, bransini 
 ve dersini alan ogrenciler icinde en yuksek ortalama notu 
 listeleyen bir QUERY yazin.
=========================================================
 */
 
SELECT isim, soyisim, ders_adi, (SELECT MAX(ortalama_not)
								 FROM dersler
                                 WHERE ogretmenler.ogretmen_id = dersler.ogretmen_id) AS ogretmenin_verdigi_MAX_not
FROM ogretmenler;



SELECT ogretmen_id, MAX(ortalama_not)
FROM dersler
GROUP BY ogretmen_id;



 /*  
========================  ORNEK  ========================
 Her bir ogretmenin, ismini, soyismini, bransini 
 ve dersini alan kac ogrenci oldugunu listeleyen bir QUERY yazin.
=========================================================
 */
 
 
SELECT isim, soyisim, ders_adi , (	SELECT COUNT(ogretmen_id)
									FROM dersler
									WHERE ogretmenler.ogretmen_id = dersler.ogretmen_id) AS ogretmenden_ders_alan_ogrenci_sayisi
FROM ogretmenler;

-- 11 numarali ogretmenin dersini alan kac ogrenci oldugunu listeleyen bir QUERY yazin.

SELECT COUNT(ogretmen_id)
FROM dersler
WHERE ogretmen_id = 11;


 

 /*  
========================  ORNEK  ========================
 Matematik anlatan ogretmenlerin, ismini, soyismini, bransini 
 ve dersini alan kac ogrenci oldugunu listeleyen bir QUERY yazin.
=========================================================
 */
 
 
SELECT isim, soyisim, ders_adi,(SELECT COUNT(ogrenci_no)
								FROM dersler
								WHERE ogretmenler.ogretmen_id = dersler.ogretmen_id) AS ogretmenden_ders_alan_ogrenci_sayisi
FROM ogretmenler
WHERE ders_adi = 'matematik';


-- 11 numarali ogretmenin dersini alan ogrenci sayisi
SELECT COUNT(ogrenci_no)
FROM dersler
WHERE ogretmen_id = 11;


 /*  
========================  ORNEK  ========================
 Her bir ogrencinin ismini, soyismini 
 ve kac ders aldigini yazdirin.
=========================================================
 */
 
SELECT isim, soyisim , (SELECT COUNT(ogrenci_no) 
						FROM dersler
						WHERE ogrenci.ogrenci_no = dersler.ogrenci_no) AS "aldigi ders sayisi"
FROM ogrenci; 



-- 101 numarali ogrencinin kac ders aldigini yazdirin.

SELECT COUNT(ogrenci_no) 
FROM dersler
WHERE ogrenci_no = 101;



 /*  
========================  ORNEK  ========================
 Soyadi Kaya olan ogrencilerin ismini, soyismini 
 ve aldigi tum derslerin genel not ortalamasini yazdirin.
=========================================================
 */
 
SELECT ogrenci_no, isim, soyisim, ( SELECT AVG(ortalama_not)
									FROM dersler
									WHERE ogrenci.ogrenci_no = dersler.ogrenci_no) AS "genel not ortalamasi"
FROM ogrenci
WHERE soyisim = 'Kaya';



-- 103 numarali ogrencinin aldigi tum derslerin genel not ortalamasini
SELECT AVG(ortalama_not)
FROM dersler
WHERE ogrenci_no = 103;

 
 /*  
========================  ORNEK  ========================
 Ismi c ile l arasinda olan ogrencilerin ismini, soyismini 
 ve aldigi dersler icinde en yuksek ortalamaya sahip olan dersin notunu yazdirin.
=========================================================
 */
 
SELECT isim, soyisim, (	SELECT MAX(ortalama_not)
						FROM dersler
						WHERE ogrenci.ogrenci_no = dersler.ogrenci_no) AS "ogrencinin MAX ders notu"
FROM ogrenci
WHERE isim BETWEEN 'c' AND 'l';


-- 103 numarali ogrencinin aldigi dersler icinde en yuksek ortalamaya sahip olan dersin notunu
SELECT MAX(ortalama_not)
FROM dersler
WHERE ogrenci_no = 103;


-- tum ogrencilerin no, isim,soyisim ve ilcelerini listeleyin

SELECT ogrenci_no, isim, soyisim , (SELECT ilce
									FROM adresler
									WHERE ogrenci.ogrenci_no = adresler.ogrenci_no)
FROM ogrenci;


-- 103 numarali ogrencinin ilcesini yazdirin
SELECT ilce
FROM adresler
WHERE ogrenci_no = 103;


-- Sincan'da oturan ogrencilerin ogrenci_no, sokak adi ve daire no'larini
-- yanina da isim ve soyisimlerini yazdirin


SELECT ogrenci_no, sokak, ev_no , (	SELECT isim
									FROM ogrenci
									WHERE adresler.ogrenci_no = ogrenci.ogrenci_no) AS isim, 
                                    (SELECT soyisim
									FROM ogrenci
									WHERE adresler.ogrenci_no = ogrenci.ogrenci_no) AS soyisim
FROM adresler
WHERE ilce = 'Sincan';


-- 107 numarali ogrencinin isim ve soyismini yazdirin

SELECT isim, soyisim
FROM ogrenci
WHERE ogrenci_no = 107;

/*
	Select satirinda subquery konusuna ekstra soru cozumu icin 
    1️⃣ Tablo Oluşturma
sql
Kopyala
Düzenle
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
2️⃣ Örnek Veri Ekleme
sql
Kopyala
Düzenle
INSERT INTO Customers (customer_id, name, city) VALUES
(1, 'Ahmet', 'İstanbul'),
(2, 'Ayşe', 'Ankara'),
(3, 'Mehmet', 'İzmir'),
(4, 'Fatma', 'İstanbul'),
(5, 'Ali', 'Bursa');

INSERT INTO Orders (order_id, customer_id, order_date, amount) VALUES
(101, 1, '2025-01-05', 500.00),
(102, 1, '2025-02-10', 300.00),
(103, 2, '2025-02-15', 150.00),
(104, 3, '2025-03-01', 700.00),
(105, 4, '2025-03-05', 250.00),
(106, 5, '2025-04-01', 400.00);
3️⃣ Subquery ile Çözebileceğin 5 Soru
Toplam harcaması 400’den fazla olan müşterilerin isimlerini getir.
(Subquery ile Orders tablosundan toplamları al, Customers tablosuyla eşleştir.)

İstanbul’da yaşayan ve siparişi olan müşterilerin isimlerini getir.
(Subquery ile İstanbul müşterilerini bulup Orders’taki customer_id ile eşleştir.)

Tüm müşteriler arasında en yüksek sipariş tutarını veren müşterinin adını getir.
(Subquery ile max(amount) bul, sonra Customers tablosundan ismini çek.)

Sipariş sayısı 1’den fazla olan müşterilerin isimlerini getir.
(Subquery ile group by + count kullan, Customers ile bağla.)

Tutarı ortalama sipariş tutarından yüksek olan siparişleri ve müşteri isimlerini getir.
(Subquery ile avg(amount) hesapla, amount > ortalama olanları listele.)
*/

/* 
======================== EXISTS CONDITION ===========================
EXISTS Condition subquery'ler ile kullanilir. IN ifadesinin kullanimina
benzer olarak, EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen 
degerlerin icerisinde bir degerin olmasi veya olmamasi durumunda islem 
yapilmasini saglar.
======================================================================
*/
 
 
 
 



 /*  
========================  ORNEK  ========================
 Nisan_satislar ve mayis satislar iki tablo oluşturup null olmayan kayitlar ekleyin.
=========================================================
 */
 








 
 



 /*  
========================  ORNEK  ========================
 Her iki ayda da ayni id ile satilan urunlerin 
 urun_id'lerini ve urunleri mayis ayinda alanlarin isimlerini 
 getiren bir query yaziniz.
=========================================================
 */
 
 





 
 

 /*  
========================  ORNEK  ========================
 mayis ayinda olup, nisan ayinda olmayan id'leri 
 ve mayis ayinda o urunu alan müşteri isimlerini görüntüleyin.
=========================================================
 */
 