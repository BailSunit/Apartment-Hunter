CREATE OR REPLACE TRIGGER LISTING_TRIGGER
    AFTER
    INSERT
    ON LISTING
    FOR EACH ROW
    DECLARE
    uid number;
BEGIN
    select id into uid from management where first_name = 'Sunit';
    dbms_output.put_line(uid);
   INSERT INTO LISTING_STATUS(ID,IS_AVAILABLE,DATE_UPDATED,UPDATED_BY) VALUES(:new.id,'Y',SYSDATE,uid);
END;
/
