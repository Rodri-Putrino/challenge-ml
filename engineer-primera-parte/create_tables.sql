CREATE TABLE customer (
    id_customer INT PRIMARY KEY,
    email VARCHAR(100),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birthdate DATE,
    gender VARCHAR(10),
    address VARCHAR(100),
    phone VARCHAR(20),
    buyer_reputation INT,
    seller_reputation INT
);

CREATE TABLE category (
    id_category VARCHAR(10) PRIMARY KEY,
    id_parent_category VARCHAR(10),
    name VARCHAR(100),
    path VARCHAR(200),
    total_items_in_this_category INT,
    FOREIGN KEY (id_parent_category) REFERENCES category(id_category)
);

CREATE TABLE item (
    id_item VARCHAR(20) PRIMARY KEY,
	id_category VARCHAR(10),
    id_seller INT,
    name VARCHAR(100),
    description VARCHAR(200),
    initial_quantity INT,
    quantity_available INT,
    sold_quantity INT,
    price DECIMAL(10, 2),
    currency VARCHAR(10),
	status VARCHAR(50),
	creation_date DATE,
    last_modified_date DATE,
    end_date DATE,
    FOREIGN KEY (id_category) REFERENCES category(id_category),
    FOREIGN KEY (id_seller) REFERENCES customer(id_customer)
);

CREATE TABLE order (
    id_order INT PRIMARY KEY,
    id_buyer INT,
    id_seller INT,
    id_item VARCHAR(20),
    order_date DATE,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (id_buyer) REFERENCES customer(id_customer),
    FOREIGN KEY (id_seller) REFERENCES customer(id_customer),
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);

CREATE TABLE item_price_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_item VARCHAR(20),
    price DECIMAL(10, 2),
    status VARCHAR(50),
    populated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);