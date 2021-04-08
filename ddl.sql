CREATE SEQUENCE rental_seq
 START WITH     1000
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

SET SERVEROUTPUT ON;
DECLARE
nCount NUMBER;
BEGIN
SELECT count(*) into nCount FROM user_tables where table_name = 'STATE';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE STATE ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table state (
id int default rental_seq.nextval,
name varchar(50) unique not null)';

EXECUTE IMMEDIATE 'alter table state add constraint state_pk primary key(id)';
END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'CITY';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE CITY ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table city (
id int default rental_seq.nextval,
name varchar(50) not null,
state_id int references state(id))';

EXECUTE IMMEDIATE 'alter table city add constraint city_pk primary key(id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'STREET';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE STREET ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table street (
id int default rental_seq.nextval,
name varchar(50) not null,
city_id int references city(id))';

EXECUTE IMMEDIATE 'alter table street add constraint street_pk primary key(id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'TAGS';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE TAGS ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table tags (
id int default rental_seq.nextval,
tag varchar2(50))';

EXECUTE IMMEDIATE 'alter table tags add constraint tags_pk primary key(id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'ADDRESS';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE ADDRESS ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table address (
id int default rental_seq.nextval,
door_no int,
street_id int references street(id))';

EXECUTE IMMEDIATE 'alter table address add constraint address_pk primary key(id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'POSTER';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE POSTER ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table poster (
id int default rental_seq.nextval,
first_name varchar2(40),
last_name varchar2(40) not null,
is_sublet char(1),
is_owner char(1),
is_agent char(1),
date_joined date,
last_activity date,
address_id int references address(id) not null,
zip_code number not null,
contact varchar2(10) not null, 
email varchar2(100) not null,
password varchar(50) not null)';

EXECUTE IMMEDIATE 'alter table poster add constraint poster_pk primary key(id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'AREA';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE AREA ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table area (
id int default rental_seq.nextval,
min_area int,
max_area int)';

EXECUTE IMMEDIATE 'alter table area add constraint area_pk primary key(id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'LEASE_TYPE';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE LEASE_TYPE ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table lease_type (
id int default rental_seq.nextval,
lease_period varchar(30),
max_cosigners int)';

EXECUTE IMMEDIATE 'alter table lease_type add constraint lease_type_pk primary key(id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'PROPERTY_TYPE';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE PROPERTY_TYPE ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table property_type (
id int default rental_seq.nextval,
type varchar(50),
beds int,
baths int)';

EXECUTE IMMEDIATE 'alter table property_type add constraint property_type_pk primary key(id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'MANAGEMENT';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE MANAGEMENT ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table management (
id int default rental_seq.nextval,
first_name varchar2(50),
last_name varchar2(50) not null,
address_id int references address(id),
zip_code number not null,
pay decimal,
contact varchar2(10) not null,
password varchar2(30) not null)';

EXECUTE IMMEDIATE 'alter table management add constraint management_pk primary key(id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'LISTING_STATUS';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE LISTING_STATUS ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table listing_status (
id int default rental_seq.nextval,
is_available char(1),
date_updated date,
updated_by int references management(id))';

EXECUTE IMMEDIATE 'alter table listing_status add constraint listing_status_pk primary key(id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'LISTING';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE LISTING ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table listing (
id int default rental_seq.nextval,
is_premium char(1),
banner varchar2(40) not null,
descript varchar2(40) not null,
address_id int references address(id) not null,
zip_code number not null,
posted_by int references poster(id) not null,
rent decimal,
deposit decimal, 
brokerage decimal,
area_id int references area(id),
heat char(1),
hot_water char(1),
laundry char(1),
date_available date,
lease_id int references lease_type(id),
property_type_id int references property_type(id),
date_posted date,
listing_status_id int references listing_status(id))';

EXECUTE IMMEDIATE 'alter table listing add constraint listing_pk primary key(id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'LISTING_TAGS';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE LISTING_TAGS ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table listing_tags (
listing_id int references listing(id),
tag_id int references tags(id))';

EXECUTE IMMEDIATE 'alter table listing_tags add constraint listing_tags_pk primary key(listing_id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'CUSTOMER_TYPE';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE CUSTOMER_TYPE ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table customer_type (
id int default rental_seq.nextval,
type varchar(50))';

EXECUTE IMMEDIATE 'alter table customer_type add constraint customer_type_pk primary key(id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'CUSTOMER';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE CUSTOMER ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table customer (
id int default rental_seq.nextval,
first_name varchar2(40),
last_name varchar2(40) not null,
address_id int references address(id),
zip_code number not null,
contact varchar2(10) not null, 
email varchar2(100) not null,
password varchar(50) not null,
customer_type_id int references customer_type(id),
date_joined date not null,
last_activity date)';

EXECUTE IMMEDIATE 'alter table customer add constraint customer_pk primary key(id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'SUBSCRIPTIONS';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE SUBSCRIPTIONS ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table subscriptions (
subscription_id int default rental_seq.nextval,
subscription_end_date date,
customer_id int references customer(id))';

EXECUTE IMMEDIATE 'alter table subscriptions add constraint subscriptions_pk primary key(subscription_id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'COMPLAINTS';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE COMPLAINTS ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table complaints (
id int default rental_seq.nextval,
date_added date,
date_resolved date,
listing_id int references listing(id) not null,
comments varchar2(100) not null,
addressed_by int references management(id) not null)';

EXECUTE IMMEDIATE 'alter table complaints add constraint complaints_pk primary key(id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'QUERY';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE QUERY ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table query (
id int default rental_seq.nextval,
listing_id int references listing(id) not null,
customer_id int references customer(id),
date_added date,
date_answered date,
query varchar2(100) not null,
reply varchar2(100))';

EXECUTE IMMEDIATE 'alter table query add constraint query_pk primary key(id)';

END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'OFFER';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE OFFER ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'create table offer (
id int default rental_seq.nextval,
user_id int references customer(id) not null,
listing_id int references listing(id) not null,
date_added date,
rent decimal,
lease_period varchar(50),
move_in date,
status char(1),
date_addressed date,
comments varchar2(100))';

EXECUTE IMMEDIATE 'alter table offer add constraint offer_pk primary key(id)';

END IF;


END;