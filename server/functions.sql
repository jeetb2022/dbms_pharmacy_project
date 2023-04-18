-- Function to update ret_net_transactions
CREATE FUNCTION ret_transactions(IN _ret_id INT)
RETURNS INT as $amount$
DECLARE total INT;
BEGIN
    SELECT SUM(net_price) INTO total FROM transactions WHERE ret_id = _ret_id;
    UPDATE retailer_details SET ret_transactions = total
    WHERE ret_id = _ret_id;
    RETURN total;
END;
$amount$
LANGUAGE plpgsql;


-- FUNCTION to update total_transaction of wholesaler
CREATE FUNCTION w_transactions(IN _w_id INT)
RETURNS INT as $amount$
DECLARE total INT;
BEGIN
    SELECT SUM(net_price) INTO total FROM transactions WHERE w_id = _w_id;
    UPDATE wholesaler_details SET total_transactions = total
    WHERE w_id = _w_id;
    RETURN total;
END;
$amount$
LANGUAGE plpgsql;


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

CREATE FUNCTION total_price_of_med(IN _quantity INT, IN price INT)
RETURNS INT as $amt$
BEGIN
    return _quantity*price;
END;
$amt$
LANGUAGE 'plpgsql';


-- Trigger Functions 
CREATE FUNCTION check_medicine_bounds()
RETURNS TRIGGER AS $medicine_quantity_trigger$
BEGIN
    if NEW.med_quantity <2000 then 

    
END;
$medicine_quantity_trigger$
LANGUAGE plpgsql;




