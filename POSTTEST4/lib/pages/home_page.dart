import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/manga_provider.dart';

// StatefulWidget: Digunakan untuk menangani state lokal (searchQuery dan selectedGenre)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  String selectedGenre = 'All';

  @override
  Widget build(BuildContext context) {
    // Scaffold: Widget kerangka utama struktur tampilan halaman
    return Scaffold(
      // AppBar: Widget header navigasi atas
      appBar: AppBar(
        // Text: Widget untuk menampilkan teks judul aplikasi
        title: const Text('Manga Store'),
      ),
      // SafeArea: Widget pencegah bagian layar terpotong oleh kamera/notch HP
      body: SafeArea(
        // Padding: Widget pemberi jarak/margin di sisi luar konten
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // Column: Widget penyusun elemen secara vertikal dari atas ke bawah
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextField: Widget input teks untuk pencarian manga
              TextField(
                // InputDecoration: Widget penghias kotak pencarian
                decoration: const InputDecoration(
                  hintText: 'Cari Manga...',
                  // Icon: Widget untuk menampilkan simbol pencarian
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // setState: Mengubah state lokal pencarian secara realtime
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
              // SizedBox: Widget pemisah/pemberi jarak antar komponen
              const SizedBox(height: 12),

              // Consumer: Konsep Provider yang mendengarkan dan merender ulang UI saat state MangaProvider berubah
              Consumer<MangaProvider>(
                builder: (context, provider, child) {
                  final genres = ['All'];
                  for (var manga in provider.mangaList) {
                    final splitGenres = manga.genre.split(', ');
                    for (var g in splitGenres) {
                      if (!genres.contains(g)) {
                        genres.add(g);
                      }
                    }
                  }

                  // SingleChildScrollView: Widget penata scroll horizontal untuk pilihan genre
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    // Row: Widget penyusun elemen secara horizontal dari kiri ke kanan
                    child: Row(
                      children: genres.map((genre) {
                        final isSelected = selectedGenre == genre;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          // ChoiceChip: Widget pilihan tombol genre berbentuk chip
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

              // Expanded: Widget pengisi sisa ruang vertikal layar
              Expanded(
                // Consumer: Konsep Provider untuk mengambil daftar manga dan melakukan filter
                child: Consumer<MangaProvider>(
                  builder: (context, provider, child) {
                    final filteredList = provider.mangaList.where((m) {
                      final matchesSearch = m.title.toLowerCase().contains(searchQuery);
                      final matchesGenre = selectedGenre == 'All' || m.genre.contains(selectedGenre);
                      return matchesSearch && matchesGenre;
                    }).toList();

                    if (filteredList.isEmpty) {
                      // Center: Widget pemosisian elemen di tengah layar
                      return const Center(
                        child: Text('Manga tidak ditemukan'),
                      );
                    }

                    // ListView.builder: Widget pembangun daftar item secara dinamis
                    return ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final manga = filteredList[index];
                        // Card: Widget wadah kartu bertema shadow
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            // ListTile: Widget susunan item daftar standar
                            child: ListTile(
                              // ClipRRect: Widget pemotong sudut gambar agar melengkung
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                // Image.asset: Widget pemuat gambar dari aset lokal
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
                              // ElevatedButton: Widget tombol aksi untuk menambah barang ke keranjang
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