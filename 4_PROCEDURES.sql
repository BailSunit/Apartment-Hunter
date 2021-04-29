--HELP TO NEW_CUSTOMERS
CREATE OR replace PROCEDURE Welcome
AS
BEGIN
    dbms_output.Put_line('WELCOME USER!');

    dbms_output.Put_line('EXECUTE THE BELOW PROCEDURE TO SIGNUP AS CUSTOMER');

dbms_output.Put_line('CUSTOMER_SIGNUP(USER_NAME,FIRST_NAME,LAST_NAME,ADDRESS_ID,ZIP_CODE,CONTACT,EMAIL,PASSWORD,CUSTOMER_TYPE_ID)');

dbms_output.Put_line('FOR ALL INFO NEEDED TO SIGN UP, RUN THE FOLLOWING ');
dbms_output.Put_line('select * from address_list');
dbms_output.Put_line('select * from customer_type_list');
dbms_output.Put_line('select * from property_type_list');
dbms_output.Put_line('select * from lease_type_list');


dbms_output.Put_line('EXECUTE THE BELOW PROCEDURE TO SIGNUP AS POSTER');

dbms_output.Put_line('POSTER_SIGNUP(USER_NAME,FIRST_NAME,LAST_NAME,IS_SUBLET,IS_OWNER,IS_AGENT,ADDRESS_ID,ZIP_CODE,CONTACT,EMAIL,PASSWORD)');

dbms_output.Put_line('AFTER LOGGING IN EXECUTE EITHER POSTER_ACTIONS OR CUSTOMER_ACTIONS TO SEE THE LIST OF AVAILABLE ACTIONS');
EXCEPTION
  WHEN OTHERS THEN
             dbms_output.Put_line(SQLERRM);

             dbms_output.Put_line(dbms_utility.format_error_backtrace);

             ROLLBACK;
END welcome;

/
CREATE OR replace PROCEDURE Customer_actions
AS
BEGIN
    dbms_output.Put_line('HELLO '
                         ||Sys_context('USERENV', 'SESSION_USER')
                         ||' !');

    dbms_output.Put_line('OPERATIONS ALLOWED:');

dbms_output.Put_line('-------------ACCOUNT RELATED ACTIONS-------------');

dbms_output.Put_line('1. View your address by executing SELECT * FROM ADDRESS_<USER_NAME>');
dbms_output.Put_line('1. View all addresses by executing SELECT * FROM ADDRESS_LIST');
dbms_output.Put_line('1. View your Personnel Details by executing SELECT * FROM CUSTOMER_<USER_NAME>');

dbms_output.Put_line('2. SIGNUP FOR A PREMIUM ACCOUNT USING PREMIUM_SIGNUP()');

dbms_output.Put_line('');

dbms_output.Put_line('-------------LISTING RELATED ACTIONS-------------');

dbms_output.Put_line('1. LOOK AT ALL THE RECENT LISTINGS USING SELECT * FROM USER_LISTINGS ');
dbms_output.Put_line('2. TO SUBMIT A QUERY, EXECUTE QUESTION(LISTING_ID, QUERY) ');
dbms_output.Put_line('3. TO SUBMIT A COMPLAINT, EXECUTE COMPLAINT(LISTING_ID, COMPLAINT) ');


dbms_output.Put_line('');

dbms_output.Put_line('-------------PREMIUM RELATED ACTIONS-------------');

dbms_output.Put_line('1. TO SIGNUP FOR PREMIUM EXECUTE PREMIUM_SIGNUP ');

dbms_output.Put_line('2. TO ABANDON PREMIUM EXECUTE ABANDON_PREMIUM ');

dbms_output.Put_line('3. TO VIEW PREMIUM LISTINGS EXECUTE PREMIUM LISTING ');
EXCEPTION
  WHEN OTHERS THEN
             dbms_output.Put_line(SQLERRM);

             dbms_output.Put_line(dbms_utility.format_error_backtrace);

             ROLLBACK;
END customer_actions;

/
CREATE OR replace PROCEDURE Customer_signup(uname            VARCHAR,
                                            firstname        VARCHAR,
                                            lastname         VARCHAR,
                                            address_id       NUMBER,
                                            zip_code         NUMBER,
                                            contact          NUMBER,
                                            email            VARCHAR,
                                            password         VARCHAR,
                                            customer_type_id INT)
IS
  UID          NUMBER;
  user_address VARCHAR(1000 CHAR);
  sqlstmt      VARCHAR(1000 CHAR);
  ncount       NUMBER;
