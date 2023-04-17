CREATE DATABASE dbms_proj;

-- Table storing details related Retailer
CREATE TABLE retailer_details (
	ret_id BIGSERIAL NOT NULL PRIMARY KEY,
	ret_fname VARCHAR(50) NOT NULL,
	ret_lname VARCHAR(50) NOT NULL,
	ret_email VARCHAR(50) NOT NULL,      -- Trigger to check if email already exist or not in retailer table
	ret_password VARCHAR(12) NOT NULL,
	ret_phone_number VARCHAR(10) NOT NULL,
	ret_shopname VARCHAR(50) NOT NULL,
	ret_shop_address VARCHAR(200) NOT NULL,
    ret_transactions INT         -- After every transaction it will be updated (FUNCTION)
);

CREATE FUNCTION ret_transactions(IN _ret_id INT)
RETURNS INT as $amount$
DECLARE total INT
BEGIN
    SELECT SUM(net_price) INTO total FROM transactions WHERE ret_id = _ret_id;
    UPDATE retailer_details SET ret_transactions = total
    WHERE ret_id = _ret_id;
    RETURN total;
END;
$amount$
LANGUAGE 'plpgsql';

-- Procedure to fill retailer details
CREATE PROCEDURE retailer_details_filling(
    IN _ret_fname VARCHAR, 
    IN _ret_lname VARCHAR, 
    IN _ret_email VARCHAR, 
    IN _ret_password VARCHAR, 
    IN _ret_phone_number VARCHAR, 
    IN _ret_shop_name VARCHAR, 
    IN _ret_shop_address VARCHAR
)
LANGUAGE 'plpgsql'
AS $body$
BEGIN
    INSERT INTO retailer_details(ret_fname, ret_lname, ret_email, ret_password, ret_phone_number, ret_shopname, ret_shop_address)
    VALUES (_ret_fname, _ret_lname, _ret_email, _ret_password, _ret_phone_number, _ret_shopname, _ret_shop_address);
END;
$body$;

-- Table storing details related Wholesaler
create table wholesaler_details (
	w_id BIGSERIAL NOT NULL PRIMARY KEY,
	w_fname VARCHAR(50) NOT NULL,
	w_lname VARCHAR(50) NOT NULL,
	w_email VARCHAR(50) NOT NULL,         -- Trigger to check if email already exist or not in wholesaler table
	w_password VARCHAR(50) NOT NULL,
	w_phone_number VARCHAR(50) NOT NULL,
	w_shopname VARCHAR(50) NOT NULL,
	w_shop_address VARCHAR(50) NOT NULL,
    total_transactions INT       -- After every transaction it will be updated (FUNCTION)
);

-- update total_transaction of wholesaler
CREATE FUNCTION w_transactions(IN _w_id INT)
RETURNS INT as $amount$
DECLARE total INT
BEGIN
    SELECT SUM(net_price) INTO total FROM transactions WHERE w_id = _w_id;
    UPDATE wholesaler_details SET total_transactions = total
    WHERE w_id = _w_id;
    RETURN total;
END;
$amount$
LANGUAGE 'plpgsql';


-- Procedure to fill wholesaler details
CREATE PROCEDURE wholesaler_details_filling(
    IN _w_fname VARCHAR, 
    IN _w_lname VARCHAR, 
    IN _w_email VARCHAR, 
    IN _w_password VARCHAR, 
    IN _w_phone_number VARCHAR, 
    IN _w_shop_name VARCHAR, 
    IN _w_shop_address VARCHAR
)
LANGUAGE 'plpgsql'
AS $body$
BEGIN
    INSERT INTO wholesaler_details(w_fname, w_lname, w_email, w_password, w_phone_number, w_shopname, w_shop_address)
    VALUES (_w_fname, _w_lname, _w_email, _w_password, _w_phone_number, _w_shopname, _w_shop_address);
END;
$body$;

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

-- Procedure to update wholesaler's inventory
CREATE PROCEDURE inventory_updates(
    IN _w_id INT, 
    IN _med_category VARCHAR, 
    IN _med_name VARCHAR, 
    IN _med_price INT, 
    IN _med_quantity INT
)
LANGUAGE 'plpgsql'
AS $body$
DECLARE 
    _w_shopname VARCHAR;
    _inventory_id INT;
BEGIN
    SELECT w_shopname INTO _w_shopname FROM wholesaler_details WHERE w_id = _w_id;
    
    INSERT INTO wholesaler_inventory(w_id, w_shopname, med_category, med_name, med_price, med_quantity)
    VALUES (_w_id, _w_shopname, _med_category, _med_name, _med_price, _med_quantity)
    ON CONFLICT (w_id, med_name) DO UPDATE SET med_price = _med_price, med_quantity = _med_quantity;

    SELECT inventory_id INTO _inventory_id FROM wholesaler_inventory WHERE w_id = _w_id and med_name = _med_name;
    CALL stock_update_by_wholesaler(_w_id, _inventory_id);
END;
$body$;


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
    med_quantity INT NOT NULL,
    w_id INT NOT NULL,
    w_shopname VARCHAR(50) NOT NULL,
    FOREIGN KEY (inventory_id) REFERENCES wholesaler_inventory(inventory_id),
    FOREIGN KEY (w_id) REFERENCES wholesaler_details(w_id)
);

CREATE unique index idx_wid_inventoryid on medicine_stock(w_id, inventory_id);

