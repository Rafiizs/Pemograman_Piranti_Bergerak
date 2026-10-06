import 'package:flutter/material.dart';
import 'product.dart';
import 'cartProductCard.dart';

// CartPage merupakan halaman keranjang MangaStore.
class CartPage extends StatelessWidget {
  final List<Manga> cartItems;

  // Constructor CartPage.
  const CartPage({
    super.key,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    // Scaffold digunakan sebagai struktur dasar halaman.
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // AppBar digunakan sebagai header halaman.
      appBar: AppBar(
        // Text menampilkan judul halaman.
        title: const Text('Keranjang'),

        // Warna background AppBar.
        backgroundColor: Colors.deepPurple,

        // Warna tulisan dan icon AppBar.
        foregroundColor: Colors.white,
      ),

      // StatefulBuilder digunakan agar produk dapat dihapus dari state keranjang.
      body: StatefulBuilder(
        builder: (context, setState) {
          // Jika keranjang kosong.
          if (cartItems.isEmpty) {
            // Center membuat isi berada di tengah.
            return Center(
              // Column menyusun icon dan teks secara vertikal.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon menampilkan icon keranjang kosong.
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 70,
                    color: Colors.deepPurple.shade300,
                  ),

                  // SizedBox memberikan jarak.
                  const SizedBox(height: 15),

                  // Text menampilkan informasi keranjang kosong.
                  const Text(
                    'Keranjang masih kosong',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // SizedBox memberikan jarak.
                  const SizedBox(height: 10),

                  // Text memberikan informasi tambahan.
                  Text(
                    'Silakan pilih manga terlebih dahulu.',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            );
          }

          // ListView digunakan untuk menampilkan daftar produk.
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Text menampilkan jumlah produk.
              Text(
                '${cartItems.length} Manga di Keranjang',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // SizedBox memberikan jarak.
              const SizedBox(height: 15),

              // List.generate membuat card berdasarkan isi keranjang.
              ...List.generate(
                cartItems.length,
                (index) {
                  // CartProductCard menampilkan produk keranjang.
                  return CartProductCard(
                    manga: cartItems[index],

                    // Menghapus produk ketika tombol hapus ditekan.
                    onDelete: () {
                      setState(() {
                        cartItems.removeAt(index);
                      });
                    },
                  );
                },
              ),

              // SizedBox memberikan jarak.
              const SizedBox(height: 10),

              // SizedBox membuat tombol memenuhi lebar.
              SizedBox(
                width: double.infinity,

                // ElevatedButton digunakan untuk tombol checkout.
                child: ElevatedButton(
                  // Tombol checkout.
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Checkout berhasil diproses!',
                        ),
                      ),
                    );
                  },

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
                    'Checkout',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}