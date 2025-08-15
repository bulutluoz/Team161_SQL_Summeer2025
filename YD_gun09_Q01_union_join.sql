/*
====================== UNION ======================

 birden fazla SELECT sorgusunun sonuçlarını tek bir liste halinde birleştirmek için kullanılır. 

   Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    UNION 
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
    
    NOT: UNION operatoru SADECE benzersiz degerleri alir. 
    Benzer verileri almak icin UNION ALL kullanilir.
    
=========================================================
 */

  
  
/*  
========================  ORNEK  ========================
 Nisan ve mayis aylarinda Toyota alan müşteri isimlerini listeleyin.
=========================================================
 */
 
SELECT musteri_isim
FROM nisan_satislar
WHERE urun_isim = 'Toyota'

UNION

SELECT musteri_isim
FROM mayis_satislar
WHERE urun_isim = 'Toyota';

-- sonuclari isim sirali olarak listeleyin

SELECT musteri_isim
FROM nisan_satislar
WHERE urun_isim = 'Toyota'

UNION

SELECT musteri_isim
FROM mayis_satislar
WHERE urun_isim = 'Toyota'
ORDER BY musteri_isim;
 
 

/*  
========================  ORNEK  ========================
 Nisan ayindaki müşterileri ve mayis ayinda satilan urun isimlerini listeleyin.
=========================================================
 */
 
SELECT musteri_isim AS "Musteri isim veya urun ismi"
FROM nisan_satislar

UNION

SELECT urun_isim
FROM mayis_satislar;


 /*  
=========================  NOT  =========================
 UNION, ile birleştirilecek sorgular mantıklı seçilmezse, 
 anlamsız tablolar oluşabilir. 
=========================================================
 */ 
   
  
/*  
========================  ORNEK  ========================
 Nisan ve mayis aylarinda satilan urun isimlerini listeleyin.
=========================================================
 */
 
SELECT urun_isim
FROM nisan_satislar

UNION

SELECT urun_isim
FROM mayis_satislar;





 
 /*  
=========================  NOT  =========================
 UNION, ile birleştirilen sorgulardaki tekrar eden değerleri getirmez, 
 tüm değerler unique olarak gelir. 
 Eğer tekrar eden tüm kayıtlar istenirse  UNION ALL kullanılmalıdır.
=========================================================
 */    
  
/*  
========================  ORNEK  ========================
 Nisan ve mayis aylarinda satilan urun isimlerini tekrarlari ile birlikte listeleyin.
=========================================================
 */
 

SELECT urun_isim
FROM nisan_satislar

UNION ALL

SELECT urun_isim
FROM mayis_satislar;

/*  
========================  ORNEK  ========================
 Nisan ayindaki müşterileri ve aldiklari urun_isim'lerini 
 ve mayis ayinda satilan urunlerin urun_id'lerini listeleyin.
=========================================================
 */
 

SELECT musteri_isim, urun_isim
FROM nisan_satislar

UNION ALL

SELECT urun_id
FROM mayis_satislar;


-- Error Code: 1222. The used SELECT statements have a different number of columns


 
 /*  
=========================  NOT  =========================
UNION, ile birleştirilen sorgulardan gelen sutun sayilari esit olmalidir.
=========================================================
 */     
   
  
/*  
========================  ORNEK  ========================
 Nisan ve mayis ayinda Honda alan müşteri isimlerini sirali olarak listeleyin.
=========================================================
 */
 







 
 /*  
=========================  NOT  =========================
 UNION, ile birleştirilen sorgular sirali olarak görmek istenirse 
 en sonda ORDER BY kullanılabilir.
=========================================================
 */   
   
  
/*  
========================  ORNEK  ========================
 Ogrenci, ogretmen ve people tablolarinda var olan isimleri 
 tekrarsiz ve sirali olarak listeleyin.
=========================================================
 */
 

SELECT isim AS 'Tum tablolardaki benzersiz isimler'
FROM ogrenci

UNION 

SELECT isim 
FROM ogretmenler

UNION 


SELECT isim 
FROM people

ORDER BY 'Tum tablolardaki benzersiz isimler'; 