-- PROCEDURE to update medicine stock from wholesaler side
CREATE PROCEDURE stock_update_by_wholesaler(IN _w_id INT, IN _inventory_id INT)
LANGUAGE 'plpgsql'
AS $body$
DECLARE 
    _med_category VARCHAR;
    _med_name VARCHAR;
    _med_price INT;
    _med_quantity INT;
    _w_shopname VARCHAR;
BEGIN
    SELECT w_shopname INTO _w_shopname FROM wholesaler_details WHERE w_id = _w_id;
    SELECT med_category, med_name, med_price, med_quantity 
    INTO _med_category, _med_name, _med_price, _med_quantity
    FROM wholesaler_inventory WHERE inventory_id = _inventory_id;

    INSERT INTO medicine_stock(inventory_id, w_id, w_shopname, med_category, med_name, med_price, med_quantity)
    VALUES (_inventory_id, _w_id, _w_shopname, _med_category, _med_name, _med_price, _med_quantity)
    ON CONFLICT (w_id, inventory_id) DO UPDATE SET med_price = _med_price, med_quantity = _med_quantity;
END;
$body$;

-- PROCEDURE to update medicine stock from retailer side
CREATE PROCEDURE stock_update_by_retailer(IN _item_id INT, IN _ret_med_quantity INT)
LANGUAGE 'plpgsql'
AS $body$
DECLARE
    _med_id INT;
BEGIN
    SELECT med_id INTO _med_id FROM retailer_cart WHERE item_id = _item_id;
    UPDATE medicine_stock
    SET med_quantity = med_quantity - _ret_med_quantity
    WHERE med_id = _med_id;
END;
$body$;

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
    med_category VARCHAR(50) NOT NULL,       -- 1st Trigger
    med_name VARCHAR(50) NOT NULL,           -- 2nd Trigger
    med_id INT NOT NULL, 
    ret_med_quantity INT NOT NULL,           -- 3rd Trigger
    net_price INT NOT NULL,                 -- After every item added to the cart it will be updated(FUNCTION)
    FOREIGN KEY (ret_id) REFERENCES retailer_details(ret_id),
    FOREIGN KEY (w_id) REFERENCES wholesaler_details(w_id),
    FOREIGN KEY (med_id) REFERENCES medicine_stock(med_id)
);

-- FUNCTION to update cart price
CREATE FUNCTION total_cart_price()
RETURNS INT as $sum$
DECLARE total INT
BEGIN
    SELECT SUM(net_price) INTO total FROM retailer_cart;
    return total;
END;
$sum$
LANGUAGE 'plpgsql';


-- PROCEDURE to update retailer cart
CREATE PROCEDURE cart_update_by_retailer(
    IN _ret_id INT, 
    IN _w_id INT, 
    IN _med_id INT, 
    IN _ret_med_quantity INT)
LANGUAGE 'plpgsql'
AS $body$
DECLARE
    _ret_shopname VARCHAR;
    _w_shopname VARCHAR;
    _med_category VARCHAR;
    _med_name VARCHAR;
    _med_price INT;
    _total_price INT;
    _item_id INT;
BEGIN
    SELECT w_shopname INTO _w_shopname FROM wholesaler_details WHERE w_id = _w_id;
    SELECT ret_shopname INTO _ret_shopname FROM retailer_details WHERE ret_id = _ret_id;
    SELECT med_category, med_name, med_price INTO _med_category, _med_name, _med_price 
    FROM medicine_stock WHERE med_id = _med_id;

    INSERT INTO retailer_cart(
        ret_id, 
        w_id,
        ret_shopname,
        w_shopname,
        med_category,
        med_name,
        med_id,
        ret_med_quantity,
        net_price
    ) 
    VALUES (
        _ret_id, 
        _w_id,
        _ret_shopname,
        _w_shopname,
        _med_category,
        _med_name,
        _med_id,
        _ret_med_quantity,
        _ret_med_quantity*_med_price
    );

    SELECT item_id INTO _item_id FROM retailer_cart WHERE med_id = _med_id;
    CALL stock_update_by_retailer(_item_id, _ret_med_quantity);
END;
$body$;


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


-- PROCEDURE to fill the Transactions table
CREATE PROCEDURE update_transactions(IN _item_id INT)
LANGUAGE 'p]pgsql'
AS $body$
DECLARE 
    _ret_id VARCHAR;
    _w_id VARCHAR;
    _ret_shopname VARCHAR;
    _w_shopname VARCHAR;
    _med_category VARCHAR;
    _med_name VARCHAR;
    _med_price INT;
    _ret_med_quantity INT;
    _net_price INT;
    retail_amount INT;
    w_amount INT;
BEGIN
    SELECT ret_id, ret_shopname, w_id, w_shopname, med_category, med_name, med_price, ret_med_quantity, net_price
    INTO _ret_id, _ret_shopname, _w_id, _w_shopname, _med_category, _med_name, _med_price, _ret_med_quantity, _net_price
    FROM retailer_cart WHERE item_id = _item_id;

    SELECT ret_transactions(_ret_id) into retail_amount;      -- Function to update ret_transactions
    SELECT w_transactions(_w_id) into w_amount;               -- Function to update w_transactions
END;
$body$;

-- We will be keeping 2 Functionalties i.e. Retailers_transaction_history and Wholesalers_transaction_history
-- We will get data about both of these functionalities by joining transactions and retailer_cart.








