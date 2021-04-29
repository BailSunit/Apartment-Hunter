show user;
--USER is "VISITOR"

--Data needed for signup
select * from address_list;
select * from customer_type_list;
select * from property_type_list;
select * from lease_type_list;

set serveroutput on;

exec welcome;

--SIGNUP as a Customer
exec customer_signup('sbail100','Sunit','Bail',1020,06543,8357803500,'sunit.bail@gmail.com','sudkgewDUHIUDFi239',1042);

--Repeat Signup to show error
customer_signup('Anil','Guldan',1020,06543,8357803500,'anil.guldan@gmail.com','sudkgewDUHIUDFi239',1042,sysdate,sysdate);

exec poster_signup('pster1','Paul','Simmons','N','N','Y',1019,9873,'936294027','pauly@whocares.com','vhidshfUIiasjdh77');
