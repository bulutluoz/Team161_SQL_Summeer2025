/* 
====================================== UPDATE ========================================
Bir tablodaki mevcut verileri değiştirmek için kullanılır.

Güncelleme yapılırken mutlaka WHERE koşulu kullanılmalıdır, 
aksi halde tüm kayıtlar güncellenebilir. 

Güncelleme yapılırken güncellenecek sütunların veri türüne 
ve kurallara uygun değerler almasına dikkat edilmelidir.

Relational bir database'de update yaparken daha dikkatli olunmasi gerekir.
 
PRIMARY KEY sutununda olmayan hic bir datanin 
FOREIGN KEY sutununda kullanilamayacagi unutulmamalidir.



-----Syntax-----
UPDATE table_name
SET field1=''
WHERE condition;

NOT : UPDATE işlemlerinin yapılabilmesi için 
Ayarlar -> SQL Editor -> "Safe Updates" 
check box'indaki tik işareti kaldırılıp kaydedilmeli, 
sonrasında MySQL kapatılıp tekrar açılmalıdır.
========================================================================================
*/




 /*  
========================  ORNEK  ========================
 Kitaplar tablosundaki Araba Sevdası kitabinin yazar adını 
 Recaizade Mahmut Ekrem olarak güncelleyin.
=========================================================
 */


SELECT *
FROM kitaplar;


UPDATE kitaplar
SET yazar_adi = 'Recaizade Mahmut Ekrem'
WHERE kitap_adi = 'Araba sevdasi' ;


 /*  
========================  ORNEK  ========================
 Kitaplar tablosundaki Araba Sevdası kitabinin yayın yılını 1896, 
 kategorisini roman olarak güncelleyin.
=========================================================
 */

UPDATE kitaplar
SET yayin_yili = 'Recaizade'
WHERE kitap_adi = 'Araba sevdasi' ;

-- 	Error Code: 1366. Incorrect integer value: 'Recaizade' 
--  for column 'yayin_yili' at row 2	0.0081 sec


UPDATE kitaplar
SET yayin_yili = 1896 , kategori ='Roman'
WHERE kitap_adi = 'Araba sevdasi' ;



 /*  
========================  ORNEK  ========================
 Manav tablosunda 101 numaralı müşteriye satılan portakalın 
 fiyatını 20 olarak güncelleyin.
=========================================================
 */

SELECT *
FROM manav;


UPDATE Manav
SET urun_kg_fiyati = 20
WHERE id = 101 AND urun_ismi = 'portakal';



 /*  
========================  ORNEK  ========================
 Manav tablosunda tüm elma fiyatlarını 
 tablodaki en ucuz elma fiyatına getirecek şekilde güncelleyin.
=========================================================
 */

UPDATE manav
SET urun_kg_fiyati = ( SELECT MIN(urun_kg_fiyati)
					   FROM manav
                       WHERE urun_ismi = 'elma'
						)
WHERE urun_ismi = 'elma';

-- Error Code: 1093. 
-- You can't specify target table 'manav' for update in FROM


-- once istenen degeri bir variable'a atayalim 

SET @min_fiyat = (
    SELECT MIN(urun_kg_fiyati)
    FROM manav
    WHERE urun_ismi = 'elma'
);

-- 2. Değeri değişkenden alarak güncelle

UPDATE manav
SET urun_kg_fiyati = @min_fiyat
WHERE urun_ismi = 'elma';

-- 2 row(s) affected Rows matched: 3  Changed: 2  Warnings: 0	
-- Variable oluşturup deger atama işlemi sorgu içinde de yapilabilir.


 /*  
=========================  NOT  =========================
 MySQL'de değişkenler (variables), geçici veri saklamak için kullanılır. 
 Özellikle sorgular arasında değer taşımak 
 veya karmaşık işlemleri adım adım yapmak için oldukça faydalıdır.
=========================================================
 */

 /*  
========================  ORNEK  ========================
 Ogretmen_id'si 11 olan hocadan ders alan ve soyadı kaya olan öğrencinin 
 soyadını Aslan yapın.
=========================================================
 */

