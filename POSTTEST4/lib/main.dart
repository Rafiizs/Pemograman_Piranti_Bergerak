import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/manga_provider.dart';
import 'pages/home_page.dart';
import 'pages/cart_page.dart';
import 'pages/profile_page.dart'; // Import halaman profil baru

void main() {
  runApp(
    // MultiProvider & ChangeNotifierProvider: Registrasi state manager di root aplikasi
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MangaProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: Widget utama pendaftaran aplikasi dan tema
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manga Store',
      theme: ThemeData(
        useMaterial3: true,
        // Tema warna oranye
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
        ),
      ),
      home: const MainNavigationPage(),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  // Daftar 3 halaman utama aplikasi (Beranda, Keranjang, Profil)
  final List<Widget> _pages = const [
    HomePage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold: Widget kerangka utama penampung BottomNavigationBar
    return Scaffold(
      body: _pages[_selectedIndex],
      // BottomNavigationBar: Widget navigasi menu bawah layar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          // BottomNavigationBarItem 1: Beranda
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          // BottomNavigationBarItem 2: Keranjang
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          // BottomNavigationBarItem 3: Profil
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}