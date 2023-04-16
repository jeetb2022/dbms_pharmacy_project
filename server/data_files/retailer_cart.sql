CREATE TABLE retailer_cart(
    cart_id BIGSERIAL NOT NULL PRIMARY KEY,
    ret_id INT NOT NULL,
    w_id INT NOT NULL,
    ret_shopname VARCHAR(50) NOT NULL,
    w_shopname VARCHAR(50) NOT NULL,
    med_name VARCHAR(50) NOT NULL,
    med_id INT NOT NULL, 
    med_quantity INT NOT NULL,
    price INT NOT NULL,
    FOREIGN KEY (ret_id) REFERENCES retailer_details(ret_id),
    FOREIGN KEY (w_id) REFERENCES wholesaler_details(w_id),
    FOREIGN KEY (med_id) REFERENCES medicine_stock(w_id)
)



