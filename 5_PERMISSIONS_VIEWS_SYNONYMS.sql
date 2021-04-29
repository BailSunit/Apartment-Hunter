GRANT EXECUTE ON welcome TO visitor;

CREATE OR replace PUBLIC SYNONYM welcome FOR ADMIN.welcome;

GRANT EXECUTE ON customer_signup TO visitor;

CREATE OR replace PUBLIC SYNONYM customer_signup FOR ADMIN.customer_signup;

CREATE OR replace PUBLIC SYNONYM customer_actions FOR ADMIN.customer_actions;

CREATE OR replace PUBLIC SYNONYM premium_signup FOR ADMIN.premium_signup;

CREATE OR replace PUBLIC SYNONYM abandon_premium FOR ADMIN.abandon_premium;

GRANT EXECUTE ON poster_signup TO visitor;

CREATE OR replace PUBLIC SYNONYM poster_signup FOR ADMIN.poster_signup;

CREATE OR replace PUBLIC SYNONYM poster_actions FOR ADMIN.poster_actions; 

CREATE OR replace PUBLIC SYNONYM QUESTION FOR ADMIN.QUESTION; 

CREATE OR replace PUBLIC SYNONYM complaint FOR ADMIN.complaint; 


