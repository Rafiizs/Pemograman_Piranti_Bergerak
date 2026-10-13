import 'package:flutter/material.dart';
import '../models/manga.dart';

// Konsep Provider: ChangeNotifier digunakan untuk mengelola State Global secara reaktif
class MangaProvider extends ChangeNotifier {
  // Master data katalog manga
  final List<Manga> _mangaList = [
    Manga(
      id: '1',
      title: 'One Piece Vol. 100',
      genre: 'Action, Adventure',
      price: 45000,
      coverImage: 'assets/one_piece.jpg',
      stock: 10,
    ),
    Manga(
      id: '2',
      title: 'Jujutsu Kaisen Vol. 20',
      genre: 'Action, Supernatural',
      price: 50000,
      coverImage: 'assets/jujutsu.jpg',
      stock: 5,
    ),
    Manga(
      id: '3',
      title: 'Chainsaw Man Vol. 12',
      genre: 'Action, Dark Fantasy',
      price: 48000,
      coverImage: 'assets/chainsaw.jpg',
      stock: 3,
    ),
    Manga(
      id: '4',
      title: 'Demon Slayer Vol. 23',
      genre: 'Action, Supernatural',
      price: 46000,
      coverImage: 'assets/demon_slayer.jpg',
      stock: 8,
    ),
    Manga(
      id: '5',
      title: 'Spy x Family Vol. 9',
      genre: 'Action, Comedy',
      price: 47000,
      coverImage: 'assets/spy_x_family.jpg',
      stock: 6,
    ),
  ];

  // Map untuk menyimpan kuantitas belanjaan (Key: id manga, Value: jumlah kuantitas)
  final Map<String, int> _cartQuantities = {};

  // Getter data
  List<Manga> get mangaList => _mangaList;
  Map<String, int> get cartQuantities => _cartQuantities;

  // Konsep Provider: Menghitung total belanjaan secara reaktif
  double get grandTotal {
    double total = 0;
    _cartQuantities.forEach((mangaId, qty) {
      final manga = _mangaList.firstWhere((m) => m.id == mangaId);
      total += manga.price * qty;
    });
    return total;
  }

  // Fungsi menambah manga ke keranjang
  void addToCart(Manga manga) {
    if (manga.stock <= 0) return;
    manga.stock--;
    _cartQuantities[manga.id] = (_cartQuantities[manga.id] ?? 0) + 1;
    notifyListeners(); // Konsep Provider: Memperbarui tampilan UI secara otomatis
  }

  // Fungsi memperbarui jumlah kuantitas di keranjang
  void updateQuantity(String mangaId, int newQuantity) {
    final manga = _mangaList.firstWhere((m) => m.id == mangaId);
    int currentQty = _cartQuantities[mangaId] ?? 0;
    int diff = newQuantity - currentQty;

    if (manga.stock - diff < 0) return;

    manga.stock -= diff;
    if (newQuantity <= 0) {
      _cartQuantities.remove(mangaId);
    } else {
      _cartQuantities[mangaId] = newQuantity;
    }
    notifyListeners(); // Konsep Provider: Mengirim notifikasi perubahan data ke Consumer
  }

  // Fungsi mengosongkan keranjang saat checkout
  void clearCart() {
    _cartQuantities.clear();
    notifyListeners(); // Konsep Provider: Mengirim notifikasi perubahan data
  }
}