/*
============================== JOIN ISLEMLERI ===============================
 JOIN, iki veya daha fazla tabloyu ortak sütunlar üzerinden birleştirerek, 
 ilişkili verileri tek bir tablo olarak gösterir.

 UNION, birden fazla SELECT sorgusunun sonuçlarını alt alta ekleyerek birleştirir; 
 ancak satır bazında çalışır, ilişkili olmayan tablolarda da çalışır.

 JOIN ise birden fazla ilişkili tablolardaki sütunları birleştirir, 
 böylece sorgu sonucunda bir tabloda birden fazla tablodaki bilgiler bir arada gösterilebilir.

 Diğer bir ifade ile 
 Join ilişkili farklı tablolardaki seçilen sütunlar ile 
 yeni bir tablo olusturmak için kullanılabilir.
   
=============================================================================
*/


   
  
/*  
========================  ORNEK  ========================
 İçerisinde sirket_adi, ulke, ve calisan_sayisi olan 
 sirket_personel_sayisi tabloyu oluşturun ve kayitlar ekleyin.
=========================================================
 */
 
 CREATE TABLE sirket_personel_sayisi (
    sirket_adi VARCHAR(100),
    ulke VARCHAR(50),
    calisan_sayisi INT
);

INSERT INTO sirket_personel_sayisi  VALUES
('TechNova', 'Türkiye', 120),
('GreenEnergy Inc.', 'Almanya', 250),
('FutureLogix', 'ABD', 400),
('SkyMedia', 'Türkiye', 95),
('NextGenSoft', 'Almanya', 180); 

SELECT *
FROM sirket_personel_sayisi ; 



   
  
/*  
========================  ORNEK  ========================
 İçerisinde sirket_adi, ulke ve kazanc sutunlari olan 
 sirket_kazanc tablosunu oluşturun ve kayitlar ekleyin.
=========================================================
 */
 
 CREATE TABLE sirket_kazanc (
    sirket_adi VARCHAR(100),
    ulke VARCHAR(50),
    kazanc DECIMAL(12,2)
);

-- sirket_kazanc tablosuna null icermeyen kayitlar girin
INSERT INTO sirket_kazanc  VALUES
('TechNova', 'Türkiye', 1500000.00),       
('GreenEnergy Inc.', 'Almanya', 2750000.50), 
('SkyMedia', 'Türkiye', 900000.75),        
('FutureLogix', 'ABD', 5200000.00),        
('OceanicWare', 'İtalya', 1300000.25),     
('LogiTrack', 'Almanya', 2100000.00),      
('Innovatex', 'ABD', 3100000.40);          


SELECT *
FROM sirket_kazanc ;


/*
============================== JOIN ISLEMLERI ===============================

 Olusturdugumuz 2 tabloda da 
 şirket isimleri var ama şirketlerin çalışan sayısı bir tabloda, 
 kazançları ise diğer tabloda. 
 Şirket isimleri, çalışan sayısı ve kazançları tek bir tabloda gösterilmek istenirse, 
 bu tablolar JOIN ile birleştirilebilir.
 
 ANCAK birleştirme yapılmadan önce bir karar verilmelidir.

 Cunku, iki tablodaki şirket isimlerinde ortak olanlar olduğu gibi 
 farklı olanlar da var.

 Birleştirme işlemi için aşağıdaki seçeneklerden biri seçilebilir.

 - İki tabloda ortak olan şirketleri ve bilgilerini getir

 - Personel sayısı tablosundaki şirketleri ve bilgilerini getir, 
   bu şirketlerin varsa kazanç bilgilerini de getir
   
 - Kazanç tablosundaki şirketleri ve bilgilerini getir, 
   bu şirketlerin varsa çalışan sayısı bilgilerini de getir
   
 - İki tablodan herhangi birinde olan tüm şirketleri 
   ve var olan bilgilerini getir.

=============================================================================
*/ 
   
   
/*
=============================== INNER JOIN  ==================================
 İki tabloda ortak olarak bulunan (kesişim kümesi) dataları 
 baz alarak yeni bir tablo olusturmak için kullanılır.

 SELECT satirinda tabloda görünmesi istenen sütunlar yazılırken 
 table_name.field_name seklinde yazılmalıdır.

 FROM satirinda table_name yazilirken iki tabloyu da belirtmek icin
   1.table_name  INNER JOIN  2.table_name 
 yazilmalidir.

 İki tablodaki veriler hangi sutundaki data uzerinden eslestirilecek ise 
 ON satirinda yazılmalıdır.

 
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 INNER JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
    
================================================================================
*/
   
  
/*  
========================  ORNEK  ========================
 İki tabloda ortak olan şirketlerin 
 isim, çalışan sayısı ve kazanç bilgilerini tek bir tabloda gösterin.
=========================================================
 */
 

