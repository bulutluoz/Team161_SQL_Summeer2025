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
								 WHERE ogretmenler.ogretmen_id = dersler.ogretmen_id)
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
 







 /*  
========================  ORNEK  ========================
 Her bir ogretmenin, ismini, soyismini, bransini 
 ve dersini alan kac ogrenci oldugunu listeleyen bir QUERY yazin.
=========================================================
 */
 
 





 

 /*  
========================  ORNEK  ========================
 Matematik anlatan ogretmenlerin, ismini, soyismini, bransini 
 ve dersini alan kac ogrenci oldugunu listeleyen bir QUERY yazin.
=========================================================
 */
 
 






 /*  
========================  ORNEK  ========================
 Her bir ogrencinin ismini, soyismini ve kac ders aldigini yazdirin.
=========================================================
 */
 







 /*  
========================  ORNEK  ========================
 Soyadi Kaya olan ogrencilerin ismini, soyismini 
 ve aldigi tum derslerin genel not ortalamasini yazdirin.
=========================================================
 */
 
 






 
 /*  
========================  ORNEK  ========================
 mi c ile l arasinda olan ogrencilerin
ismini, soyismini ve aldigi dersler icinde en yuksek ortalamaya sahip olan dersin notunu yazdirin.
=========================================================
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
 