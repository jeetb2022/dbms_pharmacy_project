CREATE TRIGGER medicine_quantity_trigger 
BEFORE INSERT ON wholesaler_inventory
FOR EACH ROW EXECUTE PROCEDURE check_medicine_bounds();
