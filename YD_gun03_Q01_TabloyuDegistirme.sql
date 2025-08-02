/*
===============================================
		  TABLOYU DEGISTIRME - ALTER TABLE
===============================================
 ALTER TABLE, SQL'de mevcut bir veri tabanı tablosunun yapısını değiştirmek için kullanılır. 

 Bu komut sayesinde, 
	- tabloya yeni sütunlar ekleyebilir, 
	- mevcut sütunları değiştirebilir veya silebilir, 
	- sütunların veri türlerini güncelleyebilir, 
	- sütunlara kısıtlamalar (constraints) ekleyebilir 
	veya mevcut kısıtlamaları kaldırabilirsiniz. 


	Sütun ekleme:
	ALTER TABLE tablo_adi 
    ADD yeni_sutun_adi veri_tipi;

	Sütun silme:
	ALTER TABLE tablo_adi DROP COLUMN sutun_adi;
    
	Sütun adını değiştirme (bazı sistemlerde RENAME COLUMN gereklidir):
	ALTER TABLE tablo_adi RENAME COLUMN eski_sutun_adi TO yeni_sutun_adi;

	Sütunun veri tipini değiştirme:
	ALTER TABLE tablo_adi ALTER COLUMN sutun_adi TYPE yeni_veri_tipi;
    
	Sütunun varsayılan değerini değiştirme:
	ALTER TABLE tablo_adi ALTER COLUMN sutun_adi SET DEFAULT varsayilan_deger;

	Varsayılan değeri kaldırma:
	ALTER TABLE tablo_adi ALTER COLUMN sutun_adi DROP DEFAULT;

	Tabloyu yeniden adlandırma:
	ALTER TABLE eski_tablo_adi RENAME TO yeni_tablo_adi;
 */
 
-- yeni bir gune baslarken, dogru database ile baglantimizin devam ettigini 
-- kontrol etmekte fayda var
-- eger baglantimizda sorun varsa USE komutunu tekrar calistirmak gerekir 
-- ogrenciler tablosundaki tum kayitlari goruntuleyin
SELECT *
FROM ogrenciler; 
 
 
/*
===============================================
		   ALTER TABLE - Sutun Ekleme
===============================================

*************** SYNTAX ***************
ALTER TABLE tablo_adi 
ADD sütun_adi + dataType;

*/
 
 
 /*  
========================  ORNEK  ========================
 Ornek : Kitaplar tablosuna sayfa sayisi ve fiyat sutunlarini ekleyin.
=========================================================
 */
 
SELECT *
FROM kitaplar;

ALTER TABLE kitaplar
ADD sayfa_sayisi INT, 
ADD fiyat DOUBLE(6,2);



/*
===============================================
  ALTER TABLE - Sütun Silme
===============================================

*************** SYNTAX ***************
ALTER TABLE tablo_adi 
DROP COLUMN  sütun_adi;
*/
 
/*  
========================  ORNEK  ========================
  Personel tablosundaki maas sütununu silin
=========================================================
 */ 

SELECT *
FROM personel;

ALTER TABLE personel
DROP COLUMN maas;


 
/*  
========================  ORNEK  ========================
  Kitaplar tablosundaki sayfa sayisi sutununu silin
=========================================================
 */ 

SELECT *
FROM kitaplar;

ALTER TABLE kitaplar
DROP COLUMN sayfa_sayisi;



/*
===============================================
		ALTER TABLE - Sütun Adını Değiştirme
===============================================

*************** SYNTAX ***************
ALTER TABLE tablo_adi 
RENAME COLUMN  eskiSütunAdi TO yeniSütunAdi;
*/

/*  
========================  ORNEK  ========================
 Personel tablosundaki pozisyon sutununun adini sorumluluk olarak degistirin
=========================================================
 */

SELECT *
FROM personel;


ALTER TABLE personel
RENAME COLUMN pozisyon TO sorumluluk;




 /*  
========================  ORNEK  ========================
Personel tablosundaki soyadi sutununun adini lastname olarak degistirin
=========================================================
 */
 
ALTER TABLE personel
RENAME COLUMN soyadi TO lastname;


 /*
 ===============================================
  ALTER TABLE - Sütunun Data Type Değiştirme
 ===============================================

*************** SYNTAX ***************
ALTER TABLE tablo_adi 
MODIFY COLUMN  sütun_adi + yeniDataType;
*/
 
/*  
========================  ORNEK  ========================
  Kitaplar tablosundaki fiyat sutununun data turunu degistirin .
=========================================================
 */ 
 
 SELECT *
 FROM kitaplar;
 
 ALTER TABLE kitaplar
 MODIFY COLUMN fiyat INT;
 
 