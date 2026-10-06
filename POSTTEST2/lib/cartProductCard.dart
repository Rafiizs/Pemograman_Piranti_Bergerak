import 'package:flutter/material.dart';
import 'product.dart';

// CartProductCard digunakan untuk menampilkan produk di dalam keranjang.
class CartProductCard extends StatelessWidget {
  final Manga manga;
  final VoidCallback onDelete;

  // Constructor CartProductCard.
  const CartProductCard({
    super.key,
    required this.manga,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Container digunakan sebagai card produk dalam keranjang.
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),

      // BoxDecoration mengatur tampilan card.
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      // Row menyusun gambar dan informasi secara horizontal.
      child: Row(
        children: [
          // ClipRRect membuat sudut gambar menjadi melengkung.
          ClipRRect(
            borderRadius: BorderRadius.circular(10),

            // Image.asset menampilkan gambar manga.
            child: Image.asset(
              manga.image,
              width: 70,
              height: 85,
              fit: BoxFit.cover,
            ),
          ),

          // SizedBox memberikan jarak.
          const SizedBox(width: 12),

          // Expanded membuat informasi mengisi ruang yang tersedia.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text menampilkan nama manga.
                Text(
                  manga.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // SizedBox memberikan jarak.
                const SizedBox(height: 5),

                // Text menampilkan genre manga.
                Text(
                  manga.genre,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),

                // SizedBox memberikan jarak.
                const SizedBox(height: 7),

                // Text menampilkan harga manga.
                Text(
                  manga.price,
                  style: TextStyle(
                    color: Colors.deepPurple.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // IconButton digunakan untuk menghapus produk dari keranjang.
          IconButton(
            // Ketika ditekan, produk dihapus.
            onPressed: onDelete,

            // Icon menampilkan tombol hapus.
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}