BEGIN
    SELECT Count(*)
    INTO   ncount
    FROM   all_users
    WHERE  username = Upper(uname);

    IF( ncount > 0 ) THEN
dbms_output.Put_line('User already exists.. If you are the user, then connect with your credentials and execute CUSTOMER_ACTIONS to see all available actions.');
  ELSE
    INSERT INTO customer
                (user_name,
                 first_name,
                 last_name,
                 address_id,
                 zip_code,
                 contact,
                 email,
                 password,
                 customer_type_id,
                 date_joined,
                 last_activity)
    VALUES      (Upper(uname),
                 Upper(firstname),
                 Upper(lastname),
                 address_id,
                 zip_code,
                 contact,
                 email,
                 password,
                 customer_type_id,
                 SYSDATE,
                 SYSDATE);

    EXECUTE IMMEDIATE'CREATE USER '||uname||' IDENTIFIED BY '||password;

    EXECUTE IMMEDIATE'GRANT CUSTOMER_INFO6210 TO '||uname;

    COMMIT;

    SELECT id
    INTO   UID
    FROM   customer
    WHERE  user_name = Upper(uname);

    dbms_output.Put_line(UID);

    --CREATE ADDRESS_VIEW
    user_address := 'CREATE OR REPLACE VIEW ADDRESS_'
                    ||uname
                    ||' AS SELECT customer.first_name, customer.last_name, address.id,address.door_no,street.name as Street, city.name as City, state.name as State from customer inner join address on customer.address_id = address.id inner join street on address.street_id = street.id inner join city on street.city_id = city.id inner join state on city.state_id = state.id where customer.id='
                    ||UID;

    EXECUTE IMMEDIATE user_address;

    dbms_output.Put_line('address view created');

    EXECUTE IMMEDIATE 'CREATE OR REPLACE PUBLIC SYNONYM ADDRESS_'||uname||
    ' FOR ADMIN.ADDRESS_'||uname;

    dbms_output.Put_line('SYNONYM CREATED FOR ADDRESS');

    EXECUTE IMMEDIATE 'GRANT SELECT ON ADDRESS_'||uname||' TO '||uname;

    dbms_output.Put_line('address view granted');

    --CREATE SELF VIEW
    EXECUTE IMMEDIATE'CREATE OR REPLACE VIEW CUSTOMER_'||uname||
    ' AS SELECT * FROM CUSTOMER WHERE ID='||UID;

    dbms_output.Put_line('Customer VIEW created');

    EXECUTE IMMEDIATE 'CREATE OR REPLACE PUBLIC SYNONYM CUSTOMER_'||uname||
    ' FOR admin.CUSTOMER_'||uname;

    dbms_output.Put_line('Customer SYNONYM created');

    EXECUTE IMMEDIATE 'GRANT SELECT ON CUSTOMER_'||uname||' TO '||uname;

    dbms_output.Put_line('Customer view granted');

    --GIVE ACCESS TO PROCEDURES
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON CUSTOMER_ACTIONS TO '||uname;
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON QUESTION TO '||uname;
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON COMPLAINT TO '||uname;

    --ALLOW PREMIUM SIGNUP
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON PREMIUM_SIGNUP TO '||uname;
    
    --ALLOW PREMIUM ABANDON
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON ABANDON_PREMIUM TO '||uname;
    
    --ALLOW LISTINGS VIEW
    EXECUTE IMMEDIATE 'GRANT SELECT ON USER_LISTINGS TO '||uname;


    dbms_output.Put_line('all actions granted');

    COMMIT;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
             dbms_output.Put_line(SQLERRM);

             dbms_output.Put_line(dbms_utility.format_error_backtrace);

             ROLLBACK;
END customer_signup;

/
--OPERATIONS ALLOWED OF POSTERS
CREATE OR replace PROCEDURE Poster_actions
AS
BEGIN
    dbms_output.Put_line('HELLO '
                         ||Sys_context('USERENV', 'SESSION_USER')
                         ||' !');

    dbms_output.Put_line('OPERATIONS ALLOWED:');

    dbms_output.Put_line('------------- PERSONAL INFORMATION -------------');

dbms_output.Put_line('1. VIEW YOUR INFORMATION USING SELECT * FROM POSTER_<YOUR_USER_NAME>');

dbms_output.Put_line('');

dbms_output.Put_line('-------------LISTING RELATED ACTIONS-------------');

