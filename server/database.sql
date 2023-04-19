-------------------------------------------TABLE TO STORE EMAIL_ID and PASSWORD of RETAILER-----------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE retailer_email_id(
    ret_email VARCHAR NOT NULL,
    ret_password VARCHAR NOT NULL
);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-------------------------------------------Table storing details related Retailer-------------------------------------------
CREATE TABLE retailer_details (
	ret_id BIGSERIAL NOT NULL PRIMARY KEY,
	ret_fname VARCHAR(50) NOT NULL,
	ret_lname VARCHAR(50) NOT NULL,
	ret_email VARCHAR NOT NULL,      -- Trigger to check if email already exist or not in retailer table
	ret_password VARCHAR(12) NOT NULL,
	ret_phone_number VARCHAR(10) NOT NULL,
	ret_shopname VARCHAR(50) NOT NULL,
	ret_shop_address VARCHAR(200) NOT NULL,
    ret_transactions INT,         -- After every transaction it will be updated (FUNCTION)
    ret_number_of_transaction INT,
);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------TABLE TO STORE EMAIL_ID and PASSWORD of WHOLESALER-----------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE wholesaler_email_id(
    w_email VARCHAR NOT NULL,
    w_password VARCHAR NOT NULL
);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-------------------------------------------Table storing details related Wholesaler-------------------------------------------
create table wholesaler_details (
	w_id BIGSERIAL NOT NULL PRIMARY KEY,
	w_fname VARCHAR(50) NOT NULL,
	w_lname VARCHAR(50) NOT NULL,
	w_email VARCHAR(50) NOT NULL,         -- Trigger to check if email already exist or not in wholesaler table
	w_password VARCHAR(50) NOT NULL,
	w_phone_number VARCHAR(50) NOT NULL,
	w_shopname VARCHAR(50) NOT NULL,
	w_shop_address VARCHAR(50) NOT NULL,
    total_transactions INT,      -- After every transaction it will be updated (FUNCTION)
    w_number_of_transactions INT,
);

---------------------------------------------------------------------------------------------------------------------------------


-- Table in which wholesaler updates his stock 
-- only wholesaler can read/write the data in this table
-- A trigger can be implemented here on the med)quantity as it can never be less than 2000.
-- A procedure will be placed here which will be updating the inventory whenever a retailer 
-- buys stock from this wholsaler 
create table wholesaler_inventory(
    inventory_id BIGSERIAL NOT NULL,
    w_id INT NOT NULL,
    w_shopname VARCHAR(50) NOT NULL,
    med_category VARCHAR(50) NOT NULL,
    med_name VARCHAR(50) NOT NULL,
    med_price INT NOT NULL,
    med_quantity INT NOT NULL,         -- Trigger
    FOREIGN KEY (w_id) REFERENCES wholesaler_details(w_id),
    PRIMARY KEY (inventory_id)
);
CREATE unique index idx_wid_medname on wholesaler_inventory(w_id, med_name);

---------------------------------------------------------------------------------------------------------------------------------

-- Table in which every medicine's data will be available.
-- The data of this table will be directly fetched from the TABLE wholesaler_inventory.
-- Two procedures will be placed in this table which will regularly updates this table.
-- One procedure will be placed which will add all the data everytime any wholesaler 
-- updates his inventory.
-- Other procedure will be placed when any retailer fetch the data of this table and put in it's 
-- retailer cart.

create table medicine_stock(
    med_id BIGSERIAL NOT NULL PRIMARY KEY,
    inventory_id INT,
    med_category VARCHAR(50) NOT NULL,
    med_name VARCHAR(50) NOT NULL,
    med_price INT NOT NULL,
    med_quantity INT NOT NULL,           --TRIGGER when less than 2000 
    w_id INT NOT NULL,
    w_shopname VARCHAR(50) NOT NULL,
    FOREIGN KEY (inventory_id) REFERENCES wholesaler_inventory(inventory_id),
    FOREIGN KEY (w_id) REFERENCES wholesaler_details(w_id)
);

CREATE unique index idx_wid_inventoryid on medicine_stock(w_id, inventory_id);

---------------------------------------------------------------------------------------------------------------------------------


-- Table in which reatiler will add items he wants to buy 
-- The data in this table will be fetched from the medicine_stock TABLE
-- 3 triggers will be placed here on retailer whenever he tries to access any 
-- med_name, med_category and med_quantity which is currently out of stock in the medicine_stock TABLE.
-- A function will be created here which will be calculating the Total Amount of the current cart
-- we can make this a procedure as well by constatntly updating it after every item retailer puts in cart.
create table retailer_cart(
    item_id BIGSERIAL NOT NULL PRIMARY KEY,
    ret_id INT NOT NULL,
    w_id INT NOT NULL,
    ret_shopname VARCHAR(50) NOT NULL,
    w_shopname VARCHAR(50) NOT NULL,
    med_category VARCHAR(50) NOT NULL,       
    med_name VARCHAR(50) NOT NULL,           
    med_id INT NOT NULL, 
    ret_med_quantity INT NOT NULL,           
    net_price INT NOT NULL,                 -- After every item added to the cart it will be updated(FUNCTION)
    FOREIGN KEY (ret_id) REFERENCES retailer_details(ret_id),
    FOREIGN KEY (w_id) REFERENCES wholesaler_details(w_id),
    FOREIGN KEY (med_id) REFERENCES medicine_stock(med_id)
);
---------------------------------------------------------------------------------------------------------------------------------



-- This table will store all the cart transactions that has happened till now 
-- There will be PROCEDURE to fill out the data in this table
-- The procedure will take place after every succesful retailer_cart's transaction
create table transactions(
    order_id BIGSERIAL NOT NULL PRIMARY KEY,
    item_id INT NOT NULL,
    ret_id INT NOT NULL,
    ret_shopname VARCHAR(50) NOT NULL,
    w_id INT NOT NULL,
    w_shopname VARCHAR(50) NOT NULL,
    med_category VARCHAR(50) NOT NULL,       
    med_name VARCHAR(50) NOT NULL,          
    med_id INT NOT NULL, 
    ret_med_quantity INT NOT NULL,           
    net_price INT NOT NULL,
    order_date TIMESTAMP,
    FOREIGN KEY (ret_id) REFERENCES retailer_details(ret_id),
    FOREIGN KEY (w_id) REFERENCES wholesaler_details(w_id),
    FOREIGN KEY (item_id) REFERENCES retailer_cart(item_id) 
);


---------------------------------------------------------------------------------------------------------------------------------
-- We will be keeping 2 Functionalties i.e. Retailers_transaction_history and Wholesalers_transaction_history
-- We will get data about both of these functionalities by joining transactions and retailer_cart.








