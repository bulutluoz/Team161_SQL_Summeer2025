use Team161;
/*
======================== Primary Key ======================= 
Primary Key : (Birincil anahtar), 
bir tabloda her satırı benzersiz şekilde tanımlayan 
ve boş (NULL) değer içeremeyen sütun ya da sütunlar bütünüdür.

Primary Key olarak kullanılacak sutundaki veriler tekrarsiz (UNIQUE) olmalidir. 
Eğer birden fazla satır aynı primary key değerine sahip olursa, 
veri tabanı o satırları birbirinden ayırt edemez. 

Çoğunlukla tek bir alan ( id, user_id, e_mail, username, tc_no vb.) olarak kullanılsa da, 
tek bir sutunun unique değerler saglamadigi durumlarda 
birden fazla sutunun birleşimiyle de oluşturulabilir

İlişkili veri tabanlarında ( relational database ) mutlaka Primary Key olmalıdır.

Bir tabloda yalnızca bir tane Primary Key OLABILIR.
Her tabloda Primary Key olması zorunlu değildir.

Primary Key benzersiz ( Unique ) olmalıdır 
ama her Unique data  Primary Key değildir.

Primary Key her türlü datayı içerebilir. Sayı, String, ...

Primary Key, dış dünyadaki gerçek verileri temsil ediyorsa, 
örneğin; TC  kimlik numarası, bir kitabın ISBN numarası, bir ürünün ismi, email hesabı  gibi 
buna Natural Key,
veriyle doğrudan ilgisi olmayan yapay (üretilmiş) sira no, ogrenci no gibi bir değer ise 
Surrogate Key denir.

Syntax 1 :
	Data Type'dan sonra "PRIMARY KEY" yazarak

	CREATE TABLE students_table
	(
		id INT PRIMARY KEY,
		name VARCHAR(50) UNIQUE,
		grade INT NOT NULL,
		adres VARCHAR(100),
		last_update DATE
	); 

Syntax 2 :
	CONSTRAINT Keyword'u kullanilarak PRIMARY KEY tanimlanabilir.
	"CONSTRAINT constraintName PRIMARY KEY(column1, column2, ... column_n);"

	CREATE TABLE students_table
	(
		id INT ,
		name VARCHAR(50),
		grade INT,
		adres VARCHAR(100),
		last_update DATE
		CONSTARINT id_pk PRIMARY KEY (id)
        
        
===============================================================
*/

 /*  
========================  ORNEK  ========================
"sehirler" isimli bir tablo olusturun.
Tabloda "alan_kodu", "isim", "nufus" fieldlari olsun.
"isim" field'i bos birakilamasin.
1. yolu kullanarak "alan_kodu" field'ini primary key yapin
=========================================================
 */
 

CREATE TABLE sehirler (
		alan_kodu CHAR(4) PRIMARY KEY,
		isim VARCHAR(50) NOT NULL,
		nufus BIGINT
	);

-- primary key hem unique hem de not null OLMAK ZORUNDADIR
-- ammmmaaa bunlari yazmamiza gerek yok
-- cunku primary key yazdigimizda, database otomatik olarak bu sutunu not null ve unique olarak tanimlar




 /*  
====================  Composite Key  ====================
Bir tabloda Primary Key yapilacak bir sutun bulunamadiginda, 
birden fazla sütunun birleştirilerek benzersiz (unique) kayıtları tanımladığı 
birincil anahtardır.
=========================================================
 */
 
 


 /*  
========================  ORNEK  ========================
"ogretmenler" isimli bir table olusturun.
Tabloda "id", "isim", "brans", "cinsiyet" fieldlari olsun.
"id" field'i tekrarli veri kabul etmesin.
2. yolu kullanarak "id" ve "isim" field'larini primary key yapin
=========================================================
 */

CREATE TABLE ogretmenler (
id INT UNIQUE,
isim VARCHAR(50), 
brans VARCHAR(50), 
cinsiyet CHAR(5),
CONSTRAINT id_isim_pk PRIMARY KEY (id,isim)
);



 /*  
========================  ORNEK  ========================
"universite_ogrenci_bilgi_sistemi" isimli bir table olusturun.
Tabloda "giris_yili", "giris_siralamasi", "isim", "bolum" field'lari olsun.
"isim" field'i NULL deger kabul etmesin.
2. yolu kullanarak "giris_yili", "bolum", ve "giris_siralamasi" field'larini primary key yapin
=========================================================
 */

CREATE TABLE universite_ogrenci_bilgi_sistemi (
    giris_yili YEAR,
    giris_siralamasi INT,
    isim VARCHAR(100) NOT NULL,
    bolum VARCHAR(100),
    CONSTRAINT pk_girisyili_girissiralamasi PRIMARY KEY (giris_yili, bolum, giris_siralamasi)
);

SELECT * 
FROM universite_ogrenci_bilgi_sistemi;




