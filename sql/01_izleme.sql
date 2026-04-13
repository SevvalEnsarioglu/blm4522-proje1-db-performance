CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- VERİTABANI İZLEME
-- Tablo istatistiklerini inceleyelim
SELECT relname AS tablo,
       seq_scan AS sıralı_tarama,
       idx_scan AS index_tarama,
       n_live_tup AS satır_sayısı
FROM pg_stat_user_tables
ORDER BY seq_scan DESC;

-- Disk alanı kullanımını (disk alanı yönetimi maddesi için) inceleyelim
SELECT relname AS tablo,
       pg_size_pretty(pg_relation_size(relid)) AS tablo_boyutu,
       pg_size_pretty(pg_total_relation_size(relid)) AS toplam_boyut
FROM pg_stat_user_tables
ORDER BY pg_total_relation_size(relid) DESC;

-- Aktif bağlantıların izlenmesi
SELECT pid, usename, state, query
FROM pg_stat_activity
WHERE state != 'idle';
