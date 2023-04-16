CREATE DATABASE dbms_proj;

-- Table storing details related Retailer
create or replace table retailer_details (
	ret_id BIGSERIAL NOT NULL PRIMARY KEY,
	ret_fname VARCHAR(50) NOT NULL,
	ret_lname VARCHAR(50) NOT NULL,
	ret_email VARCHAR(50) NOT NULL,
	ret_password VARCHAR(12) NOT NULL,
	ret_phone_number VARCHAR(10) NOT NULL,
	ret_shopname VARCHAR(50) NOT NULL,
	ret_shop_address VARCHAR(200) NOT NULL,
    ret_transactions INT         -- After every transaction it will be updated (PROCEDURE)
);

-- Table storing details related Wholesaler
create or replace table wholesaler_details (
	w_id BIGSERIAL NOT NULL PRIMARY KEY,
	w_fname VARCHAR(50) NOT NULL,
	w_lname VARCHAR(50) NOT NULL,
	w_email VARCHAR(50) NOT NULL,
	w_password VARCHAR(50) NOT NULL,
	w_phone_number VARCHAR(50) NOT NULL,
	w_shopname VARCHAR(50) NOT NULL,
	w_shop_address VARCHAR(50) NOT NULL,
	w_rating INT,                -- After every transaction it will be updated (PROCEDURE)
    total_transactions INT       -- AFter every transaction it will be updated (PROCEDURE)
);

-- Table in which wholesaler updates his stock 
-- only wholesaler can read/write the data in this table
-- A trigger can be implemented here on the med)quantity as it can never be less than 2000.
-- A procedure will be placed here which will be updating the inventory whenever a retailer 
-- buys stock from this wholsaler 
create or replace table wholesaler_inventory(
    inventory_id BIGSERIAL NOT NULL PRIMARY KEY,
    w_id INT NOT NULL,
    w_shopname VARCHAR(50) NOT NULL,
    med_category VARCHAR(50) NOT NULL,
    med_name VARCHAR(50) NOT NULL,
    med_price INT NOT NULL,
    med_quantity INT NOT NULL,         -- Trigger
    FOREIGN KEY (w_id) REFERENCES wholesaler_details(w_id)
);

-- Table in which every medicine's data will be available.
-- The data of this table will be directly fetched from the TABLE wholesaler_inventory.
-- Two procedures will be placed in this table which will regularly updates this table.
-- One procedure will be placed which will add all the data everytime any wholesaler 
-- updates his inventory.
-- Other procedure will be placed when any retailer fetch the data of this table and put in it's 
-- retailer cart.

create or replace table medicine_stock(
    med_id BIGSERIAL NOT NULL PRIMARY KEY,
    med_category VARCHAR(50) NOT NULL,
    med_name VARCHAR(50) NOT NULL,
    med_price INT NOT NULL,
    med_quantity INT NOT NULL,
    w_id INT NOT NULL,
    w_shop_address VARCHAR(50) NOT NULL,
    FOREIGN KEY (w_id) REFERENCES wholesaler_details(w_id)
);

-- Table in which reatiler will add items he wants to buy 
-- The data in this table will be fetched from the medicine_stock TABLE
-- 3 triggers will be placed here on retailer whenever he tries to access any 
-- med_name, med_category and med_quantity which is currently out of stock in the medicine_stock TABLE.
-- A function will be created here which will be calculating the Total Amount of the current cart
-- we can make this a procedure as well by constatntly updating it after every item retailer puts in cart.
create or replace table retailer_cart(
    item_id BIGSERIAL NOT NULL PRIMARY KEY,
    ret_id INT NOT NULL,
    w_id INT NOT NULL,
    ret_shopname VARCHAR(50) NOT NULL,
    w_shopname VARCHAR(50) NOT NULL,
    med_category VARCHAR(50) NOT NULL,       -- 1st Trigger
    med_name VARCHAR(50) NOT NULL,           -- 2nd Trigger
    med_id INT NOT NULL, 
    ret_med_quantity INT NOT NULL,           -- 3rd Trigger
    cart_price INT NOT NULL,                 -- After every item added to the cart it will be updated(FUNCTION)
    FOREIGN KEY (ret_id) REFERENCES retailer_details(ret_id),
    FOREIGN KEY (w_id) REFERENCES wholesaler_details(w_id),
    FOREIGN KEY (med_id) REFERENCES medicine_stock(w_id)
);

-- This table will store all the cart transactions that has happened till now 
-- There will be PROCEDURE to fill out the data in this table
-- The procedure will take place after every succesful retailer_cart's transaction
create or replace table transactions(
    order_id BIGSERIAL NOT NULL PRIMARY KEY,
    ret_id INT NOT NULL,
    ret_shopname VARCHAR(50) NOT NULL,
    w_id INT NOT NULL,
    w_shopname VARCHAR(50) NOT NULL,
    total_amount INT NOT NULL,
    order_date TIMESTAMP,
    FOREIGN KEY (ret_id) REFERENCES retailer_details(ret_id),
    FOREIGN KEY (w_id) REFERENCES wholesaler_details(w_id)
);

-- We will be keeping 2 Functionalties i.e. Retailers_transaction_history and Wholesalers_transaction_history
-- We will get data about both of these functionalities by joining transactions and retailer_cart.








