<h3><img src="https://1000logos.net/wp-content/uploads/2020/08/MySQL-Logo.png"/></h3>
Mysql Komutları temel seviyede aşağıdaki gibi sayılabilir. 
Ama daha kapsamlı uygulamalar için bunların parametrelerini ve diğer komutları kullanmak gerekir.

CREATE DATABASE: Yeni bir veritabanı üretir

CREATE TABLE: Yeni bir tablo üretir

INSERT INTO: Veritabanına yeni kayıt ekler

SELECT FROM: Veritabanından bilgi okumaya yarar

WHERE: Yapılan işlemin etkileyeceği sütunları belirtir

ORDER BY: Seçim işleminde sıralama veya tersten sıralama yapar

UPDATE SET: Veritabanında değişiklik yapar

DELETE FROM: Bilgi siler

Yukarıdakiler temel SQL komutlarıdır ve neredeyse her türlü veritabanında geçerlidir. Aşağıdaki komutlar ise özel durumlarda kullanılabilir.

SHOW TABLE: Tabloların listesini verir

DESCRIBE: Tablo sütunlarının adını yazar

DROP DATABASE: Veritabanını toptan siler

DROP TABLE: Tabloyu toptan siler (Dikkat edin sadece içini boşaltmaz. tablo tarih olur, yanlış kullanmayın)

TRUNCATE TABLE: Tablodaki bilgileri siler, Tablo ayarlarını sıfırlar

ALTER DATABASE: Veri tabanının öz niteliklerini değiştirir.
ALTER TABLE: Tabloya alan ekleme, tablodaki alanı düzenleme ve silme işlemlerini yapar.
ALTER VIEW: Görünüm değiştirmede kullanılır.
CREATE DATABASE:Yeni bir veritabanı oluşturur.
CREATE INDEX:Yeni bir index oluşturur.
CREATE TABLE: Yebi bir tablo oluşturur.
DELETE: belirtilen tablodan yeri WHERE deyimi ile saptanan satırı siler.
DROP DATABASE: belirtilen veritabanını siler.
DROP INDEX:belirtilen index i siler.
DROP TABLE:belirtilen tabloyu siler.
DROP USER:belirtilen kullanıcıyı siler ama kullanıcının sahip olduğu ; tablo, database ,vsvs silinmez.
INSERT:tabloya yeni bir satır ekler.
RENAME TABLE: var olan tablonun adını değiştirir.
SELECT: veri tabanındaki tablonun tamamını yada WHERE ile belirtilen alanı gösterir.
=====================================================================
Diğer Mysql Komutları

ALTER DATABASE

ALTER TABLE

ALTER VIEW

ANALYZE TABLE

BACKUP TABLE

CACHE INDEX

CHANGE MASTER TO

CHECK TABLE

CHECKSUM TABLE

COMMIT

CREATE DATABASE

CREATE INDEX

CREATE TABLE

CREATE VIEW

DELETE

DESCRIBE

DO

DROP DATABASE

DROP INDEX

DROP TABLE

DROP USER

DROP VIEW

EXPLAIN

FLUSH

GRANT

HANDLER

PHP KODLARI.com

INSERT

JOIN

KILL

LOAD DATA FROM MASTER

LOAD DATA INFILE

LOAD INDEX INTO CACHE

LOAD TABLE...FROM MASTER

LOCK TABLES

OPTIMIZE TABLE

PURGE MASTER LOGS

RENAME TABLE

REPAIR TABLE

REPLACE

RESET

RESET MASTER

RESET SLAVE

RESTORE TABLE

REVOKE

ROLLBACK

ROLLBACK TO SAVEPOINT

SAVEPOINT

SELECT

SET

SET PASSWORD

SET SQL_LOG_BIN

SET TRANSACTION

SHOW BINLOG EVENTS

SHOW CHARACTER SET

SHOW COLLATION

SHOW COLUMNS

SHOW CREATE DATABASE

SHOW CREATE TABLE

SHOW CREATE VIEW

SHOW DATABASES

SHOW ENGINES

SHOW ERRORS

SHOW GRANTS

SHOW INDEX

SHOW INNODB STATUS

SHOW LOGS

SHOW MASTER LOGS

SHOW MASTER STATUS

SHOW PRIVILEGES

SHOW PROCESSLIST

SHOW SLAVE HOSTS

SHOW SLAVE STATUS

SHOW STATUS

SHOW TABLE STATUS

SHOW TABLES

SHOW VARIABLES

SHOW WARNINGS

START SLAVE

START TRANSACTION

STOP SLAVE

TRUNCATE TABLE

UNION

UNLOCK TABLES

USE


=====================================================================

KELİME İŞLEMLERİ


AES_DECRYPT

AES_ENCRYPT

ASCII

BIN

BINARY

BIT_LENGTH

CHAR

CHAR_LENGTH

CHARACTER_LENGTH

COMPRESS

CONCAT

CONCAT_WS

CONV

DECODE

DES_DECRYPT

DES_ENCRYPT

ELT

ENCODE

ENCRYPT

EXPORT_SET

FIELD

FIND_IN_SET

HEX

INET_ATON

INET_NTOA

INSERT

INSTR

LCASE

LEFT

LENGTH

LOAD_FILE

LOCATE

LOWER

LPAD

LTRIM

MAKE_SET

MATCH AGAINST

MD5

MID

OCT

OCTET_LENGTH

OLD_PASSWORD

ORD

PASSWORD

POSITION

QUOTE

REPEAT

REPLACE

REVERSE

RIGHT

RPAD

RTRIM

SHA

SHA1

SOUNDEX

SPACE

STRCMP

SUBSTRING

SUBSTRING_INDEX

TRIM

UCASE

UNCOMPRESS

UNCOMPRESSED_LENGTH

UNHEX

UPPER

=====================================================================

ZAMAN FONKSİYONLARI

ADDDATE

ADDTIME

CONVERT_TZ

CURDATE

CURRENT_DATE

CURRENT_TIME

CURRENT_TIMESTAMP

CURTIME

DATE

DATE_ADD

DATE_FORMAT

DATE_SUB

DATEDIFF

DAY

DAYNAME

DAYOFMONTH

DAYOFWEEK

DAYOFYEAR

EXTRACT

FROM_DAYS

FROM_UNIXTIME

GET_FORMAT

HOUR

LAST_DAY

LOCALTIME

LOCALTIMESTAMP

MAKEDATE

MAKETIME

MICROSECOND

MINUTE

MONTH

MONTHNAME

NOW

PERIOD_ADD

PERIOD_DIFF

QUARTER

SEC_TO_TIME

SECOND

STR_TO_DATE

SUBDATE

SUBTIME

SYSDATE

TIME

TIMEDIFF

TIMESTAMP

TIMESTAMPDIFF

TIMESTAMPADD

TIME_FORMAT

TIME_TO_SEC

TO_DAYS

UNIX_TIMESTAMP

UTC_DATE

UTC_TIME

UTC_TIMESTAMP

WEEK

WEEKDAY

WEEKOFYEAR

YEAR

YEARWEEK



MATEMATİK İŞLEMLERİ

ABS

ACOS

ASIN

ATAN

ATAN2

AVG

BIT_AND

BIT_OR

BIT_XOR

CEIL

CEILING

COS

COT

COUNT

CRC32

DEGREES

EXP

FLOOR

FORMAT

GREATEST

GROUP_CONCAT

LEAST

LN

LOG

LOG2

LOG10

MAX

MIN

MOD

PI

POW

POWER

RADIANS

RAND

ROUND

SIGN

SIN

SQRT

STD

STDDEV

SUM

TAN

TRUNCATE

VARIANCE

