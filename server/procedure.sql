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
    VALUES (_ret_fname, _ret_lname, _ret_email, _ret_password, _ret_phone_number, _ret_shop_name, _ret_shop_address);
END;
$body$;
-- CALL retailer_details_filling('Kushal', 'Patel', 'kushal.p@ahduni.edu.in', 'password', '1234554321', 'Natraj', 'Maninagar');
---------------------------------------------------------------------------------------------------------------------------------


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
    VALUES (_w_fname, _w_lname, _w_email, _w_password, _w_phone_number, _w_shop_name, _w_shop_address);
END;
$body$;
-- CALL wholesaler_details_filling('Kushal', 'Patel', 'kushal.p@ahduni.edu.in', 'password', '1234554321', 'Natraj', 'Maninagar');
---------------------------------------------------------------------------------------------------------------------------------

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
-- CALL inventory_updates(1, 'Pain-killer', 'Dolo-650', 200, 5000);
---------------------------------------------------------------------------------------------------------------------------------


-- PROCEDURE to update medicine stock from wholesaler side
CREATE OR REPLACE PROCEDURE stock_update_by_wholesaler(IN _w_id INT, IN _inventory_id INT)
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
---------------------------------------------------------------------------------------------------------------------------------



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
---------------------------------------------------------------------------------------------------------------------------------


-- PROCEDURE to update retailer cart
CREATE PROCEDURE cart_update_by_retailer(
    IN _ret_id INT, 
    IN _med_id INT, 
    IN _ret_med_quantity INT)
LANGUAGE 'plpgsql'
AS $body$
DECLARE
    _w_id INT;
    _ret_shopname VARCHAR;
    _w_shopname VARCHAR;
    _med_category VARCHAR;
    _med_name VARCHAR;
    _med_price INT;
    _total_price INT;
    _item_id INT;
BEGIN
    SELECT ret_shopname INTO _ret_shopname FROM retailer_details WHERE ret_id = _ret_id;
    SELECT w_id, w_shopname, med_category, med_name, med_price INTO _w_id, _w_shopname, _med_category, _med_name, _med_price 
    FROM medicine_stock WHERE med_id = _med_id;
    SELECT total_price_of_med(_ret_med_quantity, _med_price) INTO _total_price;
    

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
        _total_price
    );

    SELECT item_id INTO _item_id FROM retailer_cart WHERE med_id = _med_id;
    CALL stock_update_by_retailer(_item_id, _ret_med_quantity);
END;
$body$;
-- CALL cart_update_by_retailer(1, 1, 2000);
---------------------------------------------------------------------------------------------------------------------------------



-- PROCEDURE to fill the Transactions table
CREATE PROCEDURE update_transactions(IN _item_id INT)
LANGUAGE 'plpgsql'
AS $body$
DECLARE 
    _ret_id VARCHAR;
    _w_id VARCHAR;
    _ret_shopname VARCHAR;
    _w_shopname VARCHAR;
    _med_category VARCHAR;
    _med_name VARCHAR;
    _med_id INT;
    _med_price INT;
    _ret_med_quantity INT;
    _net_price INT;
    retail_amount INT;
    w_amount INT;
BEGIN
    SELECT ret_id, ret_shopname, w_id, w_shopname, med_category, med_name, med_id, ret_med_quantity, net_price
    INTO _ret_id, _ret_shopname, _w_id, _w_shopname, _med_category, _med_name, _med_price, _ret_med_quantity, _net_price
    FROM retailer_cart WHERE item_id = _item_id;
    INSERT INTO transactions(item_id, ret_id, ret_shopname, w_id, w_shopname, med_category, med_name, med_id, ret_med_quantity, net_price)
    VALUES(_item_id, _ret_id, _ret_shopname, _w_id, _w_shopname, _med_category, _med_name, _med_price, _ret_med_quantity, _net_price);
END;
$body$;
---------------------------------------------------------------------------------------------------------------------------------

