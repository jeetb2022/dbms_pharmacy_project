create table retailer_details (
	ret_id BIGSERIAL NOT NULL PRIMARY KEY,
	ret_fname VARCHAR(50) NOT NULL,
	ret_lname VARCHAR(50) NOT NULL,
	ret_email VARCHAR(50) NOT NULL,
	ret_password VARCHAR(12) NOT NULL,
	ret_phone_number VARCHAR(10) NOT NULL,
	ret_shopname VARCHAR(50) NOT NULL,
	ret_shop_address VARCHAR(200) NOT NULL
);
insert into retailer_details (ret_fname, ret_lname, ret_email, ret_password, ret_phone_number, ret_shopname, ret_shop_address) values ('Dhanashri', 'Wala', 'dhanashri87@gmail.com', '49yEhFUpw6', '2305926872', 'Wala Medical Store', 'Kankaria Lake');
insert into retailer_details (ret_fname, ret_lname, ret_email, ret_password, ret_phone_number, ret_shopname, ret_shop_address) values ('Zenil', 'Sanghvi', 'zenil23@gmail.com', 'xsHclMwjZ', '4695410413', 'Krishna Medical Store', 'SG Highway');
insert into retailer_details (ret_fname, ret_lname, ret_email, ret_password, ret_phone_number, ret_shopname, ret_shop_address) values ('Neel', 'Sheth', 'neels02@gmail.com', 'Arz1OgBdOK8', '3847807800', 'Jain Medical Store', 'CG Road');
insert into retailer_details (ret_fname, ret_lname, ret_email, ret_password, ret_phone_number, ret_shopname, ret_shop_address) values ('Keval', 'Juthani', 'kevalk65@gmail.com', 'hMq8lrKpZ', '2495713110', 'Raju Medical Store', 'Hanuman Plaza Bopal');
insert into retailer_details (ret_fname, ret_lname, ret_email, ret_password, ret_phone_number, ret_shopname, ret_shop_address) values ('Adnan', 'Kadiwala', 'adnan49@gmail.com', 'iGpUdQy', '7641141079', 'Gujarat Medical Store', 'Sindhu Bhavan Road');
