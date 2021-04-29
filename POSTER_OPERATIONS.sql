show user;
-----execute POSTER_ACTIONS

set serveroutput on;

exec poster_actions;

select * from poster_pster1;

select * from my_listings_pster1;

select * from address_pster1;
--Add a listing
BEGIN
 LISTING_OPERATIONS.ADD_LISTING('0','CityView apartment for Rent!','Immediate move in',1019,86492,1600,0,600,1028,'Y','Y','N',to_date('01-AUG-21','DD-MON-RR'),1034,1036);
 END;

--Add a listing
BEGIN
 LISTING_OPERATIONS.ADD_LISTING('1','Mission Main apartment for Rent!','Immediate move in',1019,86492,1600,0,600,1028,'Y','Y','N',to_date('01-AUG-21','DD-MON-RR'),1034,1036);
 END;


-- Delete a listing

BEGIN
 LISTING_OPERATIONS.DELETE_LISTING();
 END;
