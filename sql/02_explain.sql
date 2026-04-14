-- Önce indexsiz sorguyu çalıştıralım, süreyi not alalım
EXPLAIN analyze SELECT * FROM payment WHERE payment_date > '2007-01-01';

-- Aynı sorguyu tekrar çalıştıralım, süreyi karşılaştıralım
EXPLAIN analyze SELECT * FROM payment WHERE payment_date > '2007-01-01';
