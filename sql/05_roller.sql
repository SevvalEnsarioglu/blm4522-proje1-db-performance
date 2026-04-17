-- ROL VE YETKİ YÖNETİMİ
-- Sadece okuma yetkisi olan analist
CREATE ROLE analist LOGIN PASSWORD 'analist123';
GRANT CONNECT ON DATABASE dvdrental TO analist;
GRANT USAGE ON SCHEMA public TO analist;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO analist;

-- Veri girebilen operatör
CREATE ROLE operatör LOGIN PASSWORD 'operator123';
GRANT CONNECT ON DATABASE dvdrental TO operatör;
GRANT USAGE ON SCHEMA public TO operatör;
GRANT SELECT, INSERT, UPDATE ON payment, rental TO operatör;

-- Tam yetkili yönetici
CREATE ROLE veri_yoneticisi LOGIN PASSWORD 'yonetici123';
GRANT ALL PRIVILEGES ON DATABASE dvdrental TO veri_yoneticisi;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO veri_yoneticisi;