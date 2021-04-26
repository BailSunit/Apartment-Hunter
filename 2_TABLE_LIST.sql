SET 
  SERVEROUTPUT ON;
DECLARE nCount NUMBER;
BEGIN 
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'STATE';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE('TABLE STATE ALREADY EXISTS');
ELSE EXECUTE IMMEDIATE 'create table state (
id int default rental_seq.nextval,
name varchar(50) unique not null)';
EXECUTE IMMEDIATE 'alter table state add constraint state_pk primary key(id)';
EXECUTE IMMEDIATE 'Insert into STATE (NAME) values (''MA'')';
EXECUTE IMMEDIATE 'Insert into STATE (NAME) values (''NY'')';
EXECUTE IMMEDIATE 'Insert into STATE (NAME) values (''CA'')';
EXECUTE IMMEDIATE 'Insert into STATE (NAME) values (''NC'')';
EXECUTE IMMEDIATE 'Insert into STATE (NAME) values (''TX'')';
END IF;
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'CITY';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE('TABLE CITY ALREADY EXISTS');
ELSE EXECUTE IMMEDIATE 'create table city (
id int default rental_seq.nextval,
name varchar(50) not null,
state_id int references state(id))';
EXECUTE IMMEDIATE 'alter table city add constraint city_pk primary key(id)';
EXECUTE IMMEDIATE 'Insert into CITY (NAME,STATE_ID) values (''Boston'',(select id from state where name = ''MA''))';
EXECUTE IMMEDIATE 'Insert into CITY (NAME,STATE_ID) values (''New Jersey'',(select id from state where name = ''NY''))';
EXECUTE IMMEDIATE 'Insert into CITY (NAME,STATE_ID) values (''Los Angeles'',(select id from state where name = ''CA''))';
EXECUTE IMMEDIATE 'Insert into CITY (NAME,STATE_ID) values (''Charlotte'',(select id from state where name = ''NC''))';
EXECUTE IMMEDIATE 'Insert into CITY (NAME,STATE_ID) values (''Dallas'',(select id from state where name = ''TX''))';
END IF;
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'STREET';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE('TABLE STREET ALREADY EXISTS');
ELSE EXECUTE IMMEDIATE 'create table street (
id int default rental_seq.nextval,
name varchar(50) not null,
city_id int references city(id))';
EXECUTE IMMEDIATE 'alter table street add constraint street_pk primary key(id)';
EXECUTE IMMEDIATE 'Insert into STREET (NAME,CITY_ID) values (''Huntington Ave'',(select id from city where name = ''Boston''))';
EXECUTE IMMEDIATE 'Insert into STREET (NAME,CITY_ID) values (''Bloomfield Ave'',(select id from city where name = ''New Jersey''))';
EXECUTE IMMEDIATE 'Insert into STREET (NAME,CITY_ID) values (''Hollywood Boulevard'',(select id from city where name = ''Los Angeles''))';
EXECUTE IMMEDIATE 'Insert into STREET (NAME,CITY_ID) values (''Beresford Road'',(select id from city where name = ''Charlotte''))';
EXECUTE IMMEDIATE 'Insert into STREET (NAME,CITY_ID) values (''Main Street District'',(select id from city where name = ''Dallas''))';
END IF;
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'TAGS';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE('TABLE TAGS ALREADY EXISTS');
ELSE EXECUTE IMMEDIATE 'create table tags (
id int default rental_seq.nextval,
tag varchar2(50))';
EXECUTE IMMEDIATE 'alter table tags add constraint tags_pk primary key(id)';
EXECUTE IMMEDIATE 'Insert into TAGS (TAG) values (''STUDENT_FRIENDLY'')';
EXECUTE IMMEDIATE 'Insert into TAGS (TAG) values (''PROFESSIONALS ONLY'')';
EXECUTE IMMEDIATE 'Insert into TAGS (TAG) values (''PET FRIENDLY'')';
EXECUTE IMMEDIATE 'Insert into TAGS (TAG) values (''RECENTLY RENOVATED'')';
END IF;
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'ADDRESS';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE('TABLE ADDRESS ALREADY EXISTS');
ELSE EXECUTE IMMEDIATE 'create table address (
id int default rental_seq.nextval,
door_no int,
street_id int references street(id))';
EXECUTE IMMEDIATE 'alter table address add constraint address_pk primary key(id)';
EXECUTE IMMEDIATE 'Insert into ADDRESS (DOOR_NO,STREET_ID) values (76,(select id from street where name = ''Huntington Ave''))';
EXECUTE IMMEDIATE 'Insert into ADDRESS (DOOR_NO,STREET_ID) values (1044,(select id from street where name = ''Bloomfield Ave''))';
EXECUTE IMMEDIATE 'Insert into ADDRESS (DOOR_NO,STREET_ID) values (12,(select id from street where name = ''Hollywood Boulevard''))';
EXECUTE IMMEDIATE 'Insert into ADDRESS (DOOR_NO,STREET_ID) values (98,(select id from street where name = ''Beresford Road''))';
EXECUTE IMMEDIATE 'Insert into ADDRESS (DOOR_NO,STREET_ID) values (154,(select id from street where name = ''Main Street District''))';
END IF;
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'POSTER';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE('TABLE POSTER ALREADY EXISTS');
ELSE EXECUTE IMMEDIATE 'create table poster (
id int default rental_seq.nextval,
user_name varchar2(40) unique,
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
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'AREA';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE('TABLE AREA ALREADY EXISTS');
ELSE EXECUTE IMMEDIATE 'create table area (
id int default rental_seq.nextval,
min_area int,
max_area int)';
EXECUTE IMMEDIATE 'alter table area add constraint area_pk primary key(id)';
EXECUTE IMMEDIATE 'Insert into AREA (MIN_AREA,MAX_AREA) values (100,200)';
EXECUTE IMMEDIATE 'Insert into AREA (MIN_AREA,MAX_AREA) values (200,300)';
EXECUTE IMMEDIATE 'Insert into AREA (MIN_AREA,MAX_AREA) values (300,400)';
EXECUTE IMMEDIATE 'Insert into AREA (MIN_AREA,MAX_AREA) values (400,500)';
EXECUTE IMMEDIATE 'Insert into AREA (MIN_AREA,MAX_AREA) values (500,600)';
EXECUTE IMMEDIATE 'Insert into AREA (MIN_AREA,MAX_AREA) values (600,700)';
EXECUTE IMMEDIATE 'Insert into AREA (MIN_AREA,MAX_AREA) values (700,800)';
END IF;
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'LEASE_TYPE';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE(
  'TABLE LEASE_TYPE ALREADY EXISTS'
);
ELSE EXECUTE IMMEDIATE 'create table lease_type (
id int default rental_seq.nextval,
lease_period varchar(30),
max_cosigners int)';
EXECUTE IMMEDIATE 'alter table lease_type add constraint lease_type_pk primary key(id)';
EXECUTE IMMEDIATE 'Insert into LEASE_TYPE (LEASE_PERIOD,MAX_COSIGNERS) values (''6m'',2)';
EXECUTE IMMEDIATE 'Insert into LEASE_TYPE (LEASE_PERIOD,MAX_COSIGNERS) values (''12m'',4)';
EXECUTE IMMEDIATE 'Insert into LEASE_TYPE (LEASE_PERIOD,MAX_COSIGNERS) values (''18m'',2)';
EXECUTE IMMEDIATE 'Insert into LEASE_TYPE (LEASE_PERIOD,MAX_COSIGNERS) values (''6m'',3)';
EXECUTE IMMEDIATE 'Insert into LEASE_TYPE (LEASE_PERIOD,MAX_COSIGNERS) values (''2y'',2)';
END IF;
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'PROPERTY_TYPE';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE(
  'TABLE PROPERTY_TYPE ALREADY EXISTS'
);
ELSE EXECUTE IMMEDIATE 'create table property_type (
id int default rental_seq.nextval,
type varchar(50),
beds int,
baths int)';
EXECUTE IMMEDIATE 'alter table property_type add constraint property_type_pk primary key(id)';
EXECUTE IMMEDIATE 'Insert into PROPERTY_TYPE (TYPE,BEDS,BATHS) values (''APARTMENT'',2,1)';
EXECUTE IMMEDIATE 'Insert into PROPERTY_TYPE (TYPE,BEDS,BATHS) values (''APARTMENT'',2,2)';
EXECUTE IMMEDIATE 'Insert into PROPERTY_TYPE (TYPE,BEDS,BATHS) values (''APARTMENT'',3,2)';
EXECUTE IMMEDIATE 'Insert into PROPERTY_TYPE (TYPE,BEDS,BATHS) values (''HOUSE'',4,2)';
EXECUTE IMMEDIATE 'Insert into PROPERTY_TYPE (TYPE,BEDS,BATHS) values (''OUTHOUSE'',1,1)';
END IF;
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'MANAGEMENT';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE(
  'TABLE MANAGEMENT ALREADY EXISTS'
);
ELSE EXECUTE IMMEDIATE 'create table management (
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
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'LISTING';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE('TABLE LISTING ALREADY EXISTS');
ELSE EXECUTE IMMEDIATE 'create table listing (
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
listing_status_id int)';
EXECUTE IMMEDIATE 'alter table listing add constraint listing_pk primary key(id)';
END IF;
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'LISTING_STATUS';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE(
  'TABLE LISTING_STATUS ALREADY EXISTS'
);
ELSE EXECUTE IMMEDIATE 'create table listing_status (
id int references listing(id),
is_available char(1),
date_updated date,
updated_by int references management(id))';
EXECUTE IMMEDIATE 'alter table listing_status add constraint listing_status_pk primary key(id)';
END IF;
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'LISTING_TAGS';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE(
  'TABLE LISTING_TAGS ALREADY EXISTS'
);
ELSE EXECUTE IMMEDIATE 'create table listing_tags (
listing_id int references listing(id),
tag_id int references tags(id))';
EXECUTE IMMEDIATE 'alter table listing_tags add constraint listing_tags_pk primary key(listing_id)';
END IF;
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'CUSTOMER_TYPE';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE(
  'TABLE CUSTOMER_TYPE ALREADY EXISTS'
);
ELSE EXECUTE IMMEDIATE 'create table customer_type (
id int default rental_seq.nextval,
type varchar(50))';
EXECUTE IMMEDIATE 'alter table customer_type add constraint customer_type_pk primary key(id)';
EXECUTE IMMEDIATE 'Insert into CUSTOMER_TYPE (TYPE) values (''STUDENT'')';
EXECUTE IMMEDIATE 'Insert into CUSTOMER_TYPE (TYPE) values (''PROFESSIONAL'')';
EXECUTE IMMEDIATE 'Insert into CUSTOMER_TYPE (TYPE) values (''COUPLE'')';
EXECUTE IMMEDIATE 'Insert into CUSTOMER_TYPE (TYPE) values (''FAMILY'')';
END IF;
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'CUSTOMER';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE(
  'TABLE CUSTOMER ALREADY EXISTS'
);
ELSE EXECUTE IMMEDIATE 'create table customer (
id int default rental_seq.nextval,
user_name varchar2(40) unique,
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
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'SUBSCRIPTIONS';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE(
  'TABLE SUBSCRIPTIONS ALREADY EXISTS'
);
ELSE EXECUTE IMMEDIATE 'create table subscriptions (
subscription_id int default rental_seq.nextval,
subscription_end_date date,
customer_id int references customer(id))';
EXECUTE IMMEDIATE 'alter table subscriptions add constraint subscriptions_pk primary key(subscription_id)';
END IF;
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'COMPLAINTS';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE(
  'TABLE COMPLAINTS ALREADY EXISTS'
);
ELSE EXECUTE IMMEDIATE 'create table complaints (
id int default rental_seq.nextval,
date_added date,
date_resolved date,
listing_id int references listing(id) not null,
comments varchar2(100) not null,
addressed_by int references management(id) not null)';
EXECUTE IMMEDIATE 'alter table complaints add constraint complaints_pk primary key(id)';
EXECUTE IMMEDIATE 'Insert into MANAGEMENT (FIRST_NAME,LAST_NAME,ADDRESS_ID,ZIP_CODE,PAY,CONTACT,PASSWORD) values (''Sunit'',''Bail'',(select id from address where door_no = 1044),46521,6000,''38469274'',''sfuygeryueT67'')';
END IF;
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'QUERY';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE('TABLE QUERY ALREADY EXISTS');
ELSE EXECUTE IMMEDIATE 'create table query (
id int default rental_seq.nextval,
listing_id int references listing(id) not null,
customer_id int references customer(id),
date_added date,
date_answered date,
query varchar2(100) not null,
reply varchar2(100))';
EXECUTE IMMEDIATE 'alter table query add constraint query_pk primary key(id)';
END IF;
SELECT 
  count(*) into nCount 
FROM 
  user_tables 
where 
  table_name = 'OFFER';
IF(nCount > 0) THEN DBMS_OUTPUT.PUT_LINE('TABLE OFFER ALREADY EXISTS');
ELSE EXECUTE IMMEDIATE 'create table offer (
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
