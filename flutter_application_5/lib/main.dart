import 'package:flutter/material.dart';
import 'product.dart';
import 'cartPage.dart';
import 'detailPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MangaStore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<Manga> cartItems = [];

  void addToCart(Manga manga) {
    setState(() {
      cartItems.add(manga);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${manga.title} berhasil ditambahkan ke keranjang!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(onAddToCart: addToCart),
      CartPage(cartItems: cartItems),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final Function(Manga) onAddToCart;

  const HomePage({super.key, required this.onAddToCart});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Manga> _filteredManga = dummyMangaList;
  String _selectedCategory = 'Semua';

  void _filterManga(String query) {
    setState(() {
      _filteredManga = dummyMangaList.where((manga) {
        final matchesQuery = manga.title.toLowerCase().contains(query.toLowerCase());
        final matchesCategory = _selectedCategory == 'Semua' || manga.genre.contains(_selectedCategory);
        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      if (_selectedCategory == category) {
        _selectedCategory = 'Semua';
      } else {
        _selectedCategory = category;
      }
      _filterManga(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('MangaStore'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Aksi tombol kembali
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kolom Pencarian
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterManga,
                decoration: const InputDecoration(
                  hintText: 'Cari manga favoritmu...',
                  prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            
            const SizedBox(height: 20),

            // Section Kategori / Genre
            const Text(
              'Kategori',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategoryItem('Action', Icons.flash_on),
                _buildCategoryItem('Romance', Icons.favorite),
                _buildCategoryItem('Comedy', Icons.sentiment_satisfied_alt),
                _buildCategoryItem('Fantasy', Icons.auto_awesome),
              ],
            ),

            const SizedBox(height: 20),

            // Judul Katalog
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedCategory == 'Semua' 
                      ? 'Katalog Manga' 
                      : 'Katalog: $_selectedCategory',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_selectedCategory != 'Semua')
                  GestureDetector(
                    onTap: () => _filterByCategory('Semua'),
                    child: const Text(
                      'Lihat Semua',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 15),

            // GridView Produk
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredManga.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final manga = _filteredManga[index];
                return ProductCard(
                  manga: manga,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MangaDetailPage(
                          manga: manga,
                          onAddCart: () => widget.onAddToCart(manga),
                        ),
                      ),
                    );
                  },
                  onAddCart: () => widget.onAddToCart(manga),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, IconData icon) {
    final isSelected = _selectedCategory == title;
    return GestureDetector(
      onTap: () => _filterByCategory(title),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.deepPurple : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.deepPurple,
              size: 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.deepPurple : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}