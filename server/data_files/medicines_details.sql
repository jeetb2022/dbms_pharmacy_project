CREATE TABLE medicine_details(
    med_id BIGSERIAL NOT NULL PRIMARY KEY,
    med_category VARCHAR(50) NOT NULL,
    med_name VARCHAR(50) NOT NULL,
    med_price INT NOT NULL,
    med_quantity INT NOT NULL,
    w_id INT NOT NULL,
    w_shop_address VARCHAR(50) NOT NULL,
    FOREIGN KEY (w_id) REFERENCES wholesaler_details(w_id)
);


