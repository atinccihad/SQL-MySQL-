Chapter 2: Data Types
PostgreSQL has a rich set of native data types available to users. Users can add new types to PostgreSQL using the
CREATE TYPE command.
https://www.postgresql.org/docs/9.6/static/datatype.html
Section 2.1: Numeric Types
Name Storage Size Description Range
SMALLINT 2 bytes small-range integer -32768 to +32767
INTEGER 4 bytes ypical choice for integer -2147483648 to +2147483647
BIGINT 8 bytes large-range integer -9223372036854775808 to
+9223372036854775807
DECIMAL variable user-specified precision, exact up to 131072 digits before the decimal point; up
to 16383 digits after the decimal point
NUMERIC variable user-specified precision, exact up to 131072 digits before the decimal point; up
to 16383 digits after the decimal point
REAL 4 bytes variable-precision, inexact 6 decimal digits precision
DOUBLE PRECISION 8 bytes variable-precision, inexact 15 decimal digits precision
smallserial 2 bytes small autoincrementing integer 1 to 32767
serial 4 bytes autoincrementing integer 1 to 2147483647
BIGSERIAL 8 bytes large autoincrementing integer 1 to 9223372036854775807
int4range Range of integer
int8range Range of bigint
numrange Range of numeric
Section 2.2: Date/ Time Types
Name Storage
Size Description Low Value High Value Resolution
TIMESTAMP
(without time
zone)
8 bytes both date and time (no
time zone) 4713 BC 294276 AD 1 microsecond / 14
digits
TIMESTAMP (with
time zone) 8 bytes both date and time, with
time zone 4713 BC 294276 AD 1 microsecond / 14
digits
DATE 4 bytes date (no time of day) 4713 BC 5874897 AD 1 day
TIME (without time
zone) 8 bytes time of day (no date) 00:00:00 24:00:00 1 microsecond / 14
digits
TIME (with time
zone) 12 bytes times of day only, with
time zone 00:00:00+1459 24:00:00-1459 1 microsecond / 14
digits
INTERVAL 16 bytes time interval -178000000 years 178000000 years 1 microsecond / 14
digits
tsrange range of timestamp
without time zone
tstzrange range of timestamp with
time zone
daterange range of date
GoalKicker.com – PostgreSQL® Notes for Professionals 9
Section 2.3: Geometric Types
Name Storage Size Description Representation
point 16 bytes Point on a plane (x,y)
line 32 bytes Infinite line {A,B,C}
lseg 32 bytes Finite line segment ((x1,y1),(x2,y2))
BOX 32 bytes Rectangular box ((x1,y1),(x2,y2))
path 16+16n bytes Closed path (similar to polygon) ((x1,y1),...)
path 16+16n bytes Open path [(x1,y1),...]
polygon 40+16n bytes Polygon (similar to closed path) ((x1,y1),...)
CIRCLE 24 bytes Circle <(x,y),r> (center point and radius)
Section 2.4: Network Adress Types
Name Storage Size Description
CIDR 7 or 19 bytes IPv4 and IPv6 networks
INET 7 or 19 bytes IPv4 and IPv6 hosts and networks
macaddr 6 bytes MAC addresses
Section 2.5: Character Types
Name Description
CHARACTER varying(n), varchar(n) variable-length with limit
character(n), char(n) fixed-length, blank padded
TEXT variable unlimited length
Section 2.6: Arrays
In PostgreSQL you can create Arrays of any built-in, user-defined or enum type. In default there is no limit to an
Array, but you can specify it.
Declaring an Array
SELECT INTEGER[];
SELECT INTEGER[3];
SELECT INTEGER[][];
SELECT INTEGER[3][3];
SELECT INTEGER ARRAY;
SELECT INTEGER ARRAY[3];
Creating an Array
SELECT '{0,1,2}';
SELECT '{{0,1},{1,2}}';
SELECT ARRAY[0,1,2];
SELECT ARRAY[ARRAY[0,1],ARRAY[1,2]];
Accessing an Array
By default PostgreSQL uses a one-based numbering convention for arrays, that is, an array of n elements starts
with ARRAY[1] and ends with ARRAY[n].
--accesing a spefific element
GoalKicker.com – PostgreSQL® Notes for Professionals 10
WITH arr AS (SELECT ARRAY[0,1,2] int_arr) SELECT int_arr[1] FROM arr;
int_arr
---------
0
(1 ROW)
--sclicing an array
WITH arr AS (SELECT ARRAY[0,1,2] int_arr) SELECT int_arr[1:2] FROM arr;
int_arr
---------
{0,1}
(1 ROW)
Getting information about an array
--array dimensions (as text)
WITH arr AS (SELECT ARRAY[0,1,2] int_arr) SELECT ARRAY_DIMS(int_arr) FROM arr;
array_dims
------------
[1:3]
(1 ROW)
--length of an array dimension
WITH arr AS (SELECT ARRAY[0,1,2] int_arr) SELECT ARRAY_LENGTH(int_arr,1) FROM arr;
array_length
--------------
3
(1 ROW)
--total number of elements across all dimensions
WITH arr AS (SELECT ARRAY[0,1,2] int_arr) SELECT cardinality(int_arr) FROM arr;
cardinality
-------------
3
(1 ROW)
Array functions
will be added
GoalKicker.com – PostgreSQL® Notes for Professionals 11
Chapter 3: Dates, Timestamps, and
Intervals
Section 3.1: SELECT the last day of month
You can select the last day of month.
SELECT (DATE_TRUNC('MONTH', ('201608'||'01')::DATE) + INTERVAL '1 MONTH - 1 day')::DATE;
201608 is replaceable with a variable.
Section 3.2: Cast a timestamp or interval to a string
You can convert a TIMESTAMP or INTERVAL value to a string with the TO_CHAR() function:
SELECT TO_CHAR('2016-08-12 16:40:32'::TIMESTAMP, 'DD Mon YYYY HH:MI:SSPM');
This statement will produce the string "12 Aug 2016 04:40:32PM". The formatting string can be modified in many
different ways; the full list of template patterns can be found here.
Note that you can also insert plain text into the formatting string and you can use the template patterns in any
order:
SELECT TO_CHAR('2016-08-12 16:40:32'::TIMESTAMP,
'"Today is "FMDay", the "DDth" day of the month of "FMMonth" of "YYYY');
This will produce the string "Today is Saturday, the 12th day of the month of August of 2016". You should keep in
mind, though, that any template patterns - even the single letter ones like "I", "D", "W" - are converted, unless the
plain text is in double quotes. As a safety measure, you should put all plain text in double quotes, as done above.
You can localize the string to your language of choice (day and month names) by using the TM (translation mode)
modifier. This option uses the localization setting of the server running PostgreSQL or the client connecting to it.
SELECT TO_CHAR('2016-08-12 16:40:32'::TIMESTAMP, 'TMDay, DD" de "TMMonth" del año "YYYY');
With a Spanish locale setting this produces "Sábado, 12 de Agosto del año 2016".
Section 3.3: Count the number of records per week
SELECT DATE_TRUNC('week', <>) AS "Week" , COUNT(*)
FROM <>
GROUP BY 1
ORDER BY 1;
GoalKicker.com – PostgreSQL® Notes for Professionals 12
Chapter 4: Table Creation
Section 4.1: Show table definition
Open the psql command line tool connected to the database where your table is. Then type the following
command:
\d tablename
To get extended information type
\d+ tablename
If you have forgotten the name of the table, just type \d into psql to obtain a list of tables and views in the current
database.
Section 4.2: Create table from select
Let's say you have a table called person:
CREATE TABLE person (
person_id BIGINT NOT NULL,
last_name VARCHAR(255) NOT NULL,
first_name VARCHAR(255),
age INT NOT NULL,
PRIMARY KEY (person_id)
);
You can create a new table of people over 30 like this:
CREATE TABLE people_over_30 AS SELECT * FROM person WHERE age > 30;
Section 4.3: Create unlogged table
You can create unlogged tables so that you can make the tables considerably faster. Unlogged table skips writing
WRITE-ahead log which means it's not crash-safe and unable to replicate.
CREATE UNLOGGED TABLE person (
person_id BIGINT NOT NULL PRIMARY KEY,
last_name VARCHAR(255) NOT NULL,
first_name VARCHAR(255),
address VARCHAR(255),
city VARCHAR(255)
);
Section 4.4: Table creation with Primary Key
CREATE TABLE person (
person_id BIGINT NOT NULL,
last_name VARCHAR(255) NOT NULL,
first_name VARCHAR(255),
address VARCHAR(255),
city VARCHAR(255),
PRIMARY KEY (person_id)
GoalKicker.com – PostgreSQL® Notes for Professionals 13
);
Alternatively, you can place the PRIMARY KEY constraint directly in the column definition:
CREATE TABLE person (
person_id BIGINT NOT NULL PRIMARY KEY,
last_name VARCHAR(255) NOT NULL,
first_name VARCHAR(255),
address VARCHAR(255),
city VARCHAR(255)
);
It is recommended that you use lower case names for the table and as well as all the columns. If you use upper
case names such as Person you would have to wrap that name in double quotes ("Person") in each and every
query because PostgreSQL enforces case folding.
Section 4.5: Create a table that references other table
In this example, User Table will have a column that references the Agency table.
CREATE TABLE agencies ( -- first create the agency table
id SERIAL PRIMARY KEY,
NAME TEXT NOT NULL
)
CREATE TABLE users (
id SERIAL PRIMARY KEY,
agency_id NOT NULL INTEGER REFERENCES agencies(id) DEFERRABLE INITIALLY DEFERRED -- this is going
to references your agency table.
)
GoalKicker.com – PostgreSQL® Notes for Professionals 14
Chapter 5: SELECT
Section 5.1: SELECT using WHERE
In this topic we will base on this table of users :
CREATE TABLE sch_test.user_table
(
id serial NOT NULL,
username CHARACTER VARYING,
pass CHARACTER VARYING,
first_name CHARACTER varying(30),
last_name CHARACTER varying(30),
CONSTRAINT user_table_pkey PRIMARY KEY (id)
)
+----+------------+-----------+----------+------+
| id | first_name | last_name | username | pass |
+----+------------+-----------+----------+------+
| 1 | hello | world | hello | word |
+----+------------+-----------+----------+------+
| 2 | root | me | root | toor |
+----+------------+-----------+----------+------+
Syntax
Select every thing:
SELECT * FROM schema_name.table_name WHERE <condition>;
Select some fields :
SELECT field1, field2 FROM schema_name.table_name WHERE <condition>;
Examples
-- SELECT every thing where id = 1
SELECT * FROM schema_name.table_name WHERE id = 1;
-- SELECT id where username = ? and pass = ?
SELECT id FROM schema_name.table_name WHERE username = 'root' AND pass = 'toor';
-- SELECT first_name where id not equal 1
SELECT first_name FROM schema_name.table_name WHERE id != 1;
GoalKicker.com – PostgreSQL® Notes for Professionals 15
Chapter 6: Find String Length / Character
Length
To get length of "character varying", "text" fields, Use char_length() or character_length().
Section 6.1: Example to get length of a character varying field
Example 1, Query: SELECT CHAR_LENGTH('ABCDE')
Result:
5
Example 2, Query: SELECT CHARACTER_LENGTH('ABCDE')
Result:
5
GoalKicker.com – PostgreSQL® Notes for Professionals 16
Chapter 7: COALESCE
Coalesce returns the first none null argument from a set of arguments. Only the first non null argument is return,
all subsequent arguments are ignored. The function will evaluate to null if all arguments are null.
Section 7.1: Single non null argument
PGSQL> SELECT COALESCE(NULL, NULL, 'HELLO WORLD');
COALESCE
--------
'HELLO WORLD'
Section 7.2: Multiple non null arguments
PGSQL> SELECT COALESCE(NULL, NULL, 'first non null', NULL, NULL, 'second non null');
coalesce
--------
'first non null'
Section 7.3: All null arguments
PGSQL> SELECT COALESCE(NULL, NULL, NULL);
COALESCE
--------
GoalKicker.com – PostgreSQL® Notes for Professionals 17
Chapter 8: INSERT
Section 8.1: Insert data using COPY
COPY is PostgreSQL's bulk-insert mechanism. It's a convenient way to transfer data between files and tables, but it's
also far faster than INSERT when adding more than a few thousand rows at a time.
Let's begin by creating sample data file.
cat > samplet_data.csv
1,Yogesh
2,Raunak
3,Varun
4,Kamal
5,Hari
6,Amit
And we need a two column table into which this data can be imported into.
CREATE TABLE copy_test(id INT, NAME varchar(8));
Now the actual copy operation, this will create six records in the table.
COPY copy_test FROM '/path/to/file/sample_data.csv' DELIMITER ',';
Instead of using a file on disk, can insert data from STDIN
COPY copy_test FROM STDIN DELIMITER ',';
Enter DATA TO be copied followed BY a newline.
END WITH a backslash AND a period ON a line BY itself.
>> 7,Amol
>> 8,Amar
>> \.
TIME: 85254.306 ms
SELECT * FROM copy_test ;
id | name
----+--------
1 | Yogesh
3 | Varun
5 | Hari
7 | Amol
2 | Raunak
4 | Kamal
6 | Amit
8 | Amar
Also you can copy data from a table to file as below:
COPY copy_test TO 'path/to/file/sample_data.csv' DELIMITER ',';
For more details on COPY you can check here
GoalKicker.com – PostgreSQL® Notes for Professionals 18
Section 8.2: Inserting multiple rows
You can insert multiple rows in the database at the same time:
INSERT INTO person (NAME, age) VALUES
('john doe', 25),
('jane doe', 20);
Section 8.3: INSERT data and RETURING values
If you are inserting data into a table with an auto increment column and if you want to get the value of the auto
increment column.
Say you have a table called my_table:
CREATE TABLE my_table
(
id serial NOT NULL, -- serial data type is auto incrementing four-byte integer
NAME CHARACTER VARYING,
contact_number INTEGER,
CONSTRAINT my_table_pkey PRIMARY KEY (id)
);
If you want to insert data into my_table and get the id of that row:
INSERT INTO my_table(NAME, contact_number) VALUES ( 'USER', 8542621) RETURNING id;
Above query will return the id of the row where the new record was inserted.
Section 8.4: Basic INSERT
Let's say we have a simple table called person:
CREATE TABLE person (
person_id BIGINT,
NAME VARCHAR(255).
age INT,
city VARCHAR(255)
);
The most basic insert involves inserting all values in the table:
INSERT INTO person VALUES (1, 'john doe', 25, 'new york');
If you want to insert only specific columns, you need to explicitly indicate which columns:
INSERT INTO person (NAME, age) VALUES ('john doe', 25);
Note that if any constraints exist on the table , such as NOT NULL, you will be required to include those columns in
either case.
Section 8.5: Insert from select
You can insert data in a table as the result of a select statement:
GoalKicker.com – PostgreSQL® Notes for Professionals 19
INSERT INTO person SELECT * FROM tmp_person WHERE age < 30;
Note that the projection of the select must match the columns required for the insert. In this case, the tmp_person
table has the same columns as person.
Section 8.6: UPSERT - INSERT ... ON CONFLICT DO UPDATE..
since version 9.5 postgres offers UPSERT functionality with INSERT statement.
Say you have a table called my_table, created in several previous examples. We insert a row, returning PK value of
inserted row:
b=# INSERT INTO my_table (name,contact_number) values ('one',333) RETURNING id;
id
----
2
(1 row)
INSERT 0 1
Now if we try to insert row with existing unique key it will raise an exception:
b=# INSERT INTO my_table VALUES (2,'one',333);
ERROR: duplicate KEY VALUE violates UNIQUE CONSTRAINT "my_table_pkey"
DETAIL: KEY (id)=(2) already EXISTS.
Upsert functionality offers ability to insert it anyway, solving the conflict:
b=# INSERT INTO my_table values (2,'one',333) ON CONFLICT (id) DO UPDATE SET name =
my_table.name||' changed to: "two" at '||now() returning *;
id | name | contact_number
----+---------------------------------------------------------------------------------------------
--------------+----------------
2 | one changed to: "two" at 2016-11-23 08:32:17.105179+00 | 333
(1 row)
INSERT 0 1
Section 8.7: SELECT data into file
You can COPY table and paste it into a file.
postgres=# select * from my_table;
c1 | c2 | c3
----+----+----
1 | 1 | 1
2 | 2 | 2
3 | 3 | 3
4 | 4 | 4
5 | 5 |
(5 rows)
postgres=# copy my_table to '/home/postgres/my_table.txt' using delimiters '|' with null as
'null_string' csv header;
COPY 5
GoalKicker.com – PostgreSQL® Notes for Professionals 20
postgres=# \! cat my_table.txt
c1|c2|c3
1|1|1
2|2|2
3|3|3
4|4|4
5|5|null_string
GoalKicker.com – PostgreSQL® Notes for Professionals 21
Chapter 9: UPDATE
Section 9.1: Updating a table based on joining another table
You can also update data in a table based on data from another table:
UPDATE person
SET state_code = cities.state_code
FROM cities
WHERE cities.city = city;
Here we are joining the person city column to the cities city column in order to get the city's state code. This is
then used to update the state_code column in the person table.
Section 9.2: Update all rows in a table
You update all rows in table by simply providing a column_name = VALUE:
UPDATE person SET planet = 'Earth';
Section 9.3: Update all rows meeting a condition
UPDATE person SET state = 'NY' WHERE city = 'New York';
Section 9.4: Updating multiple columns in table
You can update multiple columns in a table in the same statement, separating col=val pairs with commas:
UPDATE person
SET country = 'USA',
state = 'NY'
WHERE city = 'New York';
GoalKicker.com – PostgreSQL® Notes for Professionals 22
Chapter 10: JSON Support
JSON - Java Script Object Notation , Postgresql support JSON Data type since 9.2 version. There are some predefined
function and operators to access the JSON data. The -> operator returns the key of JSON column. The ->> operator
returns the value of JSON Column.
Section 10.1: Using JSONb operators
Creating a DB and a Table
DROP DATABASE IF EXISTS books_db;
CREATE DATABASE books_db WITH ENCODING='UTF8' TEMPLATE template0;
DROP TABLE IF EXISTS books;
CREATE TABLE books (
id SERIAL PRIMARY KEY,
client TEXT NOT NULL,
DATA JSONb NOT NULL
);
Populating the DB
INSERT INTO books(client, DATA) VALUES (
'Joe',
'{ "title": "Siddhartha", "author": { "first_name": "Herman", "last_name": "Hesse" } }'
),(
'Jenny',
'{ "title": "Dharma Bums", "author": { "first_name": "Jack", "last_name": "Kerouac" } }'
),(
'Jenny',
'{ "title": "100 años de soledad", "author": { "first_name": "Gabo", "last_name": "Marquéz" }
}'
);
Lets see everything inside the table books:
SELECT * FROM books;
Output:
-> operator returns values out of JSON columns
Selecting 1 column:
SELECT client,
DATA->'title' AS title
FROM books;
Output:
GoalKicker.com – PostgreSQL® Notes for Professionals 23
Selecting 2 columns:
SELECT client,
DATA->'title' AS title, DATA->'author' AS author
FROM books;
Output:
-> vs ->>
The -> operator returns the original JSON type (which might be an object), whereas ->> returns text.
Return NESTED objects
You can use the -> to return a nested object and thus chain the operators:
SELECT client,
DATA->'author'->'last_name' AS author
FROM books;
Output:
Filtering
Select rows based on a value inside your JSON:
SELECT
client,
DATA->'title' AS title
FROM books
WHERE DATA->'title' = '"Dharma Bums"';
Notice WHERE uses -> so we must compare to JSON '"Dharma Bums"'
Or we could use ->> and compare to 'Dharma Bums'
Output:
GoalKicker.com – PostgreSQL® Notes for Professionals 24
Nested filtering
Find rows based on the value of a nested JSON object:
SELECT
client,
DATA->'title' AS title
FROM books
WHERE DATA->'author'->>'last_name' = 'Kerouac';
Output:
A real world example
CREATE TABLE events (
NAME varchar(200),
visitor_id varchar(200),
properties json,
browser json
);
We’re going to store events in this table, like pageviews. Each event has properties, which could be anything (e.g.
current page) and also sends information about the browser (like OS, screen resolution, etc). Both of these are
completely free form and could change over time (as we think of extra stuff to track).
INSERT INTO events (NAME, visitor_id, properties, browser) VALUES
(
'pageview', '1',
'{ "page": "/" }',
'{ "name": "Chrome", "os": "Mac", "resolution": { "x": 1440, "y": 900 } }'
),(
'pageview', '2',
'{ "page": "/" }',
'{ "name": "Firefox", "os": "Windows", "resolution": { "x": 1920, "y": 1200 } }'
),(
'pageview', '1',
'{ "page": "/account" }',
'{ "name": "Chrome", "os": "Mac", "resolution": { "x": 1440, "y": 900 } }'
),(
'purchase', '5',
'{ "amount": 10 }',
'{ "name": "Firefox", "os": "Windows", "resolution": { "x": 1024, "y": 768 } }'
),(
'purchase', '15',
'{ "amount": 200 }',
'{ "name": "Firefox", "os": "Windows", "resolution": { "x": 1280, "y": 800 } }'
),(
'purchase', '15',
'{ "amount": 500 }',
'{ "name": "Firefox", "os": "Windows", "resolution": { "x": 1280, "y": 800 } }'
);
GoalKicker.com – PostgreSQL® Notes for Professionals 25
Now lets select everything:
SELECT * FROM events;
Output:
JSON operators + PostgreSQL aggregate functions
Using the JSON operators, combined with traditional PostgreSQL aggregate functions, we can pull out whatever we
want. You have the full might of an RDBMS at your disposal.
Lets see browser usage:
SELECT browser->>'name' AS browser,
COUNT(browser)
FROM events
GROUP BY browser->>'name';
Output:
Total revenue per visitor:
SELECT visitor_id, SUM(CAST(properties->>'amount' AS INTEGER)) AS total
FROM events
WHERE CAST(properties->>'amount' AS INTEGER) > 0
GROUP BY visitor_id;
Output:
Average screen resolution
SELECT AVG(CAST(browser->'resolution'->>'x' AS INTEGER)) AS width,
AVG(CAST(browser->'resolution'->>'y' AS INTEGER)) AS height
FROM events;
Output:
GoalKicker.com – PostgreSQL® Notes for Professionals 26
More examples and documentation here and here.
Section 10.2: Querying complex JSON documents
Taking a complex JSON document in a table:
CREATE TABLE mytable (DATA JSONB NOT NULL);
CREATE INDEX mytable_idx ON mytable USING gin (DATA jsonb_path_ops);
INSERT INTO mytable VALUES($$
{
"name": "Alice",
"emails": [
"alice1@test.com",
"alice2@test.com"
],
"events": [
{
"type": "birthday",
"date": "1970-01-01"
},
{
"type": "anniversary",
"date": "2001-05-05"
}
],
"locations": {
"home": {
"city": "London",
"country": "United Kingdom"
},
"work": {
"city": "Edinburgh",
"country": "United Kingdom"
}
}
}
$$);
Query for a top-level element:
SELECT DATA->>'name' FROM mytable WHERE DATA @> '{"name":"Alice"}';
Query for a simple item in an array:
SELECT DATA->>'name' FROM mytable WHERE DATA @> '{"emails":["alice1@test.com"]}';
Query for an object in an array:
SELECT DATA->>'name' FROM mytable WHERE DATA @> '{"events":[{"type":"anniversary"}]}';
Query for a nested object:
SELECT DATA->>'name' FROM mytable WHERE DATA @> '{"locations":{"home":{"city":"London"}}}';
GoalKicker.com – PostgreSQL® Notes for Professionals 27
Performance of @> compared to -> and ->>
It is important to understand the performance difference between using @>, -> and ->> in the WHERE part of the
query. Although these two queries appear to be broadly equivalent:
SELECT DATA FROM mytable WHERE DATA @> '{"name":"Alice"}';
SELECT DATA FROM mytable WHERE DATA->'name' = '"Alice"';
SELECT DATA FROM mytable WHERE DATA->>'name' = 'Alice';
the first statement will use the index created above whereas the latter two will not, requiring a complete table scan.
It is still allowable to use the -> operator when obtaining resultant data, so the following queries will also use the
index:
SELECT DATA->'locations'->'work' FROM mytable WHERE DATA @> '{"name":"Alice"}';
SELECT DATA->'locations'->'work'->>'city' FROM mytable WHERE DATA @> '{"name":"Alice"}';
Section 10.3: Creating a pure JSON table
To create a pure JSON table you need to provide a single field with the type JSONB:
CREATE TABLE mytable (DATA JSONB NOT NULL);
You should also create a basic index:
CREATE INDEX mytable_idx ON mytable USING gin (DATA jsonb_path_ops);
At this point you can insert data in to the table and query it efficiently.
