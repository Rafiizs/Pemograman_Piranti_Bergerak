import 'package:flutter/material.dart';

// StatelessWidget: Halaman profil pengguna
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: Widget kerangka utama struktur halaman profil
    return Scaffold(
      // AppBar: Widget header atas halaman
      appBar: AppBar(
        title: const Text('Profil Saya'),
      ),
      // SafeArea: Memastikan tampilan tidak terpotong notch HP
      body: SafeArea(
        // Padding: Memberikan jarak luar di sekeliling konten
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // Column: Menyusun elemen secara vertikal dari atas ke bawah
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Center: Memosisikan foto/ikon profil di tengah
              Center(
                // CircleAvatar: Widget penampung foto profil berbentuk lingkaran
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.deepOrange,
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Card: Kartu informasi pengguna
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      // ListTile: Menampilkan Nama
                      ListTile(
                        leading: Icon(Icons.badge, color: Colors.deepOrange),
                        title: Text('Nama'),
                        subtitle: Text('Muhammad Rafii’ Zaidan Sakaria'),
                      ),
                      Divider(),
                      // ListTile: Menampilkan Email Random
                      ListTile(
                        leading: Icon(Icons.email, color: Colors.deepOrange),
                        title: Text('Email'),
                        subtitle: Text('rafii.manga@store.com'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}