dbms_output.Put_line('1. ADD A NEW LISTING USING ADD_LISTING(IS_PREMIUM,BANNER,DESCRIPT,ADDRESS_ID,ZIP_CODE,RENT,DEPOSIT,BROKERAGE,AREA_ID,HEAT,HOT_WATER,LAUNDRY,DATE_AVAILABLE,LEASE_ID,PROPERTY_TYPE_ID)');

dbms_output.Put_line('2. REMOVE A LISTING USING REMOVE_LISTING(MY_LISTING_ID number) ');

dbms_output.Put_line('3. VIEW YOUR LISTINGS USING SELECT * FROM MY_LISTINGS_<user_name>');

dbms_output.Put_line('3. Add a query by executing QUERY()');

dbms_output.Put_line('');

dbms_output.Put_line('-------------ACCOUNT RELATED ACTIONS-------------');

dbms_output.Put_line('1. View your address by executing SELECT * FROM ADDRESS_<USER_NAME>');
dbms_output.Put_line('1. View your Personnel Details by executing SELECT * FROM POSTER_<USER_NAME>');


EXCEPTION
  WHEN OTHERS THEN
             dbms_output.Put_line(SQLERRM);

             dbms_output.Put_line(dbms_utility.format_error_backtrace);

             ROLLBACK;
END poster_actions;

/
CREATE OR replace PROCEDURE Poster_signup(uname      VARCHAR,
                                          firstname  VARCHAR,
                                          lastname   VARCHAR,
                                          is_sublet  CHAR,
                                          is_owner   CHAR,
                                          is_agent   CHAR,
                                          address_id NUMBER,
                                          zip_code   NUMBER,
                                          contact    NUMBER,
                                          email      VARCHAR,
                                          password   VARCHAR)
IS
  UID            NUMBER;
  poster_address VARCHAR(1000 CHAR);
  ncount         NUMBER;
BEGIN
    SELECT Count(*)
    INTO   ncount
    FROM   all_users
    WHERE  username = Upper(uname);

    IF( ncount > 0 ) THEN
dbms_output.Put_line('User already exists.. If you are the user, then connect with your credentials and execute POSTER_ACTIONS to see all available actions.');
  ELSE
    INSERT INTO poster
                (user_name,
                 first_name,
                 last_name,
                 is_sublet,
                 is_owner,
                 is_agent,
                 date_joined,
                 last_activity,
                 address_id,
                 zip_code,
                 contact,
                 email,
                 password)
    VALUES     (Upper(uname),
                Upper(firstname),
                Upper(lastname),
                is_sublet,
                is_owner,
                is_agent,
                SYSDATE,
                SYSDATE,
                address_id,
                zip_code,
                contact,
                Upper(email),
                password);

    EXECUTE IMMEDIATE'CREATE USER '||uname||' IDENTIFIED BY '||password;

    EXECUTE IMMEDIATE'GRANT POSTER_INFO6210 TO '||uname;

    COMMIT;

    SELECT id
    INTO   UID
    FROM   poster
    WHERE  user_name = Upper(uname);

    dbms_output.Put_line(UID);

    --CREATE ADDRESS_VIEW
    poster_address := 'CREATE OR REPLACE VIEW ADDRESS_'
                      ||uname
                      ||' AS SELECT poster.first_name, poster.last_name, address.id,address.door_no,street.name as Street, city.name as City, state.name as State from poster inner join address on poster.address_id = address.id inner join street on address.street_id = street.id inner join city on street.city_id = city.id inner join state on city.state_id = state.id where poster.id='
                      ||UID;

    EXECUTE IMMEDIATE poster_address;

    dbms_output.Put_line('address view created');

    EXECUTE IMMEDIATE 'CREATE OR REPLACE PUBLIC SYNONYM ADDRESS_'||uname||
    ' FOR admin.ADDRESS_'||uname;

    dbms_output.Put_line('SYNONYM CREATED FOR ADDRESS');

    EXECUTE IMMEDIATE 'GRANT SELECT ON ADDRESS_'||uname||' TO '||uname;

    dbms_output.Put_line('address view granted');

    --CREATE POSTINGS VIEW
    poster_address := 'CREATE OR REPLACE VIEW MY_LISTINGS_'
                      ||Upper(uname)
                      ||' AS SELECT * FROM LISTING WHERE POSTED_BY = '
                      ||UID;

    EXECUTE IMMEDIATE poster_address;

    EXECUTE IMMEDIATE 'CREATE OR REPLACE PUBLIC SYNONYM MY_LISTINGS_'||Upper
    (
    uname)||' FOR admin.MY_LISTINGS_'||Upper(uname);

    dbms_output.Put_line('Poster SYNONYM created');

    EXECUTE IMMEDIATE 'GRANT SELECT ON MY_LISTINGS_'||uname||' TO '||uname;

    --CREATE SELF VIEW
    EXECUTE IMMEDIATE'CREATE OR REPLACE VIEW POSTER_'||uname||
    ' AS SELECT * FROM POSTER WHERE ID='||UID;

    dbms_output.Put_line('Poster VIEW created');

    EXECUTE IMMEDIATE 'CREATE OR REPLACE PUBLIC SYNONYM POSTER_'||uname||
    ' FOR admin.POSTER_'||uname;

    dbms_output.Put_line('Poster SYNONYM created');

    EXECUTE IMMEDIATE 'GRANT SELECT ON POSTER_'||uname||' TO '||uname;

    dbms_output.Put_line('Poster view granted');

    --GIVE ACCESS TO PROCEDURES
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON POSTER_ACTIONS TO '||uname;

    dbms_output.Put_line('all actions granted');

    COMMIT;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
             dbms_output.Put_line(SQLERRM);

             dbms_output.Put_line(dbms_utility.format_error_backtrace);

             ROLLBACK;
