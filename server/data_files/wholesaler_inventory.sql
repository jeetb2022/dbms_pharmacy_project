CREATE TABLE wholesaler_inventory(
    inventory_id BIGSERIAL NOT NULL PRIMARY KEY,
    w_id INT NOT NULL,
    w_shopname VARCHAR(50) NOT NULL,
    med_category VARCHAR(50) NOT NULL,
    med_name VARCHAR(50) NOT NULL,
    med_price INT NOT NULL,
    med_quantity INT NOT NULL,
    FOREIGN KEY (w_id) REFERENCES wholesaler_details(w_id)
);

