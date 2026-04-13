SELECT tablename, indexname, indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename;

-- Önce indexsiz sorguyu çalıştıralım, süreyi not alalım
EXPLAIN analyze SELECT * FROM payment WHERE payment_date > '2007-01-01';
-- Index ekleyelim
CREATE INDEX idx_payment_date ON payment(payment_date);
-- Aynı sorguyu tekrar çalıştıralım, süreyi karşılaştıralım
EXPLAIN analyze SELECT * FROM payment WHERE payment_date > '2007-01-01';
-- Gereksiz indexleri tespit edelim ve kaldıralım
SELECT s.relname AS tablo,
       s.indexrelname AS index_adi,
       s.idx_scan AS kullanim_sayisi
FROM pg_stat_user_indexes s
WHERE s.idx_scan = 0;