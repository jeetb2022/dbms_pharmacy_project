CREATE TABLE wholesaler_rating(
    w_id BIGSERIAL NOT NULL PRIMARY KEY,
    w_fname VARCHAR(50) NOT NULL,
	w_lname VARCHAR(50) NOT NULL,
    w_phone_number VARCHAR(50) NOT NULL,
	w_shopname VARCHAR(50) NOT NULL,
	w_shop_address VARCHAR(50) NOT NULL,
    w_rating INT NOT NULL,
    total_transactions INT NOT NULL
)