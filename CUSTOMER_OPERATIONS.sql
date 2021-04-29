show user;

-----execute CUSTOMER_ACTIONS
set serveroutput on;
BEGIN
	CUSTOMER_ACTIONS;
END;

SELECT * FROM ADDRESS_SBAIL100;
SELECT * FROM CUSTOMER_SBAIL100;

SELECT * FROM user_listings;

select * from premium_listings;

select * from address_list;

exec premium_signup;

exec abandon_premium;