SELECT *
FROM ogretmenler;

SELECT *
FROM ogrenci;

UPDATE ogrenci
SET soyisim = 'Aslan'
WHERE soyisim = 'Kaya' AND ogrenci_no IN (	SELECT ogrenci_no
											FROM dersler
											WHERE ogretmen_id = 11);


 /*  
========================  NOT  ========================
 Related Tablolarda Kayit Guncelleme yaparken
 dikkat edilecek ana kural:
    PRIMARY KEY sutununda olmayan HIC BIR DATA
    FOREIGN KEY sutununda kullanilamaz
=========================================================
 */
 

 /*  
========================  ORNEK  ========================
 Dersler tablosunda id’si 20 olan kaydın notunu 88 yapın.
=========================================================
 */

UPDATE dersler
SET ortalama_not = 88
WHERE id = 50;

SELECT *
FROM dersler;



 /*  
========================  ORNEK  ========================
 Dersler tablosunda id’si 20 olan kaydın ogrenci_no’sunu 222 yapın.
=========================================================
 */

UPDATE dersler
SET ogrenci_no = 222
WHERE id = 50;


-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 
-- (`sqlvideodersleri`.`dersler`, CONSTRAINT `dersler_ibfk_1` FOREIGN KEY (`ogrenci_no`) REFERENCES `ogrenci` (`ogrenci_no`))

-- ILLA da degistirmek istenirse
-- once ogrenci tablosunda 145 numarali ogrencinin numarasini 222 yapip
-- sonra dersler tablosunda degisiklik yapmaliyiz

 /*  
========================  ORNEK  ========================
 Burcu Kaya'nin tarih dersindeki ortalama notunu 80 olarak guncelleyin.
=========================================================
 */


UPDATE dersler
SET ortalama_not = 80
WHERE ders_adi = 'tarih'  AND ogrenci_no = (SELECT ogrenci_no
											FROM ogrenci
											WHERE isim = 'Burcu' AND soyisim = 'Kaya');







 /*  
========================  ORNEK  ========================
 Okul veri tabaninda 
 101 numaralı öğrencinin Matematik dersindeki hocasını Zeynep Demir yapın.
=========================================================
 */

UPDATE dersler
SET ogretmen_id = (
					SELECT ogretmen_id
					FROM ogretmenler
					WHERE isim = 'Zeynep' AND soyisim = 'Demir'
					)
WHERE ogrenci_no = 101 AND ders_adi = 'matematik';






 /*  
========================  ORNEK  ========================
103 numaralı öğrencinin Tarih dersindeki ogretmen_id'sini 21 yapin
=========================================================
 */

UPDATE dersler
SET ogretmen_id = 21
WHERE ogrenci_no = 103 AND ders_adi ='tarih' ;


-- Error Code: 1452. Cannot add or update a child row: 
-- a foreign key constraint fails 
-- (`sqlvideodersleri`.`dersler`, CONSTRAINT `dersler_ibfk_2` FOREIGN KEY (`ogretmen_id`) REFERENCES `ogretmenler` (`ogretmen_id`))	0.0027 sec



 /*  
========================  ORNEK  ========================
 Zeynep Demir hocadan ders alan tüm öğrencilerin genel ortalama notunu hesaplayıp,
 Zeynep Demir hocadan ders alan tüm öğrencilerin notunu, 
 bu ortalama not olacak şekilde güncelleyin.
=========================================================
 */

-- asama asama gidelim

-- 1. Zeynep Demir hocanin ogretmen_id'sini bulup kaydedelim





-- zeynep hocanin id'sini kullanarak dersler tablosunda
-- zeynep hocadan ders alanlarin genel ortalamasini bulup kaydedelim



-- zeynep hocadan ders alan tum ogrencilerin notunu
-- @zeynepHocaOgrencileriGenelOrtalamaNot olacak sekilde guncelleyelim