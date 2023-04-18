-- TRIGGERS THAT WILL FIRE AT FRONTEND
------------------------------------------TRIGGER DURING RETAILER SIGN UP WITH EXISTING ACCOUNT---------------------------------------------------

CREATE FUNCTION retailer_email_exists()
RETURNS TRIGGER AS $$
BEGIN 
    IF NEW.ret_email = OLD.ret_email THEN
        RAISE EXCEPTION 'Retailer account form the email-id already exists';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enforce_ret_email_check
BEFORE INSERT ON retailer_email_id
    FOR EACH ROW EXECUTE FUNCTION retailer_email_exists();
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------TRIGGER DURING WHOLESALER SIGN UP WITH EXISTING ACCOUNT---------------------------------------------------

CREATE FUNCTION wholesaler_email_exists()
RETURNS TRIGGER AS $$
BEGIN 
    IF NEW.w_email = OLD.w_email THEN
        RAISE EXCEPTION 'Wholesaler account form the email-id already exists';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enforce_w_email_check
BEFORE INSERT ON wholesaler_email_id
    FOR EACH ROW EXECUTE FUNCTION wholesaler_email_exists();
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


------------------------------------------TRIGGER DURING WHOLESALER ENTERS QUANTITY LESS THAN 2000---------------------------------------------------

CREATE FUNCTION quantity_check()
RETURNS TRIGGER AS $$
BEGIN 
    IF NEW.med_quantity < 2000 THEN
        RAISE EXCEPTION 'med quantity should be greater than equal to 2000';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enforce_quantity_check_on_w_inventory
BEFORE INSERT OR UPDATE ON wholesaler_inventory
    FOR EACH ROW EXECUTE FUNCTION quantity_check();
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--TRIGGERS THAT WILL ONLY UPDATE THE STOCK AND WON'T THROW ANY EXCEPTION
------------------------------------------TRIGGER TO UPDATE WHOLESALER NUMBER OF TRANSACTION---------------------------------------------------
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

CREATE TRIGGER _w_num_of_transactions
AFTER INSERT OR UPDATE ON transactions
    FOR EACH ROW EXECUTE FUNCTION w_transactions();

------------------------------------------TRIGGER TO UPDATE RETAILER NUMBER OF TRANSACTIONS---------------------------------------------------
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

CREATE TRIGGER _ret_num_of_transactions
AFTER INSERT OR UPDATE ON transactions
    FOR EACH ROW EXECUTE FUNCTION ret_transactions();

