import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/manga_provider.dart';

// StatelessWidget: Halaman keranjang belanja yang mengandalkan penuh state provider
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: Widget kerangka utama halaman keranjang
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
      ),
      // Consumer: Konsep Provider untuk mengambil data keranjang belanja
      body: Consumer<MangaProvider>(
        builder: (context, provider, child) {
          final cartItems = provider.cartQuantities;

          if (cartItems.isEmpty) {
            // Center: Widget untuk memosisikan teks di tengah layar
            return const Center(
              child: Text('Keranjang belanjaan kamu masih kosong'),
            );
          }

          // Column: Widget penyusun vertikal
          return Column(
            children: [
              // Expanded: Widget pengisi sisa ruang atas untuk daftar keranjang
              Expanded(
                // ListView.builder: Widget pembuat daftar bergulir untuk item keranjang
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final mangaId = cartItems.keys.elementAt(index);
                    final quantity = cartItems[mangaId]!;
                    final manga = provider.mangaList.firstWhere((m) => m.id == mangaId);

                    // Card: Widget wadah kartu item keranjang
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      // ListTile: Widget item baris daftar belanjaan
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          // Image.asset: Widget gambar cover manga
                          child: Image.asset(
                            manga.coverImage,
                            width: 40,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(manga.title),
                        subtitle: Text('Rp ${manga.price.toStringAsFixed(0)} x $quantity'),
                        // Row: Widget pengatur tombol pengurang dan penambah kuantitas
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // IconButton: Widget tombol ikon pengurang stok
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => provider.updateQuantity(manga.id, quantity - 1),
                            ),
                            Text('$quantity'),
                            // IconButton: Widget tombol ikon penambah stok
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => provider.updateQuantity(manga.id, quantity + 1),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Container: Widget wadah bagian ringkasan pembayaran di bawah
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                // Row: Widget penyusun horizontal untuk total harga dan tombol checkout
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: Rp ${provider.grandTotal.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // ElevatedButton: Widget tombol aksi checkout
                    ElevatedButton(
                      onPressed: () {
                        // showDialog & AlertDialog: Widget pop-up konfirmasi checkout
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Checkout Berhasil'),
                            content: const Text('Terima kasih telah berbelanja di Manga Store!'),
                            actions: [
                              // TextButton: Widget tombol tutup dialog
                              TextButton(
                                onPressed: () {
                                  provider.clearCart();
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}