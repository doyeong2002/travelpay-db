CREATE DATABASE IF NOT EXISTS TravelPayDB;
USE TravelPayDB;

CREATE TABLE IF NOT EXISTS Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Accounts (
    account_id INT PRIMARY KEY,
    bank_name VARCHAR(30) NOT NULL,
    account_num VARCHAR(50) NOT NULL,
    balance INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE IF NOT EXISTS Wallets (
    wallet_id INT PRIMARY KEY,
    currency_code VARCHAR(10) NOT NULL,
    foreign_balance DECIMAL(15, 2) NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CHECK (foreign_balance >= 0)
);

CREATE TABLE IF NOT EXISTS TravelCards (
    card_id INT PRIMARY KEY,
    card_last4 CHAR(4) NOT NULL,
    expiry_date DATE NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT PRIMARY KEY,
    tx_type VARCHAR(20) NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    tx_date DATETIME NOT NULL,
    merchant VARCHAR(50),
    wallet_id INT NOT NULL,
    card_id INT,
    FOREIGN KEY (wallet_id) REFERENCES Wallets(wallet_id),
    FOREIGN KEY (card_id) REFERENCES TravelCards(card_id),
    CHECK (amount > 0)
);
