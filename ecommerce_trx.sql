-- Dalam transaksi yang terjadi selama 2021, pada bulan apa total nilai transaksi (after_discount) paling besar? 
-- Gunakan is_valid = 1 untuk memfilter data transaksi.

SELECT EXTRACT(MONTH FROM order_date) AS bulan,
       SUM(after_discount) AS total_trx
FROM mentoring.order_detail
WHERE is_valid = 1
AND EXTRACT(YEAR FROM order_date) = 2021
GROUP BY bulan
ORDER BY total_trx DESC
LIMIT 1;

-- Selama transaksi pada tahun 2022, kategori apa yang menghasilkan nilai transaksi paling besar? 
-- Gunakan is_valid = 1 untuk memfilter data transaksi.

SELECT sd.category,
       SUM(od.after_discount) AS total_trx
FROM mentoring.order_detail AS od
LEFT JOIN mentoring.sku_detail AS sd
ON od.sku_id = sd.id
WHERE od.is_valid = 1
AND EXTRACT(YEAR FROM od.order_date) = 2022
GROUP BY sd.category
ORDER BY total_trx DESC
LIMIT 1;

-- Bandingkan nilai transaksi dari masing-masing kategori pada tahun 2021 dengan 2022.
-- Sebutkan kategori apa saja yang mengalami peningkatan dan kategori apa yang mengalami penurunan nilai transaksi 
-- dari tahun 2021 ke 2022. 
-- Gunakan is_valid = 1 untuk memfilter data transaksi.

SELECT sd.category,
       SUM(CASE WHEN EXTRACT(YEAR FROM od.order_date) = 2021 THEN after_discount END) AS trx_2021,
       SUM(CASE WHEN EXTRACT(YEAR FROM od.order_date) = 2022 THEN after_discount END) AS trx_2022,
       SUM(CASE WHEN EXTRACT(YEAR FROM od.order_date) = 2022 THEN after_discount END) -
       SUM(CASE WHEN EXTRACT(YEAR FROM od.order_date) = 2021 THEN after_discount END) AS growth
FROM mentoring.order_detail AS od
LEFT JOIN mentoring.sku_detail AS sd
ON od.sku_id = sd.id
WHERE od.is_valid = 1
GROUP BY sd.category
ORDER BY growth;

SELECT *,
       trx_2022 - trx_2021 AS growth,
       case when trx_2022 - trx_2021 < 0 THEN 'Penurunan' ELSE 'Peningkatan' END AS description
FROM (
        SELECT sd.category,
              SUM(CASE WHEN EXTRACT(YEAR FROM od.order_date) = 2021 THEN after_discount END) AS trx_2021,
              SUM(CASE WHEN EXTRACT(YEAR FROM od.order_date) = 2022 THEN after_discount END) AS trx_2022
        FROM mentoring.order_detail AS od
        LEFT JOIN mentoring.sku_detail AS sd
        ON od.sku_id = sd.id
        WHERE od.is_valid = 1
        GROUP BY sd.category
     ) trx
ORDER BY growth;

WITH trx AS 
      (
        SELECT sd.category,
              SUM(CASE WHEN EXTRACT(YEAR FROM od.order_date) = 2021 THEN after_discount END) AS trx_2021,
              SUM(CASE WHEN EXTRACT(YEAR FROM od.order_date) = 2022 THEN after_discount END) AS trx_2022
        FROM mentoring.order_detail AS od
        LEFT JOIN mentoring.sku_detail AS sd
        ON od.sku_id = sd.id
        WHERE od.is_valid = 1
        GROUP BY sd.category
     )
SELECT *,
       trx_2022 - trx_2021 AS growth,
       case when trx_2022 - trx_2021 < 0 THEN 'Penurunan' ELSE 'Peningkatan' END AS description
FROM trx
ORDER BY growth;

-- Tampilkan top 5 metode pembayaran yang paling populer digunakan selama 2022 (berdasarkan total unique order). 
-- Gunakan is_valid = 1 untuk memfilter data transaksi.

SELECT pd.payment_method,
       COUNT(distinct od.id) AS total_unique_order
FROM mentoring.order_detail AS od
LEFT JOIN mentoring.payment_detail AS pd
ON od.payment_id = pd.id
WHERE od.is_valid = 1
AND EXTRACT(YEAR FROM od.order_date) = 2022
GROUP BY pd.payment_method
ORDER BY total_unique_order DESC
LIMIT 5;

-- Q: Urutkan dari ke-5 produk ini berdasarkan nilai transaksinya.
-- 1. Samsung
-- 2. Apple
-- 3. Sony
-- 4. Huawei
-- 5. Lenovo
-- Gunakan is_valid = 1 untuk memfilter data transaksi.

SELECT *
FROM (
        SELECT CASE 
                  WHEN lower(sd.sku_name) LIKE '%samsung%' THEN 'Samsung'
                  WHEN lower(sd.sku_name) LIKE '%sony%' THEN 'Sony'
                  WHEN lower(sd.sku_name) LIKE '%huawei%' THEN 'Huawei'
                  WHEN lower(sd.sku_name) LIKE '%lenovo%' THEN 'Lenovo' 
                  WHEN lower(sd.sku_name) LIKE '%apple%' THEN 'Apple'
                  WHEN lower(sd.sku_name) LIKE '%iphone%' THEN 'Apple'
                  WHEN lower(sd.sku_name) LIKE '%imac%' THEN 'Apple'
                  WHEN lower(sd.sku_name) LIKE '%macbook%' THEN 'Apple'
                  ELSE 'Others'
                END AS brand,
              SUM(od.after_discount) AS total_trx
        FROM mentoring.order_detail AS od
        LEFT JOIN mentoring.sku_detail AS sd
        ON od.sku_id = sd.id
        WHERE od.is_valid = 1
        GROUP BY brand
      ) AS trx
WHERE brand <> 'Others'
ORDER BY total_trx DESC;