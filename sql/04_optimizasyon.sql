-- SORGU İYİLEŞTİRME
-- Önce bu yavaş sorguyu çalıştıralım
EXPLAIN ANALYZE
SELECT c.first_name, c.last_name, f.title, p.amount
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE f.rental_rate > 2.99
ORDER BY p.payment_date DESC;

-- Gerekli indexleri ekleyelim
CREATE INDEX idx_film_rental_rate ON film(rental_rate);
CREATE INDEX idx_rental_customer ON rental(customer_id);

-- Aynı sorguyu tekrar çalıştırıp execution time'ı karşılaştıralım
EXPLAIN ANALYZE
SELECT c.first_name, c.last_name, f.title, p.amount
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE f.rental_rate > 2.99
ORDER BY p.payment_date DESC;
