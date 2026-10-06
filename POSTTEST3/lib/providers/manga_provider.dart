import 'package:flutter/material.dart';
import '../models/manga.dart';

class MangaProvider extends ChangeNotifier {
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

  final Map<String, int> _cartQuantities = {};

  List<Manga> get mangaList => _mangaList;
  Map<String, int> get cartQuantities => _cartQuantities;

  double get grandTotal {
    double total = 0;
    _cartQuantities.forEach((mangaId, qty) {
      final manga = _mangaList.firstWhere((m) => m.id == mangaId);
      total += manga.price * qty;
    });
    return total;
  }

  void addToCart(Manga manga) {
    if (manga.stock <= 0) return;
    manga.stock--;
    _cartQuantities[manga.id] = (_cartQuantities[manga.id] ?? 0) + 1;
    notifyListeners();
  }

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
    notifyListeners();
  }

  void clearCart() {
    _cartQuantities.clear();
    notifyListeners();
  }
}