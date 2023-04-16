create or replace table transactions(
    order_id BIGSERIAL NOT NULL PRIMARY KEY,
    cart_id INT NOT NULL,
    ret_id INT NOT NULL,
    ret_shopname VARCHAR(50) NOT NULL,
    w_id INT NOT NULL,
    w_shopname VARCHAR(50) NOT NULL,
    total_amount INT NOT NULL,
    order_date TIMESTAMP,
    FOREIGN KEY (ret_id) REFERENCES retailer_details(ret_id),
    FOREIGN KEY (w_id) REFERENCES wholesaler_details(w_id)
)