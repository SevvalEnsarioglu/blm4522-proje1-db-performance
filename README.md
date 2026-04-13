# BLM4522 — Proje 1: Veritabanı Performans Optimizasyonu ve İzleme

> 22290742 - ŞEVVAL ENSARİOĞLU    
> **Video Linki:** (Çekildiğinde eklenecektir...)       

---

## 📌 Proje Hakkında

Bu projede büyük bir PostgreSQL veritabanı üzerinde performans analizi yapılmış ve optimizasyon teknikleri uygulanmıştır. Proje kapsamında aşağıdaki konular ele alınmaktadır:

- Veritabanı izleme ve hata tespiti
- İndeks yönetimi (oluşturma, analiz, kaldırma)
- Sorgu optimizasyonu (EXPLAIN ANALYZE)
- Veri yöneticisi rolleri ve erişim kontrolü

---

## 🛠️ Kullanılan Araçlar

| Araç | Sürüm | Açıklama |
|------|-------|----------|
| PostgreSQL | 17 | Ana veritabanı sistemi |
| DBeaver | 25.2.4 | Veritabanı yönetim arayüzü |
| pg_stat_statements | — | Sorgu istatistikleri modülü |
| DVD Rental DB | — | Örnek veritabanı |

---

## 📂 Proje Yapısı

```
blm4522-proje1-db-performance/
│
├── README.md               # Bu dosya
├── rapor/
│   └── rapor.pdf           # Proje raporu
├── sql/
│   ├── 01_izleme.sql       # İzleme sorguları
│   ├── 02_explain.sql      # EXPLAIN ANALYZE sorguları
│   ├── 03_indexler.sql     # İndeks yönetimi
│   ├── 04_optimizasyon.sql # Sorgu optimizasyonu
│   └── 05_roller.sql       # Rol ve yetki yönetimi
└── ekran_goruntuleri/
    ├── izleme/
    ├── indexler/
    └── roller/
```

---

## 🔍 Yapılan Çalışmalar

### 1. Veritabanı İzleme
PostgreSQL'de MSSQL'deki Dynamic Management Views (DMV) karşılığı olarak `pg_stat_activity` ve `pg_stat_user_tables` sistem görünümleri kullanılmıştır. `pg_stat_statements` extension'ı aktif edilerek sorgu istatistikleri toplanmıştır.

```sql
-- Aktif bağlantıların izlenmesi
SELECT pid, usename, state, query
FROM pg_stat_activity
WHERE state != 'idle';

-- Tablo boyutları
SELECT relname AS tablo,
       pg_size_pretty(pg_total_relation_size(relid)) AS boyut
FROM pg_stat_user_tables
ORDER BY pg_total_relation_size(relid) DESC;
```

### 2. İndeks Yönetimi
Mevcut indeksler analiz edilmiş, eksik indeksler oluşturulmuş ve gereksiz indeksler tespit edilmiştir.

```sql
-- İndeks oluşturma
CREATE INDEX idx_payment_date ON payment(payment_date);
CREATE INDEX idx_film_rental_rate ON film(rental_rate);

-- Kullanılmayan indekslerin tespiti
SELECT relname, indexrelname, idx_scan
FROM pg_stat_user_indexes
WHERE idx_scan = 0;
```

### 3. Sorgu Optimizasyonu
`EXPLAIN ANALYZE` komutu ile sorgu planları incelenmiş, `Seq Scan` yerine `Index Scan` kullanımı sağlanmıştır.

| Ölçüm | İndeks Öncesi | İndeks Sonrası |
|-------|--------------|----------------|
| Execution Time | — ms | — ms |
| Scan Türü | Seq Scan | Index Scan |

### 4. Veri Yöneticisi Rolleri
Üç farklı düzeyde kullanıcı rolü oluşturulmuş ve yetki yönetimi yapılmıştır.

| Rol | Yetki |
|-----|-------|
| `analist` | Sadece SELECT |
| `operatör` | SELECT, INSERT, UPDATE |
| `veri_yoneticisi` | Tam yetki |

---

## 📊 Veritabanı Şeması

DVD Rental veritabanı 15 tablodan oluşmaktadır:

`actor` · `address` · `category` · `city` · `country` · `customer` · `film` · `film_actor` · `film_category` · `inventory` · `language` · `payment` · `rental` · `staff` · `store`

---


