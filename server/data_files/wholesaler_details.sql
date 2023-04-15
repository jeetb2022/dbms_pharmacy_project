create table wholesaler_details (
	w_id BIGSERIAL NOT NULL PRIMARY KEY,
	w_fname VARCHAR(50) NOT NULL,
	w_lname VARCHAR(50) NOT NULL,
	w_email VARCHAR(50) NOT NULL,
	w_password VARCHAR(50) NOT NULL,
	w_phone_number VARCHAR(50) NOT NULL,
	w_shopname VARCHAR(50) NOT NULL,
	w_shop_address VARCHAR(50) NOT NULL
);
insert into wholesaler_details (w_fname, w_lname, w_email, w_password, w_phone_number, w_shopname, w_shop_address) values ('Kushal', 'Patel', 'kushal07@gmail.com', 'ihJu7L', '4175861620', 'Bela Drug Center', 'LG Hospital Maninagar Ahmedabad');
insert into wholesaler_details (w_fname, w_lname, w_email, w_password, w_phone_number, w_shopname, w_shop_address) values ('Jeet', 'Bhadaniya', 'jeet69@gmail.com', 'xzMDehIHSF', '2152783984', 'Shanti Medical Suppliers', 'Zydus Hospital Navrangpura Ahmedabad');
insert into wholesaler_details (w_fname, w_lname, w_email, w_password, w_phone_number, w_shopname, w_shop_address) values ('Het', 'Prajapati', 'hetu96@gmail.com', 'paXhxfAr8UM', '1155405524', 'Bhagwan Suppliers', 'Isckon Mall Bopal Ahmedabad');
