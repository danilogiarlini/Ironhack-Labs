USE bank;
# Query 1
SELECT * FROM client
WHERE district_id = 1
LIMIT 5

# Query 2
SELECT max(client_id) FROM client.   #Selected the max value of the column that respect the WHERE
WHERE district_id = 72
ORDER BY client_id
LIMIT 1;

# Query 3
SELECT * FROM loan
ORDER BY amount
LIMIT 3;

# Query 4
SELECT DISTINCT status FROM loan
ORDER BY status;

# Query 5
SELECT * FROM loan
ORDER BY payments DESC
LIMIT 1;

# Query 6: What is the loan amount of the lowest 5 account_ids in the loan table? Show the account_id and the corresponding amount
SELECT account_id, amount FROM loan
ORDER BY account_id
LIMIT 5;

# Query 7: What are the top 5 account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?
SELECT account_id FROM loan
WHERE duration = 60
ORDER BY amount
LIMIT 5;

# Query 8: What are the unique values of k_symbol in the order table?
# Note: There shouldn't be a table name order, since order is reserved from the ORDER BY clause.
# You have to use backticks to escape the order table name.
select DISTINCT k_symbol from bank.order;

# Query 9: In the order table, what are the order_ids of the client with the account_id 34?
select order_id from bank.order
where account_id = 34;

# Query 10: In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?
select distinct account_id from bank.order
where order_id between 29540 and 29560;

# Query 11: In the order table, what are the individual amounts that were sent to (account_to) id 30067122?
select amount from bank.order
where account_to = 30067122;

# Query 12: In the trans table, 
# show the trans_id, date, type and amount of the 10 first transactions
# from account_id 793 in chronological order, from newest to oldest.
select trans_id, date, type, amount from trans
where account_id = 793
order by date desc
limit 10;

# Query 13: In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id?
# Show the results sorted by the district_id in ascending order.
select district_id, count(district_id) from client
where district_id < 10
group by district_id
order by district_id asc;

# Query 14: In the card table, how many cards exist for each type? Rank the result starting with the most frequent type.
select type, count(type) from card
group by type
order by count(type) desc

# Query 15: Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.
select account_id, sum(amount) from loan
group by account_id
order by sum(amount) desc
limit 10;

# Query 16: In the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order.
select date, count(date) from loan
where date < 930907
group by date
order by date desc;

# Query 17: In the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration,
# ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.
select date, duration, count('date') from loan
where 'date' like '9712%'
order by date, duration asc;

# Query 18: In the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming).
# Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type.
select account_id, type, sum(amount) from trans
where account_id = 396
group by type

# Query 19: From the previous output, translate the values for type to English,
# rename the column to transaction_type, round total_amount down to an integer
select account_id,
case
    when `type` = 'prijem' then 'Ingoing'
    when `type` = 'vydaj' then 'Outgoing'
    end as transaction_type,
floor(sum(amount)) as total_amount
from bank.trans
where account_id = 396
group by `type`;

# Query 20: From the previous result, modify your query so that it returns only one row,
# with a column for incoming amount, outgoing amount and the difference.
select account_id,
case
    when `type` = 'prijem' then 'Ingoing'
    when `type` = 'vydaj' then 'Outgoing'
    end as transaction_type,
floor(sum(amount)) as total_amount
from bank.trans
where account_id = 396
group by `type`;


