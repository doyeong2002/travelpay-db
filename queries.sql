USE TravelPayDB;

SET @user_id = 1;
SET @card_id = 301;
SET @since_date = '2026-05-01';
SET @merchant = '예시식당';
SET @expiry_cutoff = '2028-12-31';

-- Q1. 특정 사용자의 원화 계좌 잔액
SELECT bank_name, account_num, balance
FROM Accounts
WHERE user_id = @user_id;

-- Q2. 특정 사용자의 통화별 지갑 잔액
SELECT U.user_name, W.currency_code, W.foreign_balance
FROM Users U
JOIN Wallets W ON U.user_id = W.user_id
WHERE U.user_id = @user_id;

-- Q3. 특정 카드의 지정 날짜 이후 거래
SELECT C.card_last4, T.tx_type, T.amount, T.tx_date, T.merchant
FROM TravelCards C
JOIN Transactions T ON C.card_id = T.card_id
WHERE C.card_id = @card_id AND T.tx_date >= @since_date;

-- Q4. 특정 사용자의 통화별 결제·출금 누적 금액
SELECT W.currency_code, SUM(T.amount) AS total_spent
FROM Users U
JOIN Wallets W ON U.user_id = W.user_id
JOIN Transactions T ON W.wallet_id = T.wallet_id
WHERE U.user_id = @user_id
  AND T.tx_type IN ('PAYMENT', 'ATM_WITHDRAWAL')
GROUP BY W.currency_code;

-- Q5. 특정 가맹점의 결제 건수와 금액
SELECT merchant, COUNT(transaction_id) AS tx_count, SUM(amount) AS total_sales
FROM Transactions
WHERE merchant = @merchant AND tx_type = 'PAYMENT'
GROUP BY merchant;

-- Q6. 지정 날짜까지 만료되는 카드와 사용자 연락처
SELECT U.user_name, U.phone, C.card_last4, C.expiry_date
FROM Users U
JOIN TravelCards C ON U.user_id = C.user_id
WHERE C.expiry_date <= @expiry_cutoff;
