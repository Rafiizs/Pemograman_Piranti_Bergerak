import 'package:flutter/material.dart';
import 'product.dart';

// MangaDetailPage merupakan halaman detail produk manga.
class MangaDetailPage extends StatelessWidget {
  final Manga manga;
  final VoidCallback onAddCart;

  // Constructor MangaDetailPage.
  const MangaDetailPage({
    super.key,
    required this.manga,
    required this.onAddCart,
  });

  @override
  Widget build(BuildContext context) {
    // Scaffold digunakan sebagai struktur dasar halaman.
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // AppBar digunakan sebagai header halaman.
      appBar: AppBar(
        // Text menampilkan judul halaman.
        title: const Text('Detail Manga'),

        // Warna background AppBar.
        backgroundColor: Colors.deepPurple,

        // Warna tulisan dan icon AppBar.
        foregroundColor: Colors.white,
      ),

      // SingleChildScrollView membuat halaman dapat di-scroll.
      body: SingleChildScrollView(
        // Padding memberikan jarak pada isi halaman.
        child: Padding(
          padding: const EdgeInsets.all(20),

          // Column menyusun isi halaman secara vertikal.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stack digunakan untuk menumpuk gambar dan label.
              Stack(
                children: [
                  // ClipRRect membuat sudut gambar menjadi melengkung.
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),

                    // Image.asset menampilkan cover manga.
                    child: Image.asset(
                      manga.image,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Positioned digunakan untuk menempatkan label genre.
                  Positioned(
                    top: 15,
                    left: 15,

                    // Container digunakan sebagai background label.
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),

                      // BoxDecoration mengatur bentuk label.
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(10),
                      ),

                      // Text menampilkan genre manga.
                      child: Text(
                        manga.genre,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // SizedBox memberikan jarak.
              const SizedBox(height: 20),

              // Text menampilkan judul manga.
              Text(
                manga.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // SizedBox memberikan jarak.
              const SizedBox(height: 8),

              // Text menampilkan harga manga.
              Text(
                manga.price,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.deepPurple.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // SizedBox memberikan jarak.
              const SizedBox(height: 20),

              // Container digunakan sebagai card deskripsi.
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                // BoxDecoration memberikan background dan bayangan.
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),

                  // BoxShadow memberikan efek bayangan.
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),

                // Text menampilkan deskripsi manga.
                child: const Text(
                  'Manga pilihan yang tersedia di MangaStore. '
                  'Kamu dapat menambahkan manga ini ke dalam '
                  'keranjang untuk melakukan pembelian.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),

              // SizedBox memberikan jarak.
              const SizedBox(height: 25),

              // SizedBox membuat tombol memenuhi lebar.
              SizedBox(
                width: double.infinity,

                // ElevatedButton digunakan sebagai tombol keranjang.
                child: ElevatedButton(
                  // Ketika ditekan, manga ditambahkan ke keranjang.
                  onPressed: onAddCart,

                  // ButtonStyle mengatur tampilan tombol.
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                  ),

                  // Text menampilkan tulisan tombol.
                  child: const Text(
                    'Masukkan ke Keranjang',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}