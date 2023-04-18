-- Function to update ret_net_transactions
-- It will be triggered everytime transactions updates
CREATE FUNCTION ret_transactions()
RETURNS TRIGGER as $amount$
DECLARE 
    total INT;
    num_trans INT;
BEGIN
    SELECT SUM(net_price) INTO total FROM transactions WHERE ret_id = NEW.ret_id;
    SELECT COUNT(*) INTO num_trans FROM transactions WHERE ret_id = NEW.ret_id;
    UPDATE retailer_details SET ret_transactions = total, ret_number_of_transaction = num_trans
    WHERE ret_id = _ret_id;

    RETURN total;
END;
$amount$
LANGUAGE plpgsql;

---------------------------------------------------------------------------------------------------------------------------------

-- FUNCTION to update total_transaction of wholesaler
-- It will be triggered everytime transactions updates
CREATE FUNCTION w_transactions()
RETURNS TRIGGER as $amount$
DECLARE 
    total INT;
    num_trans INT;
BEGIN
    SELECT SUM(net_price) INTO total FROM transactions WHERE w_id = NEW.w_id;
    SELECT COUNT(*) INTO num_trans FROM transactions WHERE w_id = NEW.w_id;
    UPDATE wholesaler_details SET total_transactions = total, w_number_of_transactions = num_trans
    WHERE w_id = _w_id;
    RETURN total;
END;
$amount$
LANGUAGE plpgsql;

---------------------------------------------------------------------------------------------------------------------------------

-- FUNCTION to update cart price
CREATE FUNCTION total_cart_price(IN _ret_id INT)
RETURNS INT as $sum$
DECLARE total INT;
BEGIN
    SELECT SUM(net_price) INTO total FROM retailer_cart
    WHERE ret_id = _ret_id;
    return total;
END;
$sum$
LANGUAGE plpgsql;

---------------------------------------------------------------------------------------------------------------------------------

-- FUNCTION to calculate total price of medicine
CREATE FUNCTION total_price_of_med(IN _quantity INT, IN price INT)
RETURNS INT as $amt$
BEGIN
    return _quantity*price;
END;
$amt$
LANGUAGE 'plpgsql';

---------------------------------------------------------------------------------------------------------------------------------


-- Trigger Functions 
CREATE FUNCTION check_medicine_bounds()
RETURNS TRIGGER AS $medicine_quantity_trigger$
BEGIN
    if NEW.med_quantity <2000 then 
        RAISE ERROR 
END;
$medicine_quantity_trigger$
LANGUAGE plpgsql;

---------------------------------------------------------------------------------------------------------------------------------


