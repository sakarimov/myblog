# Analisa Penjualan Pakaian dengan NumPy

## Skenario

Perusahaan Anda bergerak di bidang retail pakaian dan ingin menganalisa data penjualan untuk berbagai kategori produk (contoh: kemeja, celana, sepatu) dan ukuran (S, M, L, XL) di berbagai lokasi (toko). Data penjualan disimpan dalam array NumPy bernama ```sales_data``` dengan struktur berikut (data dalam struktur hanya contoh):

```python
sales_data = np.array([
[[10, 35, 15, 20],  # Penjualan Lokasi 1
 [25, 35, 30, 18],
 [25, 35, 30, 18],
 [25, 35, 30, 18],
 [25, 35, 30, 18],
 [25, 35, 30, 18],
 [5,  35, 8, 12]],

[[12, 35, 18, 15],  # Penjualan Lokasi 2
 [22, 35, 28, 20],
 [22, 35, 28, 20],
 [22, 35, 28, 20],
 [22, 35, 28, 20],
 [22, 35, 28, 20],
 [7,  35, 9, 11]]
])

sales_data.shape = (jumlah_lokasi, jumlah_kategori, jumlah_ukuran)
```

```{note}
file tugas bisa didownload [di sini](https://github.com/sakarimov/my-personal-blog/raw/main/mybook/notes/numpy%231.txt)
```

## Tugas

1. **Identifikasi Kategori Penjualan Tertinggi menurut Lokasi (Slicing Lanjutan):**

    * Gunakan teknik slicing tingkat lanjut dalam NumPy untuk menghitung total penjualan untuk setiap kategori di semua ukuran di setiap lokasi.
    * Petunjuk: Anda dapat menggabungkan slicing dasar (`:`) untuk memilih lokasi tertentu dan masking boolean untuk menjumlahkan di sepanjang sumbu kategori.
    * Identifikasi kategori dengan penjualan tertinggi untuk setiap lokasi.

2. **Bandingkan Distribusi Ukuran untuk Kategori Spesifik:**

    * Fokus pada kategori tertentu (misalnya, kemeja) di semua lokasi.
    * Gunakan teknik slicing atau pengindeksan array untuk memilih hanya data penjualan kategori tersebut.
    * Hitung total penjualan untuk setiap ukuran (jumlahkan di sepanjang sumbu ukuran).
    * Analisa distribusi ukuran (misalnya, ukuran mana yang paling banyak terjual untuk kategori tersebut secara keseluruhan).

3. **Temukan Lokasi dengan Penjualan Rendah pada Ukuran Tertentu:**

    * Tentukan ukuran tertentu (misalnya, XL) yang mungkin perlu diisi ulang stoknya.
    * Gunakan masking boolean untuk memilih hanya data penjualan ukuran tersebut dari seluruh array.
    * Hitung total penjualan produk dengan ukuran tersebut di setiap lokasi (jumlahkan di sepanjang semua sumbu lainnya).
    * Identifikasi lokasi dengan penjualan di bawah ambang batas tertentu untuk produk dengan ukuran tersebut, yang menunjukkan potensi kebutuhan untuk mengisi ulang stok.
