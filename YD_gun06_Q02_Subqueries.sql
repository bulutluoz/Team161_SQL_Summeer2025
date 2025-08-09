/*
================================= SUBQUERY =================================
    Subquery (alt sorgu), bir sorgunun içinde yer alan 
    ve genellikle SELECT, FROM veya WHERE ifadelerinde kullanılan başka bir sorgudur. 
    
    Alt sorgu, dış sorguya veri sağlamak için çalışır. 
    Genellikle filtreleme, karşılaştırma veya hesaplama işlemleri için kullanılır.

    Örneğin, onceki derste olusturulan okul relational schema'sinda 
    matematik dersini alan öğrenci isimleri sorulsa

    Bir query ile dersler tablosunda matematik dersi alan öğrencilerin numaraları bulanabilir 
    ama öğrencilerin isimlerini bulmak için öğrenci numaraları ile öğrenci tablosunda alt sorgu yapılmalıdır.
============================================================================
*/





 /*  
========================  ORNEK  ========================
 Okul veri tabanında matematik dersi alan öğrenci isim ve soy isimlerini yazdırın.
=========================================================
 */
 
-- burada insan olarak dusunulse 
-- once dersler tablosundan matematik dersi (11,12,13 numarali dersler)alan 
-- ogrenci numaralari bulunur


SELECT DISTINCT ogrenci_no
FROM dersler
WHERE ders_adi = 'Matematik'
ORDER BY ogrenci_no;




-- Sonra bu numaralara sahip ogrencilerin isim ve soyisimleri 
-- ogrenci tablosundan sorgulanir

SELECT isim, soyisim
FROM ogrenci
WHERE ogrenci_no IN (101,103,109,118,129,141,151);



-- Ama bu yol dinamik değildir yani tablo degisse calismaz, 
-- yeniden manuel kontrol edilip düzeltilmesi gerekir.

-- Kodlarin dinamik olmasi icin 
-- ogrencilerin numaralarini getiren ilk sorgu
-- ikinci sorgudaki IN parantezinin icine yazilabilir.


SELECT isim, soyisim
FROM ogrenci
WHERE ogrenci_no IN (SELECT DISTINCT ogrenci_no
					 FROM dersler
					 WHERE ders_adi = 'Matematik'
					 ORDER BY ogrenci_no);


-- fizik dersini alan ogrencilerin isim ve soyisimlerini yazdirin


SELECT isim, soyisim
FROM ogrenci
WHERE ogrenci_no IN (SELECT DISTINCT ogrenci_no
					 FROM dersler
					 WHERE ders_adi = 'Fizik'
					 ORDER BY ogrenci_no);



 /*  
========================  ORNEK  ========================
 Ornek :  okul veri tabaninda herhangi bir derste notu 85'den fazla olan ogrencilerin 
 isim ve soyisimlerini yazdirin.
 Bir ogrenci birden fazla dersten yuksek not almissa tekrar yazilmasin
=========================================================
 */
 
 -- once dersler tablosundan yüksek not alan ogrenci numaralari tekrarsiz olarak bulunur

SELECT DISTINCT ogrenci_no
FROM dersler
WHERE ortalama_not > 85;  

-- 101,103,112,123,129,131,137,145,157,160


-- Sonra bu numaralara sahip ogrencilerin isim ve soyisimleri ogrenci tablosundan sorgulanir

SELECT isim,soyisim
FROM ogrenci
WHERE ogrenci_no IN (101,103,112,123,129,131,137,145,157,160);

-- ogrencilerin numaralarini getiren ilk sorguyu
-- ikinci sorgudaki IN parantezinin icine yazilabilir.

SELECT isim,soyisim
FROM ogrenci
WHERE ogrenci_no IN (SELECT DISTINCT ogrenci_no
				     FROM dersler
					 WHERE ortalama_not > 85);



-- ortalama notu 80 ile 90 arasinda olan ogrencilerin isim ve soyisimlerini yazdirin

SELECT isim,soyisim
FROM ogrenci
WHERE ogrenci_no IN (SELECT DISTINCT ogrenci_no
				     FROM dersler
					 WHERE ortalama_not BETWEEN 80 AND 90);



 /*  
========================  ORNEK  ========================
 okul veri tabaninda matematik dersinden en yüksek not ortalamasina sahip ogrencinin 
 isim ve soyismini yazdirin.
=========================================================
 */
 
 -- once dersler tablosundan en yüksek matematik notuna sahip ogrencinin numarasini bulalim

SELECT MAX(ortalama_not) AS en_yuksek_not
FROM dersler
WHERE ders_adi = 'Matematik';
-- 92



-- Sonra matematikten 92 alan ogrencinin numarasi dersler tablosundan sorgulanir

SELECT ogrenci_no
FROM dersler
WHERE ders_adi = 'Matematik' AND ortalama_not = 92;

-- 129


-- Son olarak 129 numarali ogrencinin isim ve soyisimi ogrenci tablosundan sorgulanir

SELECT isim,soyisim
FROM ogrenci
WHERE ogrenci_no = 129;
-- Elif Yilmaz


-- Kodlarin dinamik olmasi icin son sorgudan başlayarak sorgular İc ice yazilabilir.

SELECT isim,soyisim
FROM ogrenci
WHERE ogrenci_no = (SELECT ogrenci_no
					FROM dersler
					WHERE ders_adi = 'Matematik' AND ortalama_not = (SELECT MAX(ortalama_not) AS en_yuksek_not
																	 FROM dersler
																	 WHERE ders_adi = 'Matematik'));










 