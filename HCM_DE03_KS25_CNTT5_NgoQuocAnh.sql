CREATE DATABASE IF NOT EXISTS MechKeyStore;

USE MechKeyStore;

DROP TABLE IF EXISTS  Order_Detail;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Product;

CREATE TABLE Product (
    product_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    unit_price DECIMAL(15 , 2 ) NOT NULL,
    stock_qty INT NOT NULL DEFAULT 0
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(500) NULL
);

CREATE TABLE Orders (
    order_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_price DECIMAL(15 , 2 ) NOT NULL DEFAULT 0,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id)
        REFERENCES Customer (customer_id)
);
CREATE TABLE Order_Detail (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    sale_price DECIMAL(15 , 2 ) NOT NULL,
    PRIMARY KEY (order_id , product_id),
    FOREIGN KEY (order_id)
        REFERENCES Orders (order_id),
    FOREIGN KEY (product_id)
        REFERENCES Product (product_id)
);

ALTER TABLE Product
    ADD COLUMN category VARCHAR(100) NULL;

ALTER TABLE Product
    CHANGE COLUMN brand manufacturer VARCHAR(100) NOT NULL;

INSERT INTO Product (product_name, manufacturer, unit_price, stock_qty, category) VALUES
('Aula F1 Keyboard',          'Aula',      1000000,   25, 'Keyboard'),
('Aula F2 TKL Keyboard',        'Aula',     20000000,   18, 'Keyboard'),
('Samira F1 PRO Keyboard',     'Master Yi', 30000000,   12, 'Keyboard'),
('Mixi Pro',          'Fiora',     1200000,    8, 'Keyboard'),
('Mixi F1 Pro',   'Meepsie',   5000000,   36, 'Switch');

INSERT INTO Customer (full_name, email, phone, address) VALUES
('Nguyen Van A',   'nguyenvana@gmail.com',   '0901234567', 'Q1, TP.HCM'),
('Tran Thi B',   'tranthib@gmail.com',   '0912345678', 'Q2, TP.HCM'),
('Le Minh C',   'leminhc@gmail.com',   '0923456789', 'Q3, TP.HCM'),
('Pham Thi D',   'phamthid@gmail.com',   '0934567890', NULL),
('Hoang Van E',  'hoangquoce@gmail.com',  '0945678901', 'Q4, TP.HCM');

INSERT INTO Orders (customer_id, order_date, total_price) VALUES
(1, '2026-04-05',  2500000),
(2, '2026-04-10',  5350000),
(3, '2026-04-15',  3500000),
(5, '2026-04-20',  1200000),
(4, '2026-03-28',  4050000),
(5, '2026-04-25',  7700000),
(3, '2026-05-01',   850000);

INSERT INTO Order_Detail (order_id, product_id, quantity, sale_price) VALUES
(1, 3, 1, 2500000),
(2, 4, 1, 1800000),
(2, 7, 1, 3500000),
(3, 7, 1, 3500000),
(4, 2, 1, 1200000),
(5, 4, 1, 1800000),
(5, 5, 1,  350000),
(5, 6, 1,  420000),
(5, 8, 2,  650000);

SET SQL_SAFE_UPDATES = 0;

UPDATE Product
SET    unit_price = unit_price * 1.1
WHERE  manufacturer = 'Aula';

DELETE FROM Customer
WHERE address IS NULL;

SET SQL_SAFE_UPDATES = 1;

SELECT product_id,
       product_name,
       manufacturer,
       unit_price,
       category
FROM   Product
WHERE  unit_price BETWEEN 1000000 AND 3000000;

SELECT o.order_id,
       c.full_name   AS customer_name,
       o.order_date,
       o.total_price
FROM   Orders   o
JOIN   Customer c ON c.customer_id = o.customer_id
WHERE  MONTH(o.order_date) = 4
  AND  YEAR(o.order_date)  = 2026;

SELECT product_id,
       product_name,
       manufacturer,
       unit_price,
       stock_qty,
       category
FROM   Product
WHERE  product_name LIKE '%Aula%';

SELECT o.customer_id,
       c.full_name,
       o.order_id,
       o.total_price
FROM   Orders   o
JOIN   Customer c ON c.customer_id = o.customer_id
WHERE  o.total_price > 5000000;

SELECT product_id,
       product_name,
       manufacturer,
       category,
       unit_price,
       stock_qty
FROM   Product
WHERE  stock_qty < 10;