import 'package:flutter/material.dart';

// Class Manga digunakan untuk menyimpan data produk manga.
class Manga {
  final String title;
  final String price;
  final String genre;
  final String image;

  // Constructor untuk membuat data manga.
  const Manga({
    required this.title,
    required this.price,
    required this.genre,
    required this.image,
  });
}

// ProductCard digunakan untuk menampilkan produk manga pada beranda.
class ProductCard extends StatelessWidget {
  final Manga manga;
  final VoidCallback onTap;
  final VoidCallback onAddCart;

  const ProductCard({
    super.key,
    required this.manga,
    required this.onTap,
    required this.onAddCart,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    manga.image,
                    height: 150, // Tinggi bingkai gambar
                    width: double.infinity,
                    fit: BoxFit.cover, // Dikembalikan ke BoxFit.cover (tidak stretch/gepeng)
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      manga.genre,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              manga.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              manga.price,
              style: TextStyle(
                fontSize: 14,
                color: Colors.deepPurple.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onAddCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  'Masukkan Keranjang',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// List Data Manga yang disesuaikan dengan file di folder assets/
final List<Manga> dummyMangaList = [
  const Manga(
    title: 'One Piece',
    genre: 'Action, Adventure',
    price: 'Rp 45.000',
    image: 'assets/one_piece.jpg',
  ),
  const Manga(
    title: 'Naruto',
    genre: 'Action, Ninja',
    price: 'Rp 42.000',
    image: 'assets/naruto.jpg',
  ),
  const Manga(
    title: 'Kimi no Todoke',
    genre: 'Romance, School',
    price: 'Rp 40.000',
    image: 'assets/kimi_no_todoke.jpg',
  ),
  const Manga(
    title: 'Ao Haru Ride',
    genre: 'Romance, Drama',
    price: 'Rp 40.000',
    image: 'assets/ao_haru_ride.jpg',
  ),
  const Manga(
    title: 'Gintama',
    genre: 'Comedy, Action',
    price: 'Rp 43.000',
    image: 'assets/gintama.jpg',
  ),
  const Manga(
    title: 'One Punch Man',
    genre: 'Action, Comedy',
    price: 'Rp 46.000',
    image: 'assets/one_punch_man.jpg',
  ),
  const Manga(
    title: 'Demon Slayer',
    genre: 'Action, Supernatural',
    price: 'Rp 48.000',
    image: 'assets/demon_slayer.jpg',
  ),
  const Manga(
    title: 'Jujutsu Kaisen',
    genre: 'Action, Fantasy',
    price: 'Rp 50.000',
    image: 'assets/jujutsu_kaisen.jpg',
  ),
];