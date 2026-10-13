// Model data untuk merepresentasikan objek Manga di dalam aplikasi
class Manga {
  final String id;          // Identitas unik manga
  final String title;       // Judul manga
  final String genre;       // Genre manga
  final double price;       // Harga manga
  final String coverImage;  // Path file gambar dari aset lokal
  int stock;                // Stok barang yang dapat berkurang saat dibeli

  // Constructor untuk inisialisasi properti objek Manga
  Manga({
    required this.id,
    required this.title,
    required this.genre,
    required this.price,
    required this.coverImage,
    required this.stock,
  });
}