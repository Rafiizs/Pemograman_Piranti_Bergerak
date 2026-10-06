import 'package:flutter/material.dart';

void main() {
  runApp(const MangaStoreApp());
}

// Widget utama aplikasi MangaStore menggunakan StatelessWidget.
class MangaStoreApp extends StatelessWidget {
  const MangaStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp digunakan sebagai wrapper utama aplikasi Flutter.
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ThemeData digunakan untuk mengatur tema visual aplikasi.
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      // Home menentukan halaman pertama yang ditampilkan.
      home: const HomePage(),
    );
  }
}

// HomePage merupakan halaman utama MangaStore.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold digunakan sebagai struktur dasar halaman.
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // SafeArea menjaga konten agar tidak tertutup area perangkat.
      body: SafeArea(
        // SingleChildScrollView membuat halaman dapat di-scroll.
        child: SingleChildScrollView(
          // Padding memberikan jarak antara isi halaman dengan tepi layar.
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

            // Column menyusun widget secara vertikal.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER

                // Row menyusun nama aplikasi dan icon secara horizontal.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Column menyusun nama toko dan deskripsi secara vertikal.
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text menampilkan nama aplikasi.
                        const Text(
                          'MangaStore',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // SizedBox memberikan jarak vertikal.
                        const SizedBox(height: 4),

                        // Text menampilkan deskripsi aplikasi.
                        Text(
                          'Toko Manga Online',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),

                    // Container digunakan sebagai background icon keranjang.
                    Container(
                      padding: const EdgeInsets.all(10),

                      // BoxDecoration mengatur warna dan bentuk Container.
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      // Icon menampilkan icon keranjang belanja.
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.deepPurple.shade700,
                        size: 25,
                      ),
                    ),
                  ],
                ),

                // SizedBox memberikan jarak antara header dan search.
                const SizedBox(height: 24),

                // SEARCH

                // TextField digunakan untuk input pencarian manga.
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari manga favoritmu...',

                    // Icon digunakan sebagai icon pencarian.
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),

                    filled: true,
                    fillColor: Colors.white,

                    // InputDecoration mengatur bentuk field pencarian.
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                // SizedBox memberikan jarak.
                const SizedBox(height: 25),

                // KATEGORI

                // Text menampilkan judul bagian kategori.
                const Text(
                  'Kategori',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // SizedBox memberikan jarak.
                const SizedBox(height: 12),

                // Row menyusun kategori secara horizontal.
                Row(
                  children: [
                    // Expanded membagi ruang kategori secara proporsional.
                    Expanded(child: categoryItem('Action', Icons.flash_on)),

                    // SizedBox memberikan jarak antar kategori.
                    const SizedBox(width: 8),

                    // Expanded membagi ruang kategori.
                    Expanded(child: categoryItem('Romance', Icons.favorite)),

                    // SizedBox memberikan jarak antar kategori.
                    const SizedBox(width: 8),

                    // Expanded membagi ruang kategori.
                    Expanded(
                      child: categoryItem('Comedy', Icons.sentiment_satisfied),
                    ),

                    // SizedBox memberikan jarak antar kategori.
                    const SizedBox(width: 8),

                    // Expanded membagi ruang kategori.
                    Expanded(
                      child: categoryItem('Fantasy', Icons.auto_awesome),
                    ),
                  ],
                ),

                // SizedBox memberikan jarak.
                const SizedBox(height: 28),

                // MANGA TERPOPULER

                // Row menyusun judul dan teks "Lihat Semua".
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text menampilkan judul section.
                    const Text(
                      'Manga Terpopuler',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Text menampilkan opsi untuk melihat semua manga.
                    Text(
                      'Lihat Semua',
                      style: TextStyle(
                        color: Colors.deepPurple.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                // SizedBox memberikan jarak.
                const SizedBox(height: 14),

                // Row menyusun dua card manga secara horizontal.
                Row(
                  children: [
                    // Expanded membuat card pertama mengisi ruang yang tersedia.
                    Expanded(
                      child: mangaCard(
                        'One Piece',
                        'Rp 45.000',
                        Icons.menu_book,
                      ),
                    ),

                    // SizedBox memberikan jarak antar card.
                    const SizedBox(width: 12),

                    // Expanded membuat card kedua mengisi ruang yang tersedia.
                    Expanded(
                      child: mangaCard('Naruto', 'Rp 40.000', Icons.menu_book),
                    ),
                  ],
                ),

                // SizedBox memberikan jarak.
                const SizedBox(height: 28),

                // REKOMENDASI

                // Text menampilkan judul rekomendasi.
                const Text(
                  'Rekomendasi Manga',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // SizedBox memberikan jarak.
                const SizedBox(height: 14),

                // Container digunakan sebagai card rekomendasi.
                Container(
                  padding: const EdgeInsets.all(14),

                  // BoxDecoration mengatur warna, border dan radius card.
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),

                  // Row menyusun icon dan informasi manga secara horizontal.
                  child: Row(
                    children: [
                      // Container digunakan sebagai cover manga.
                      Container(
                        width: 65,
                        height: 80,

                        // BoxDecoration memberikan warna cover manga.
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),

                        // Icon digunakan sebagai ilustrasi cover manga.
                        child: Icon(
                          Icons.menu_book,
                          size: 35,
                          color: Colors.deepPurple.shade700,
                        ),
                      ),

                      // SizedBox memberikan jarak antara cover dan informasi.
                      const SizedBox(width: 14),

                      // Expanded membuat informasi mengisi sisa ruang.
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text menampilkan judul manga.
                            const Text(
                              'Demon Slayer',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // SizedBox memberikan jarak.
                            const SizedBox(height: 6),

                            // Text menampilkan genre manga.
                            Text(
                              'Action • Fantasy',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),

                            // SizedBox memberikan jarak.
                            const SizedBox(height: 8),

                            // Text menampilkan harga manga.
                            Text(
                              'Rp 50.000',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Icon menampilkan tanda panah menuju detail.
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.grey.shade500,
                      ),
                    ],
                  ),
                ),

                // SizedBox memberikan jarak bawah halaman.
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function ini membuat widget kategori agar kode lebih ringkas.
  Widget categoryItem(String title, IconData icon) {
    // Container digunakan sebagai card kategori.
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),

      // BoxDecoration mengatur background dan radius kategori.
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),

      // Column menyusun icon dan teks kategori secara vertikal.
      child: Column(
        children: [
          // Icon menampilkan icon kategori.
          Icon(icon, color: Colors.deepPurple.shade700, size: 22),

          // SizedBox memberikan jarak.
          const SizedBox(height: 5),

          // Text menampilkan nama kategori.
          Text(
            title,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Function ini membuat card manga.
  Widget mangaCard(String title, String price, IconData icon) {
    // Container digunakan sebagai card produk manga.
    return Container(
      padding: const EdgeInsets.all(12),

      // BoxDecoration mengatur tampilan card manga.
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),

      // Column menyusun cover, nama dan harga manga secara vertikal.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container digunakan sebagai area cover manga.
          Container(
            height: 130,
            width: double.infinity,

            // BoxDecoration memberikan background cover manga.
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade100,
              borderRadius: BorderRadius.circular(12),
            ),

            // Icon digunakan sebagai gambar sederhana cover manga.
            child: Icon(icon, size: 50, color: Colors.deepPurple.shade700),
          ),

          // SizedBox memberikan jarak setelah cover.
          const SizedBox(height: 10),

          // Text menampilkan nama manga.
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          // SizedBox memberikan jarak.
          const SizedBox(height: 5),

          // Text menampilkan harga manga.
          Text(
            price,
            style: TextStyle(
              fontSize: 14,
              color: Colors.deepPurple.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
