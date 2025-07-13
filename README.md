# ecommerce-transaction-analysis 

### Project Overview
Final project ini merupakan hasil analisis data transaksi e-commerce (data simulasi Tokopedia) yang dilakukan untuk menjawab pertanyaan bisnis menggunakan SQL, Python, dan Looker Studio. Proyek ini bertujuan untuk mengidentifikasi pola penjualan, tren performa kategori produk, serta efektivitas campaign marketing selama tahun 2021–2022.

### Dataset
Analisis ini menggunakan data simulasi transaksi e-commerce Tokopedia yang terdiri dari 4 tabel utama:
1. order_detail: Berisi informasi transaksi seperti tanggal, SKU, harga, dan status valid
2. sku_detail: Berisi detail produk: nama, kategori, harga pokok (COGS), dan harga jual
3. customer_detail: Berisi informasi pelanggan seperti ID dan tanggal registrasi
4. payment_detail: Berisi metode pembayaran yang digunakan dalam setiap transaksi

### Tools 
| Tools            | Fungsi Utama                                                                 |
|------------------|------------------------------------------------------------------------------|
| **SQL (BigQuery)**    | Data cleaning, transformasi, join tabel, agregasi, analisis tren dan perbandingan |
| **Python (Colab)**     | Data wrangling, manipulasi, visualisasi grafik, dan analisis statistik        |
| **Looker Studio**     | Pembuatan dashboard interaktif, KPI monitoring, dan pengambilan keputusan       |

### SQL 
Saya menggunakan SQL di BigQuery untuk menjawab berbagai pertanyaan analisis, di antaranya:
1. Bulan dengan nilai transaksi tertinggi tahun 2021
2. Kategori dengan penjualan tertinggi tahun 2022
3. Perbandingan performa kategori dari tahun 2021 ke 2022 (peningkatan/penurunan)
4. Metode pembayaran paling populer tahun 2022
5. Urutan nilai transaksi dari merek: Samsung, Apple, Sony, Huawei, Lenovo

**Teknik SQL yang digunakan:**
- `JOIN` antara empat tabel: `order_detail`, `sku_detail`, `payment_detail`, dan `customer_detail`
- Agregasi dengan `SUM()`, `COUNT(DISTINCT ...)`, dan `ROUND()`
- `CASE WHEN` untuk klasifikasi merek
- `CTE` untuk perbandingan multiyear
- `GROUP BY`, `ORDER BY`, dan `LIMIT`

### Python
Saya menggunakan Python di Google Colab untuk preprocessing dan analisis lanjutan yang lebih fleksibel. Proses yang dilakukan:
- Mengimpor CSV ke dalam DataFrame menggunakan `pandas`
- Memuat data ke SQLite in-memory dan menjalankan SQL query di Colab (`sqlite3 + pandas.read_sql`)
- Menyambungkan dan menggabungkan 4 tabel melalui `LEFT JOIN`
- Melakukan pengecekan null values, tipe data, dan duplikasi

**Analisis yang Dilakukan:**
1. Top 5 Produk Kategori Mobile & Tablets Tahun 2022 berdasarkan kuantitas terjual
2. Perbandingan kuantitas penjualan kategori "Others" tahun 2021 vs 2022
3. 20 produk kategori Others dengan penurunan penjualan paling tinggi
4. Daftar pelanggan yang checkout tapi belum bayar di 2022 (gross order, unpaid)
5. Efektivitas campaign weekend vs weekday di Oktober–Desember 2022

**Visualisasi:**
- Horizontal bar chart (Top 5 SKU, Top 20 penurunan SKU)
- Perbandingan weekend vs weekday sales
- Growth chart dan heatmap insight (dengan `matplotlib` dan `seaborn`)

### Looker Studio
Saya membangun dashboard interaktif dua halaman berdasarkan hasil analisis SQL & Python, dengan koneksi data dari Google Sheets.

**Halaman 1: KPI & Tren Penjualan**
- Visualisasi: Combo chart antara **Value Sales**, **Net Profit**, dan **AOV**
- Filter interaktif: Date, Category, Payment Method, Valid/Invalid transaction
- Scorecard: Total Net Profit, AOV, Value Sales, dan Unique Customers

**Halaman 2: Fokus Produk & Pembayaran**
- Tabel dan grafik: Customer behavior, transaksi berdasarkan metode Payaxis
- Analisis AOV dan profit margin di bulan Juli 2022
- Insight loyalitas pelanggan & produk dengan transaksi tertinggi

**Insight Penting:**
- Puncak penjualan terjadi di bulan April & Juli 2022
- Net profit tetap kecil meskipun value sales tinggi → indikasi margin tipis
- Campaign weekend **kurang efektif**, weekdays lebih banyak menghasilkan transaksi

### File & Akses
- [SQL Queries](https://github.com/nisagusfatiha/ecommerce-transaction-analysis/blob/main/ecommerce_trx.sql)
- [Python Notebook](https://github.com/nisagusfatiha/ecommerce-transaction-analysis/blob/main/ecommerce_trx.ipynb)
- [Looker Studio Dashboard](https://lookerstudio.google.com/reporting/da6cbbae-1591-47ac-80d2-788291a9ae35)


📧 Email: nisagusfatiha.wrk@email.com  
🔗 LinkedIn: [linkedin.com/in/nisagusfatiha](www.linkedin.com/in/nisa-gusfatiha)  