SELECT sirket_personel_sayisi.sirket_adi, sirket_personel_sayisi.calisan_sayisi, sirket_kazanc.kazanc
FROM sirket_personel_sayisi INNER JOIN sirket_kazanc
ON sirket_personel_sayisi.sirket_adi = sirket_kazanc.sirket_adi;





 
 /*  
=========================  NOT  =========================
 eğer tablo isimleri sorguda kısaltılmak istenirse
 1.table_name ve kısaltması  INNER JOIN  2.table_name ve kısaltması
 seklinde yazılabilir.
=========================================================
 */  
  


SELECT p.sirket_adi, p.calisan_sayisi, k.kazanc
FROM sirket_personel_sayisi p INNER JOIN sirket_kazanc k
ON p.sirket_adi = k.sirket_adi;


SELECT pers_table.sirket_adi, pers_table.calisan_sayisi, kazanc_table.kazanc
FROM sirket_personel_sayisi pers_table INNER JOIN sirket_kazanc kazanc_table
ON pers_table.sirket_adi = kazanc_table.sirket_adi;



/*
================================= LEFT JOIN  ===================================
 LEFT JOIN, 1. tablodan (sol tablo) SELECT ile seçilen sütunlardaki 
 tüm kayıtları getirir. 

 Ancak, diğer tablodan (sağ tablo) sadece ON ile belirtilen koşula uyan kayıtları getirir. 

 Yani sola yazılan tablodaki tüm kayıtlar 
 ve sağdaki tabloda varsa bu kayıtlara ek datalar ortak bir tabloda gösterilir, 
 sağ tabloda o kayda ait ek data yoksa o kısımlar bos kalır.

 İlk yazılan tablodaki kayıtların tamamını aldığı için 
 hangi tablodaki kayıtlar baz alınmak isteniyorsa 
 o tablo sola yazılmalı ve mümkün olduğunca sütunlar o tablodan alınmalıdır.
 
     Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 LEFT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
   
================================================================================
*/

  
/*  
========================  ORNEK  ========================
 Personel sayısı tablosundaki şirketlerin 
 isim ve çalışan sayısı bilgilerini getirin, 
 bu şirketlerin varsa kazanç bilgilerini de ayni tabloda gösterin.
=========================================================
 */
 
SELECT pers_table.sirket_adi, pers_table.calisan_sayisi, kazanc_table.kazanc
FROM sirket_personel_sayisi pers_table LEFT JOIN sirket_kazanc kazanc_table
ON pers_table.sirket_adi = kazanc_table.sirket_adi;






 

/*
=============================== RIGHT JOIN  ==================================
 RIGHT JOIN 2. tablodan (sağ tablo) SELECT ile seçilen sütunlardaki tüm kayıtları getirir. 

 İlk tablodan ise (sol tablo) sadece ON ile belirtilen koşula uyan kayıtları getirir. 

 Yani sağa yazılan tablodaki tüm kayıtlar 
 ve soldaki tabloda varsa bu kayıtlara ek datalar ortak bir tabloda gösterilir, 
 sol tabloda o kayda ait ek data yoksa o kısımlar bos kalır.
   
 LEFT JOIN ve RIGHT JOIN ikisi de ayni isi yapar, 
 farkları FROM satırındaki yazılış sıralamasıdır.  

 Biri ile yapılan işlem FROM satırındaki tablo yazılış sırası değiştirilerek 
 diğeri ile de yapılabilir.
   
        
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 RIGHT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
    
==============================================================================
*/  
   
  
/*  
========================  ORNEK  ========================
 Kazanç tablosundaki şirketlerin 
 isim ve kazanç bilgilerini getirin, 
 bu şirketlerin varsa çalışan sayısı bilgilerini de ayni tabloda gösterin.
=========================================================
 */
 

