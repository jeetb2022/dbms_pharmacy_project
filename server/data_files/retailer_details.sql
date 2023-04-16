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
