create or replace view address_list as 
select address.id,address.door_no,street.name as Street, city.name as City, state.name as State from
address inner join street on address.street_id = street.id
inner join city on street.city_id = city.id
inner join state on city.state_id = state.id;

GRANT SELECT ON ADDRESS_LIST TO CUSTOMER_INFO6210;
GRANT SELECT ON ADDRESS_LIST TO POSTER_INFO6210;
GRANT SELECT ON ADDRESS_LIST TO VISITOR;

CREATE OR REPLACE PUBLIC SYNONYM address_list FOR admin.address_list;

create or replace view customer_type_list as 
select * from customer_type;

GRANT SELECT ON customer_type_list TO CUSTOMER_INFO6210;
GRANT SELECT ON customer_type_list TO VISITOR;

CREATE OR REPLACE PUBLIC SYNONYM customer_type_list FOR admin.customer_type_list;

create or replace view property_type_list as 
select * from property_type;

GRANT SELECT ON property_type_list TO CUSTOMER_INFO6210;
GRANT SELECT ON property_type_list TO POSTER_INFO6210;
GRANT SELECT ON property_type_list TO VISITOR;

CREATE OR REPLACE PUBLIC SYNONYM property_type_list FOR admin.property_type_list;

create or replace view lease_type_list as 
select * from lease_type;

GRANT SELECT ON lease_type_list TO CUSTOMER_INFO6210;
GRANT SELECT ON lease_type_list TO POSTER_INFO6210;
GRANT SELECT ON lease_type_list TO VISITOR;

CREATE OR REPLACE PUBLIC SYNONYM lease_type_list FOR admin.lease_type_list;

CREATE OR replace VIEW user_listings
AS
  SELECT *
  FROM   listing
  WHERE  is_premium = '0';
  
  grant select on user_listings to customer_info6210;

CREATE OR replace public SYNONYM user_listings FOR ADMIN.user_listings;

CREATE OR replace VIEW user_premium_listings
AS
  SELECT *
  FROM   listing
  WHERE  is_premium = '1';

CREATE OR replace public SYNONYM premium_listings FOR ADMIN.user_premium_listings;
