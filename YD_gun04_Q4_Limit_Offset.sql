use Team161;
/*
===============================================
		      LIMIT - OFFSET
===============================================

 LIMIT, bir sorgu sonucundan listelenecek maksimum satır sayısını belirler.

 Bir sorgu sonucunda çok sayıda satır bulunmasina karsilik 
 sonuçlardan belirlenen MAX deger kadarinin listelenmesi için kullanilir.
 
 Bulunan sonuç sayisi MAX değerden az ise tum sonuçlar listelenir.



*************** SYNTAX ***************
SELECT * FROM tablo_adi
LIMIT 10;            

Varsa sonuc kumesindeki ilk 10 satiri gosterir. 


 OFFSET, Sorgu sonucu setinde bir başlangıç noktası belirler.
 
 Bir sorgu sonucunda bulunan kayitlarin ilkinden değil de 
 belirlenmiş siradaki bir kayittan baslanmasi istendiğinde kullanilir.



*************** SYNTAX ***************
SELECT * FROM tablo_adi
LIMIT 10 OFFSET 20;  

20.kayittan baslar ve 10 kayit gosterir
diger bir ifade ile bulunan kayitlardan
20. ile 30. arasindaki kayitlari listeler.
*/


 /*  
========================  ORNEK  ========================
 Kitaplik tablosundaki en yeni 3 Kitabı listeleyin.
=========================================================
 */

SELECT kitap_adi, yayin_yili
FROM kitaplik
ORDER BY yayin_yili DESC
LIMIT 3;




/*
===============================================
		      RAND() Fonksiyonu
===============================================

 0 ile 1 arasında rastgele bir ondalık sayı üretir.
 
 RAND() fonksiyonu, özellikle bir tablodan rastgele kayıtlar seçmek için kullanılır.

 ORDER BY RAND( ) ifadesi, tablonun satırlarını rastgele bir sırayla sıralar. 

 ORDER BY RAND( ), özellikle küçük ve orta ölçekli tablolar için uygundur. 
 Ancak, büyük veri setleri için performans sorunlarına yol açabilir. 

 */
 
 
 /*  
========================  ORNEK  ========================
 Kitaplik tablosundan rastgele 3 kitap secip listeleyiniz.
=========================================================
 */
 
SELECT kitap_adi, yayin_yili
FROM kitaplik
ORDER BY RAND()
LIMIT 3 ;


 
--  SELECT RAND() 0-1 arasinda bir sayi dondurur

SELECT RAND();




 /*  
========================  ORNEK  ========================
 Kitaplik tablosundaki en eski iki kitabi listeleyin
=========================================================
 */

SELECT *
FROM kitaplik
ORDER BY yayin_yili
LIMIT 2;



-- yazari 'Fyodor Dostoyevski' olan en eski 5 kitabi listeyin


SELECT *
FROM kitaplik
WHERE yazar = 'Fyodor Dostoyevski'
ORDER BY yayin_yili
LIMIT 5;


 /*  
========================  ORNEK  ========================
 Kitaplik tablosundan yazari 'Fyodor Dostoyevski' olan kitapları 
 en fazla 2 tane olacak sekilde listeleyin
=========================================================
 */
 




 

 /*  
========================  ORNEK  ========================
 Kitaplik tablosundan yazari 'Fyodor Dostoyevski' olan kitapları 
 en fazla 2 tane olacak sekilde 
 eskiden yeniye dogru sirali olarak listeleyin.
=========================================================
 */




 /*  
========================  ORNEK  ========================
 Kitaplik tablosundaki yayın yılına göre sıralanmış kitapların 
 3. sayfasını listeleyin.
 NOT : Her sayfanin boyutu 3 kitap ile sinirlidir. 
 (yani bizden 7., 8. ve 9. kitaplar isteniyor).
=========================================================
 */

SELECT *
FROM kitaplik
ORDER BY yayin_yili
LIMIT 3 
OFFSET 6 ;




 /*  
========================  ORNEK  ========================
 Kitaplik tablosundaki yayın yılına göre sıralanmış kitapların 
 4. sayfasını listeleyin.
 NOT : Her sayfanin boyutu 2 kitap ile sinirlidir. 
       (yani bizden 7. ve 8.  kitaplar isteniyor).
=========================================================
 */


SELECT *
FROM kitaplik
ORDER BY yayin_yili
LIMIT 2 
OFFSET 6 ;






 /*  
========================  ORNEK  ========================
 Kitaplik tablosundaki yayin yili 1950'den once olan kitaplarin 
 1. sayfasını listeleyiniz.
 NOT : Her sayfanin boyutu 4 kitap ile sinirlidir.
=========================================================
 */








 /*  
========================  ORNEK  ========================
 Kitaplik tablosundaki yayin yili 1950'den once olan kitaplari 
 alfabetik siraya gore siralayip 1. sayfasını listeleyiniz.
 NOT : Her sayfanin boyutu 4 kitap ile sinirlidir.
=========================================================
 */
