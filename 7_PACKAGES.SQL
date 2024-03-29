SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE LISTING_OPERATIONS
AS 
PROCEDURE ADD_LISTING(IS_PREMIUM char,BANNER varchar,DESCRIPT varchar,ADDRESS_ID number,ZIP_CODE number,RENT number,DEPOSIT number,BROKERAGE number,AREA_ID number,HEAT char,HOT_WATER char,LAUNDRY char,DATE_AVAILABLE DATE,LEASE_ID number,PROPERTY_TYPE_ID number);
PROCEDURE DELETE_LISTING(LISTING_ID NUMBER);
END LISTING_OPERATIONS;
/
CREATE OR REPLACE PACKAGE BODY LISTING_OPERATIONS
AS
PROCEDURE ADD_LISTING(IS_PREMIUM char,BANNER varchar,DESCRIPT varchar,ADDRESS_ID number,ZIP_CODE number,RENT number,DEPOSIT number,BROKERAGE number,AREA_ID number,HEAT char,HOT_WATER char,LAUNDRY char,DATE_AVAILABLE DATE,LEASE_ID number,PROPERTY_TYPE_ID number)
AS
UID number;
BEGIN
dbms_output.put_line(USER);
select id into UID from poster where user_name=USER;
dbms_output.put_line(UID);
Insert into LISTING (IS_PREMIUM,BANNER,DESCRIPT,ADDRESS_ID,ZIP_CODE,POSTED_BY,RENT,DEPOSIT,BROKERAGE,AREA_ID,HEAT,HOT_WATER,LAUNDRY,DATE_AVAILABLE,LEASE_ID,PROPERTY_TYPE_ID,DATE_POSTED) values (IS_PREMIUM,BANNER,DESCRIPT,ADDRESS_ID,ZIP_CODE,uid,RENT,DEPOSIT,BROKERAGE,AREA_ID,HEAT,HOT_WATER,LAUNDRY,DATE_AVAILABLE,LEASE_ID,PROPERTY_TYPE_ID,sysdate);
COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
        dbms_output.put_line('Please provide the correct values according to the signature given in POSTER_ACTIONS..');
        rollback;
        raise;
END ADD_LISTING;
PROCEDURE DELETE_LISTING(LISTING_ID NUMBER)
AS
UID number;
BEGIN
dbms_output.put_line(USER);
select id into UID from poster where user_name=USER;
dbms_output.put_line(UID);
DELETE FROM LISTING WHERE ID=LISTING_ID;
DELETE FROM LISTING_STATUS WHERE ID=LISTING_ID;
COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
        dbms_output.put_line('Please provide the correct values according to the signature given in POSTER_ACTIONS..');
        rollback;
        raise;
END DELETE_LISTING;
END LISTING_OPERATIONS;
/

GRANT EXECUTE ON LISTING_OPERATIONS TO POSTER_INFO6210;
CREATE OR REPLACE PUBLIC SYNONYM LISTING_OPERATIONS FOR ADMIN.LISTING_OPERATIONS;

