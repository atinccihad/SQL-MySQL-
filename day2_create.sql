/* ========================================================= 
                        TABLO OLUSTURMA  (CRUD - Create)                  
============================================================*/
drop table student;
use sys;
CREATE TABLE student
 (
   id VARCHAR(4),
    name VARCHAR(20),
    age int
);
/* ========================================================= 
                     VERİ GİRİSİ 
===========================================================*/

INSERT INTO student VALUES( '1001','MEHMET ALİ', 25);
INSERT INTO student VALUES('1002', 'AYSE YILMAZ', 34);
INSERT INTO student VALUES('1003', 'JOHN STAR', 56);
INSERT INTO student VALUES('1004', 'MARY BROWN', 17);

select * from student;