END poster_signup;

/
CREATE OR replace PROCEDURE Premium_signup
IS
  ncount NUMBER;
  cus_id NUMBER;
BEGIN
	SELECT id into cus_id
      FROM   customer
     WHERE  user_name = USER;

    SELECT Count(*)
    INTO   ncount
    FROM   subscriptions
    WHERE  customer_id = (SELECT id
                          FROM   customer
                          WHERE  user_name = USER);

    IF( ncount > 0 ) THEN
      dbms_output.Put_line('User is already a Premium member.');
    ELSE
      INSERT INTO subscriptions
                  (subscription_end_date,
                   customer_id)
      VALUES      (SYSDATE + 365,
                   (SELECT id
                    FROM   customer
                    WHERE  user_name = USER));

      EXECUTE IMMEDIATE 'GRANT SELECT ON PREMIUM_LISTINGS TO '||USER;

      dbms_output.Put_line('Premium Listings view granted');

      EXECUTE IMMEDIATE 'GRANT EXECUTE ON ABANDON_PREMIUM TO '||USER;

  dbms_output.Put_line('Customer VIEW created');

  COMMIT;
END IF;
EXCEPTION
  WHEN OTHERS THEN
             dbms_output.Put_line(SQLERRM);

             dbms_output.Put_line(dbms_utility.format_error_backtrace);

             ROLLBACK;
END premium_signup;

/
CREATE OR replace PROCEDURE Abandon_premium
IS
  ncount NUMBER;
  cus_id NUMBER;
BEGIN
	SELECT id into cus_id
      FROM   customer
     WHERE  user_name = USER;
    SELECT Count(*)
    INTO   ncount
    FROM   subscriptions
    WHERE  customer_id = cus_id;

    IF( ncount = 0 ) THEN
      dbms_output.Put_line('User is NOT Premium member.');
    ELSE
    
      EXECUTE IMMEDIATE 'DELETE FROM SUBSCRIPTIONS WHERE CUSTOMER_ID =  '|| cus_id;
      
      EXECUTE IMMEDIATE 'REVOKE SELECT ON PREMIUM_LISTINGS FROM '||USER;

      dbms_output.Put_line('Customer VIEW created');
    END IF;
EXCEPTION
  WHEN OTHERS THEN
             dbms_output.Put_line(SQLERRM);

             dbms_output.Put_line(dbms_utility.format_error_backtrace);

             ROLLBACK;
END abandon_premium;

/

create or replace procedure QUESTION(
LISTING_ID int,
QUERY varchar2)
is
cus_id number;
begin
	SELECT id into cus_id
      FROM   customer
     WHERE  user_name = USER;
insert into query(LISTING_ID,CUSTOMER_ID,DATE_ADDED,QUERY)values(LISTING_ID,cus_id,sysdate,QUERY);

EXCEPTION
  WHEN OTHERS THEN
             dbms_output.Put_line(SQLERRM);

             dbms_output.Put_line(dbms_utility.format_error_backtrace);

             ROLLBACK;

end QUESTION;
/
create or replace procedure complaint(
LISTING_ID int,
COMMENTS varchar2
)
is
cus_id number;
begin
	SELECT id into cus_id
      FROM   customer
     WHERE  user_name = USER;

insert into complaints(LISTING_ID,DATE_ADDED,ADDRESSED_BY,COMMENTS)values(LISTING_ID,sysdate,COMMENTS);
end complaint;
/