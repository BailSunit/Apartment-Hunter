SET serveroutput ON;
DECLARE
    ncount NUMBER;
BEGIN
    SELECT Count(*)
    INTO   ncount
    FROM   user_sequences
    WHERE  sequence_name = 'RENTAL_SEQ';

    IF( ncount > 0 ) THEN
      dbms_output.Put_line('SEQUENCE RENTAL_SEQ ALREADY EXISTS');
    ELSE
      EXECUTE IMMEDIATE 'CREATE SEQUENCE rental_seq  START WITH     1000  INCREMENT BY   1  NOCACHE  NOCYCLE';
    END IF;
END; 