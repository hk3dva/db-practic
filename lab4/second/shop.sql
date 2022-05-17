DROP database shop;

CREATE DATABASE  IF NOT EXISTS shop 
    CHARACTER SET utf8 
    COLLATE utf8_unicode_ci;

USE shop;

CREATE TABLE IF NOT EXISTS warehouse (
    id_warehouse INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    number INT NULL,
    type VARCHAR(255) NULL,
    address VARCHAR(255) NULL,
    area INT NULL
) AUTO_INCREMENT=0;

CREATE TABLE IF NOT EXISTS employee (
    id_employee INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age TINYINT NOT NULL,
    post VARCHAR(255) NULL,
    wages BIGINT NOT NULL,
    id_warehouse INT NOT NULL,
    FOREIGN KEY (id_warehouse) REFERENCES warehouse (id_warehouse)
);

CREATE TABLE IF NOT EXISTS invoice (
    id_invoice INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    number INT NOT NULL,
    extradition DATE NOT NULL,
    sender VARCHAR(255) NULL,
    recipient VARCHAR(255) NULL,
    id_warehouse INT NOT NULL,
    FOREIGN KEY (id_warehouse) REFERENCES warehouse (id_warehouse)
);

CREATE TABLE IF NOT EXISTS product (
    id_product INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    width INT NOT NULL,
    height INT NOT NULL,
    weight INT NOT NULL
);

CREATE TABLE IF NOT EXISTS goods_in_invoice (
    id_goods_in_invoice INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    number INT NOT NULL,
    price INT NOT NULL,
    quantity INT NOT NULL,
    id_product INT NOT NULL,
    id_invoice INT NOT NULL,
    FOREIGN KEY (id_product) REFERENCES product (id_product),
    FOREIGN KEY (id_invoice) REFERENCES invoice (id_invoice)
);