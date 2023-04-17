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
CREATE FUNCTION total_cart_price()
RETURNS INT as $sum$
DECLARE total INT;
BEGIN
    SELECT SUM(net_price) INTO total FROM retailer_cart;
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
LANGUAGE plpgsql;

-- Function with a CURSOR to get Retailer's History
CREATE FUNCTION get_retailer_orders(_ret_id INTEGER) 
RETURNS TABLE (
    order_id INT, item_id INT, w_id INT, w_shopname VARCHAR, med_category VARCHAR, med_name VARCHAR, 
    med_id INT, ret_med_quantity INT, net_price INT, order_date TIMESTAMP
) AS $$
DECLARE
    cur_orders CURSOR FOR SELECT order_id, item_id, w_id, w_shopname, med_category, med_name, med_id, ret_med_quantity, net_price, order_date
    FROM transactions WHERE ret_id = _ret_id;
    rec_order transactions%ROWTYPE;
BEGIN
    OPEN cur_orders;
    FETCH cur_orders INTO rec_order;
    WHILE FOUND LOOP
        order_id := rec_order.order_id;
        item_id := rec_order.item_id;
        w_id := rec_order.w_id;
        w_shopname := rec_order.w_shopname;
        med_category := rec_order.med_category;
        med_name := rec_order.med_name;
        med_id := rec_order.med_id;
        ret_med_quantity := rec_order.ret_med_quantity;
        net_price := rec_order.net_price;
        order_date := rec_order.order_date;
        RETURN NEXT;
        FETCH cur_orders INTO rec_order;
    END LOOP;
    CLOSE cur_orders;
END;
$$ LANGUAGE plpgsql;


-- FUNCTION with CURSOR to get wholesaler's detail
CREATE FUNCTION get_wholesaler_orders(_w_id INTEGER) 
RETURNS TABLE (
    order_id INT, item_id INT, ret_id INT, ret_shopname VARCHAR, med_category VARCHAR, med_name VARCHAR, 
    med_id INT, ret_med_quantity INT, net_price INT, order_date TIMESTAMP
) AS $$
DECLARE
    cur_orders CURSOR FOR SELECT order_id, item_id, w_id, w_shopname, med_category, med_name, med_id, ret_med_quantity, net_price, order_date
    FROM transactions WHERE w_id = _w_id;
    rec_order transactions%ROWTYPE;
BEGIN
    OPEN cur_orders;
    FETCH cur_orders INTO rec_order;
    WHILE FOUND LOOP
        order_id := rec_order.order_id;
        item_id := rec_order.item_id;
        ret_id := rec_order.ret_id;
        ret_shopname := rec_order.ret_shopname;
        med_category := rec_order.med_category;
        med_name := rec_order.med_name;
        med_id := rec_order.med_id;
        ret_med_quantity := rec_order.ret_med_quantity;
        net_price := rec_order.net_price;
        order_date := rec_order.order_date;
        RETURN NEXT;
        FETCH cur_orders INTO rec_order;
    END LOOP;
    CLOSE cur_orders;
END;
$$ LANGUAGE plpgsql;


