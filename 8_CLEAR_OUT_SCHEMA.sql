BEGIN
   FOR cur_rec IN (SELECT object_name, object_type
                   FROM user_objects
                   WHERE object_type IN
                             ('TABLE',
                              'VIEW',
                              'MATERIALIZED VIEW',
                              'PACKAGE',
                              'PROCEDURE',
                              'FUNCTION',
                              'SEQUENCE',
                              'SYNONYM',
                              'PACKAGE BODY'
                             ))
   LOOP
      BEGIN
         IF cur_rec.object_type = 'TABLE'
         THEN
            EXECUTE IMMEDIATE 'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '" CASCADE CONSTRAINTS';
         ELSE
            EXECUTE IMMEDIATE 'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '"';
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line ('FAILED: DROP '
                                  || cur_rec.object_type
                                  || ' "'
                                  || cur_rec.object_name
                                  || '"'
                                 );
      END;
   END LOOP;
   FOR cur_rec IN (SELECT * 
                   FROM all_synonyms 
                   WHERE table_owner IN (SELECT USER FROM dual))
   LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM ' || cur_rec.synonym_name;
      END;
   END LOOP;
      FOR cur_rec IN (SELECT * 
                   FROM user_sequences )
   LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP SEQUENCE ' || cur_rec.sequence_name;
      END;
   END LOOP;
END;

--delete roles
drop role customer_info6210;
drop role poster_info6210;

--delete trigger
DROP TRIGGER listing_status_trigger;

    begin
      for i in (select view_name from user_views) loop
        execute immediate 'drop view ' || i.view_name;
      end loop;
    end;

    begin
      for i in (select synonym_name from user_synonyms) loop
        execute immediate 'drop synonym ' || i.synonym_name;
      end loop;
    end;
        begin
      for i in (SELECT username from all_users WHERE TO_CHAR(trunc(CREATED))=TO_CHAR(trunc(SYSDATE))) loop
        execute immediate 'drop user ' || i.username || ' cascade';
      end loop;
    end;
/