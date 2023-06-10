-- Create database
CREATE DATABASE learn_userSeller

-- Open database
\c learn_userSeller

-- Create table 
-- One to one
CREATE TABLE user(
    id_user INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    contact INT NOT NULL,
    addres VARCHAR(255) NOT NULL
);

CREATE TABLE user_bank(
    id_bankAccount INT PRIMARY KEY,
    payment_type ENUM ('debit', 'credit'),
    provider VARCHAR (255) NOT NULL,
    account_num INT NOT NULL,
    expired DATE NOT NULL,
    id_user INT,
    FOREIGN KEY(id_user) REFERENCES user(id_user),
);

-- One to many
CREATE TABLE seller(
    id_seller INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    contact INT NOT NULL,
    addres VARCHAR(255) NOT NULL
);

CREATE TABLE product(
    id_product INT PRIMARY KEY,
    product_name VARCHAR (255) NOT NULL,
    price INT NOT NULL,
    expired DATE NOT NULL,
    id_seller INT,
    FOREIGN KEY(id_seller) REFERENCES seller(id_seller)
);

-- Many to many
CREATE TABLE user(
    id_user INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    contact VARCHAR(255) NOT NULL,
    addres VARCHAR(255) NOT NULL
); -- sudah dalam keadaan di input di atas

CREATE TABLE order(
    id_order INT PRIMARY KEY,
    id_user INT,
    id_product INT ,
    order_date DATE NOT NULL,
    FOREIGN KEY(id_user) REFERENCES user(id_user)
    FOREIGN KEY(id_product) REFERENCES product(id_product)
);

CREATE TABLE product(
    id_product INT PRIMARY KEY,
    product_name VARCHAR (255) NOT NULL,
    price INT NOT NULL,
    expired DATE NOT NULL,
    id_seller INT,
    FOREIGN KEY(id_seller) REFERENCES user(id_seller)
); -- sudah dalam keadaan di input di atas

-- Insert data ke dalam table

INSERT INTO user(id_user, name, email, password, contact, addres) 
VALUES (1, 'ucup', 'ucup@gmail.com', 'ucup255', 0819097123, 'Jl. Sudirman Blok A No. 21'),
(2, 'tulus', 'tulus@gmail.com', '123tulus', 0819097321, 'Jl. Pancoran Blok R No. 34'),
(3, 'john wick', 'wickj@gmail.com', 'wick4', 0819090909, 'Jl. Lenteng Agung Blok Z No. 01');

INSERT INTO user_bank(id_bankAccount, payment_type, provider, account_num, expired, id_user) 
VALUES (1, 'debit', 'BRI', 7162534, '2024-06-01 23:59:59', 1),
(2, 'credit', 'BCA', 8273654, '2025-01-10 23:59:59', 2),
(3, 'credit', 'Mandiri', 9345876, '2025-02-05 23:59:59', 3);

INSERT INTO seller(id_seller, name, email, password, contact, addres) 
VALUES (1, 'Chairul Tanjung', 'chairtj@gmail.com', 'carefour321', 0819099876, 'Jl. Durian Blok W No. 99');

INSERT INTO product(id_product, product_name, price, expired, id_seller) 
VALUES (1, 'sosis kanzler', 40000, '2023-12-23 23:59:59', 1),
(2, 'sosis so nice', 25000, '2024-02-15 23:59:59', 1),
(3, 'nugget fiesta', 60000, '2023-11-13 23:59:59', 1),
(4, 'nugget champion', 30000, '2024-01-22 23:59:59', 1);

INSERT INTO order(id_order, id_user, id_product, order_date,) 
VALUES (1, 1, 2, '2023-06-11 10:52:59'),
(2, 1, 4, '2023-06-11 10:52:59'),
(3, 3, 1, '2023-06-12 13:43:10'),
(4, 2, 3, '2023-06-12 14:02:33'),
(5, 2, 4, '2023-06-12 14:02:33');

-- Menampilkan table many to many
SELECT order.*, user.name AS buyer_name, user.contact, user.addres, product.product_name, product.price, FROM order INNER JOIN user ON order.id_user = user.id_user INNER JOIN product ON order.id_product = product.id_product;
