import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/manga_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  String selectedGenre = 'All'; // Filter genre yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manga Store'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. INPUT PENCARIAN
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Cari Manga...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
              const SizedBox(height: 12),

              // 2. FITUR PILIHAN GENRE (ChoiceChip)
              Consumer<MangaProvider>(
                builder: (context, provider, child) {
                  // Mengambil daftar genre unik dari data manga
                  final genres = ['All'];
                  for (var manga in provider.mangaList) {
                    final splitGenres = manga.genre.split(', ');
                    for (var g in splitGenres) {
                      if (!genres.contains(g)) {
                        genres.add(g);
                      }
                    }
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: genres.map((genre) {
                        final isSelected = selectedGenre == genre;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(genre),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  selectedGenre = genre;
                                });
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // 3. DAFTAR MANGA (FILTER PENCARIAN + GENRE)
              Expanded(
                child: Consumer<MangaProvider>(
                  builder: (context, provider, child) {
                    final filteredList = provider.mangaList.where((m) {
                      final matchesSearch = m.title.toLowerCase().contains(searchQuery);
                      final matchesGenre = selectedGenre == 'All' || m.genre.contains(selectedGenre);
                      return matchesSearch && matchesGenre;
                    }).toList();

                    if (filteredList.isEmpty) {
                      return const Center(
                        child: Text('Manga tidak ditemukan'),
                      );
                    }

                    return ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final manga = filteredList[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  manga.coverImage,
                                  width: 50,
                                  height: 75,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 50,
                                    height: 75,
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.book),
                                  ),
                                ),
                              ),
                              title: Text(
                                manga.title,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    'Genre: ${manga.genre}',
                                    style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Rp ${manga.price.toStringAsFixed(0)} | Stok: ${manga.stock}',
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              trailing: ElevatedButton(
                                onPressed: manga.stock > 0 ? () => provider.addToCart(manga) : null,
                                child: const Text('Beli'),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}