USE TravelPayDB;

INSERT INTO Users (user_id, user_name, email, phone) VALUES
(1, '사용자A', 'user-a@example.com', '010-0000-0001'),
(2, '사용자B', 'user-b@example.com', '010-0000-0002');

INSERT INTO Accounts (account_id, bank_name, account_num, balance, user_id) VALUES
(101, '예시은행', 'TEST-ACCOUNT-001', 500000, 1),
(102, '예시은행', 'TEST-ACCOUNT-002', 1500000, 2);

INSERT INTO Wallets (wallet_id, currency_code, foreign_balance, user_id) VALUES
(201, 'JPY', 50000.00, 1),
(202, 'USD', 250.50, 1),
(203, 'JPY', 10000.00, 2);

INSERT INTO TravelCards (card_id, card_last4, expiry_date, user_id) VALUES
(301, '0001', '2028-12-31', 1),
(302, '0002', '2027-05-31', 2);

INSERT INTO Transactions (transaction_id, tx_type, amount, tx_date, merchant, wallet_id, card_id) VALUES
(401, 'PAYMENT', 1500.00, '2026-05-15 12:30:00', '예시식당', 201, 301),
(402, 'ATM_WITHDRAWAL', 10000.00, '2026-05-16 09:00:00', '예시ATM', 201, 301),
(403, 'EXCHANGE', 50.00, '2026-05-20 15:00:00', NULL, 202, NULL);