SELECT kazanc_table.sirket_adi, kazanc_table.kazanc, pers_table.calisan_sayisi
FROM sirket_personel_sayisi pers_table RIGHT JOIN sirket_kazanc kazanc_table
ON pers_table.sirket_adi = kazanc_table.sirket_adi;






 


/*
=============================== FULL JOIN  ==================================
    
 MySQL’de direkt olarak FULL JOIN işlevi yoktur. 
 LEFT JOIN ve RIGHT JOIN’in UNION kullanarak birleştirilmesi ile elde edilir.

 İlk tablodan var olan kayıtları getirir. 

 Her iki tabloda bulunan sirket_adi gibi sütunlar 
 sorguda mutlaka tablo_adi.sutun_adi olarak belirtilmelidir. 
 Tek tabloda olan sütunlar için bu mecburiyet yoktur.

 İki tabloda herhangi bir yerde olan datalar yeni ortak tabloya islenir, 
 data olmayan hücreler NULL değeri alır.

    
        
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    LEFT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
    UNION
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    RIGHT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;    

==============================================================================
*/   
  
/*  
========================  ORNEK  ========================
 Kazanç tablosundaki şirketlerin 
 isim ve kazanç bilgilerini getirin, 
 bu şirketlerin varsa çalışan sayısı bilgilerini de ayni tabloda gösterin.
=========================================================
 */
 
SELECT kazanc_table.sirket_adi, kazanc_table.kazanc, pers_table.calisan_sayisi
FROM sirket_personel_sayisi pers_table RIGHT JOIN sirket_kazanc kazanc_table
ON pers_table.sirket_adi = kazanc_table.sirket_adi;


/*  
========================  ORNEK  ========================
 Personel sayısı tablosundaki şirketlerin 
 isim ve çalışan sayısı bilgilerini getirin, 
 bu şirketlerin varsa kazanç bilgilerini de ayni tabloda gösterin.
=========================================================
 */
 
SELECT pers_table.sirket_adi, pers_table.calisan_sayisi, kazanc_table.kazanc
FROM sirket_personel_sayisi pers_table LEFT JOIN sirket_kazanc kazanc_table
ON pers_table.sirket_adi = kazanc_table.sirket_adi;



-- her iki tabloyu inceleyip
-- iki tablodan herhangi birinde var olan sirketlerin
-- isim, calisan sayisi ve kazanclarini tek tablo olarak goruntuleyin


SELECT kazanc_table.sirket_adi, kazanc_table.kazanc, pers_table.calisan_sayisi
FROM sirket_personel_sayisi pers_table RIGHT JOIN sirket_kazanc kazanc_table
ON pers_table.sirket_adi = kazanc_table.sirket_adi

UNION

SELECT pers_table.sirket_adi, kazanc_table.kazanc, pers_table.calisan_sayisi
FROM sirket_personel_sayisi pers_table LEFT JOIN sirket_kazanc kazanc_table
ON pers_table.sirket_adi = kazanc_table.sirket_adi;
 
 
   
  
/*  
========================  ORNEK  ========================
 Icerisinde bolum_id, bolum_isim ve konum field'lari olan 
 bolümler tablosu oluşturun. 
 Bolum_id field’i Primary Key olsun ve içine null olmayan değerler ekleyin.
=========================================================
 */
 
CREATE TABLE bolumler (
      bolum_id   INT PRIMARY KEY,
      bolum_isim VARCHAR(14),
      konum      VARCHAR(13)
    );
 
 
INSERT INTO bolumler VALUES (10,'MUHASEBE','IST');
INSERT INTO bolumler VALUES (20,'MUDURLUK','ANKARA');
INSERT INTO bolumler VALUES (30,'SATIS','IZMIR');
INSERT INTO bolumler VALUES (40,'ISLETME','BURSA');
INSERT INTO bolumler VALUES (50,'DEPO', 'YOZGAT');
INSERT INTO bolumler VALUES (60,'SATIS', 'CORUM'); 


