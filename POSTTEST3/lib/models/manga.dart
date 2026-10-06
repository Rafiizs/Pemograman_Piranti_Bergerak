class Manga {
  final String id;
  final String title;
  final String genre;
  final double price;
  final String coverImage;
  int stock;

  Manga({
    required this.id,
    required this.title,
    required this.genre,
    required this.price,
    required this.coverImage,
    required this.stock,
  });
}
