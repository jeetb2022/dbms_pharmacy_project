-- Function to update ret_net_transactions
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


-- FUNCTION to update total_transaction of wholesaler
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