SELECT *
FROM bolumler;

  
/*  
========================  ORNEK  ========================
 Icerisinde personel_id, personel_isim, meslek, mudur_id, maas ve bolum_id field'lari olan 
 personeller tablosu oluşturun.  
 Bolum_id field’i Foreign Key olsun 
 ve tabloya kayitlar ekleyin.
=========================================================
 */
 
 CREATE TABLE personeller (
      personel_id   INT ,
      personel_isim VARCHAR(10),
      meslek        VARCHAR(9),
      mudur_id      INT,
      maas          INT,
      bolum_id      INT,
      CONSTRAINT bolumID_fk FOREIGN KEY(bolum_id)
      REFERENCES bolumler(bolum_id)
    );
    
    
    INSERT INTO personeller VALUES (7369,'AHMET','KATIP',1111,800,20);
    INSERT INTO personeller VALUES (7499,'BAHATTIN','SATIS',1222,1600,30);
    INSERT INTO personeller VALUES (7521,'NESE','SATISE',1222,1250,30);
    INSERT INTO personeller VALUES (1111,'MUZAFFER','MUDUR',7839,2975,20);
    INSERT INTO personeller VALUES (7654,'MUHAMMET','SATIS',1222,1250,30);
    INSERT INTO personeller VALUES (1222,'EMINE','MUDUR',7839,2850,30);
    INSERT INTO personeller VALUES (1333,'HARUN','MUDUR',7839, 2450,10);
    INSERT INTO personeller VALUES (7788,'MESUT','ANALIST',1111,3000,20);
    INSERT INTO personeller VALUES (7839,'SEHER','BASKAN',NULL,5000,10);
    INSERT INTO personeller VALUES (7844,'DUYGU','SATIS',1222,1500,30);
    INSERT INTO personeller VALUES (7876,'ALI','KATIP',1111,1100,20);
    INSERT INTO personeller VALUES (7900,'MERVE','KATIP',1222,950,30);
    INSERT INTO personeller VALUES (7902,'NAZLI','ANALIST',1111,3000,20);
    INSERT INTO personeller VALUES (7934,'EBRU','KATIP',1333,1300,10);
    INSERT INTO personeller VALUES (7956,'SIBEL','MIMAR',1333,3300,60);
    INSERT INTO personeller VALUES (7933,'ZEKI','MUHENDIS',1333,4300,60);
    
    
    SELECT * 
    FROM personeller; 

  
  
/*  
========================  ORNEK  ========================
 SATIS ve MUHASEBE bölümlerinde çalışanların 
 isimlerini ve bölümlerini, önce bolum sonra isim sıralı olarak listeleyin. 
=========================================================
 */
 

-- esas alacagimiz tablo bolumler

SELECT b.bolum_isim, p.personel_isim
FROM bolumler b LEFT JOIN personeller p 
ON b.bolum_id = p.bolum_id
WHERE b.bolum_isim = 'muhasebe' OR b.bolum_isim = 'satis' ;
  
/*  
========================  ORNEK  ========================
 SATIS, ISLETME ve DEPO bölümlerinde çalışanların isimlerini ve bölümlerini 
 isim sıralı olarak listeleyiniz
  	
 NOT: Çalışanı olmasa bile bolum ismi listelenmelidir.
=========================================================
 */
 
SELECT personeller.personel_isim, bolumler.bolum_isim
FROM bolumler LEFT JOIN personeller
ON bolumler.bolum_id = personeller.bolum_id
WHERE bolumler.bolum_isim IN ('SATIS', 'ISLETME', 'DEPO')
ORDER BY personeller.personel_isim;


   
  
/*  
========================  ORNEK  ========================
 Çalışan tüm personelin isimlerini bolum isimlerini ve maaşlarını 
 bolum ters sıralı ve maaş sıralı listeleyin.
 NOT: Bolum ismi olmasa bile çalışanın ismi listelenmelidir.
=========================================================
 */
 






 
   
  
/*  
========================  ORNEK  ========================
 SATIS ve MUDURLUK bölümlerinde çalışan personelden 
 maaşları 2000 den büyük olanların isimlerini, bolum isimlerini ve maaşlarını 
 bolüme ve isme göre sıralayarak listeleyin. 
=========================================================
 */
 





 