/*
============================ Foreign Key ============================
 Foreign Key iki tablo arasında relation oluşturmak için kullanılır.

 Foreign Key başka bir tablodaki Primary Key ile ilişkilendirilmiş  olmalıdır.

 Foreign Key, değerleri farklı bir tablodaki Primary Key ile eşleşen bir sütun veya sütunların birleşimidir. 

 Bir Tabloda birden fazla Foreign Key olabilir

 Foreign Key olarak tanimlanan field’da tekrarlar olabilir

 Forein Key NULL degeri Kabul eder
 
 Syntax : 
	CONSTRAINT constraintName FOREIGN KEY(child_table_field_name)
	REFERENCES parent_table (parent_table_field_name)

	CREATE TABLE table_name
	(
		id CHAR(10),
		name CHAR(10),
		CONSTRAINT constraint_name
		FOREIGN KEY(id)
		REFERENCES parent_table (parent_table_field_name)
	);


=====================================================================
*/

 /*  
========================  ORNEK  ========================
 "tedarikci" isimli bir tablo olusturun.
 Tabloda "tedarikci_id", "tedarikci_ismi", "iletisim_isim" fieldlari olsun.
 "tedarikci_id" field'ini PRIMARY KEY olsun.
	
 "urunler" isminde baska bir tablo olusturun. 
 Tabloda "tedarikci_id" ve "urun_id" field'lari olsun.
 "tedarikci_id" FOREIGN KEY olsun.
=========================================================
 */
 
 CREATE TABLE tedarikci(
	tedarikci_id CHAR(6) PRIMARY KEY,
    tedarikci_ismi VARCHAR(40), 
    iletisim_isim VARCHAR(40)
);


CREATE TABLE urunler (
		tedarikci_id CHAR(6) PRIMARY KEY  ,
		urun_id INT,
		FOREIGN KEY (tedarikci_id) REFERENCES tedarikci(tedarikci_id)
);

INSERT urunler VALUES ('123456','123456789');

-- 20:39:37	INSERT urunler VALUES ('123456','123456789')	
-- Error Code: 1452. 
-- Cannot add or update a child row: a foreign key constraint fails (`team161`.`urunler`, CONSTRAINT `urunler_ibfk_1` FOREIGN KEY (`tedarikci_id`) REFERENCES `tedarikci` (`tedarikci_id`))	0.015 sec



 /*  
========================  NOTLAR  =======================
 Bir field’i Foreign Key yapmak icin 
 mutlaka başka bir tablodaki Primary Key ile ilişiklendirilmelidir.
 
 Referenced table (bağlanılan tablo, Primary Key’in olduğu tablo) 
 Parent Table olarak da adlandırılır. 
 Foreign Key’in olduğu tablo ise Child Table olarak da adlandırılır.

 Bir tabloda FOREIGN KEY oluşturmanın bazı doğal sonuçları vardır.
 
 1- Foreign Key Pimary Key'de var olmayan bir degeri kendi icerisinde bulunduramaz.
 
 2- Parent table oluşturulmadan Child Tablo olusturmak istenirse hata alınır.
 
 3- Parent Table’da olmayan bir veriyi(PK'daki herhangi bir deger) Child Table’a giremezsiniz.
 
 4- Child Table’ı silmeden Parent Table’ı silemezsiniz. 
    Önce Child  Table silinir, sonra Parent Table silinir.
=========================================================
 */



 /*  
========================  ORNEK  ========================
  once tedarikci tablosuna kayit ekleyip, 
  sonra da urunler tablosuna kayit eklemeyi deneyin
=========================================================
 */



INSERT tedarikci VALUES ('123456','Murat Otomotive','Murat Yilmaz');
INSERT urunler VALUES ('123456','123456789');


-- OLUSTURURKEN veya EKLERKEN once parent, sonra child
-- SILERKEN once child, sonra parent



 /*  
============= Constraints ( Kısıtlamalar)  ==============

 tablo sütunlarına veri bütünlüğünü sağlamak için 
 uygulanan kurallar ve kısıtlamalardır.
 
 1- Primary Key : Bir tabloyu eşsiz olarak tanımlayan sütun ya da sütunlar.

 2- Foreign Key : Bir sütunun başka bir tablodaki değere bağlı olduğunu belirtir ve ilişki kurulmasını sağlar.

 3- UNIQUE : Sütundaki tüm değerlerin benzersiz olmasını sağlar.

 4- NOT NULL : Sütunun boş (NULL) olmasını engeller.

 5- CHECK : Bir sütunun alabileceği değerleri sınırlar.

 6- DEFAULT : Bir sütun için varsayılan değer belirler 
	(veri girilmediğinde otomatik atanır).

 7- AUTO_INCREMENT : Bir sütunun otomatik olarak artmasını sağlar 
    (genellikle id alanında kullanılır).

=========================================================
 */





 /*  
========================  ORNEK  ========================
 SCHEMA OLUSTURMA
 
 1- Öğrenci tablosu oluşturun. 
    Tabloda ogrenci_no, isim ve soyisim field'lari olsun
    ve ogrenci_no Primary Key olsun
=========================================================
 */









 /*  
========================  ORNEK  ========================
 2- Adresler tablosu olusturun. 
    Tabloda ogrenci_no, sehir, ilce, sokak ve ev_no field'lari olsun
    ve ogrenci_no ogrenci tablosu ile iliski kurmak icin Foreign Key olsun
=========================================================
 */









 /*  
========================  ORNEK  ========================
 3- Ogretmen tablosu olusturun. 
    Tabloda ogretmen_id, isim, soyisim  ve ders_adi field'lari olsun
    ve ogretmen_id Primary Key olsun
=========================================================
 */

-- onceki ogretmenler tablosunu silin



 /*  
========================  ORNEK  ========================
 4- Dersler tablosu olusturun. 
   Tabloda id, ogrenci_no ve ders_adi, ortalama_not ve ogretmen_id  field'lari olsun
   id Primary Key olsun
   ogrenci_no ogrenci tablosu ile iliski kurmak icin Foreign Key olsun
   ogretmen_id ogretmen tablosu ile iliski kurmak icin Foreign Key olsun

=========================================================
 */
 









 /*  
========================  ORNEK  ========================
 schema'daki tablolara kayit ekleyin
=========================================================
 */

-- ogrenci tablosuna NULL icermeyen kayitlar ekleyin