import 'package:flutter/material.dart';

// Ganti dengan data diri masing-masing.
const String nama = 'Ridho Safutra';
const String nim = '20240040121';
const String prodiKelas = 'Teknik Informatika / TI-24G';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPM Sesi 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PPM Sesi 2 - $nama ($nim)'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            PromoBanner(),
            SizedBox(height: 16),
            ProfileCard(
              nama: nama,
              nim: nim,
              prodiKelas: prodiKelas,
            ),
            SizedBox(height: 16),
            ProductCard(),
          ],
        ),
      ),
    );
  }
}

/// Banner promo menggunakan Stack dan Positioned.
/// Foto piala dipakai sebagai background banner.
class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Foto piala sebagai background
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/foto_piala.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Overlay gelap supaya teks tetap terbaca
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.black.withValues(alpha: 0.75),
                  Colors.black.withValues(alpha: 0.1),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 20,
            bottom: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PELATIH PROFESIONAL PASKIBRA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Booking sesi latihan sekarang!',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'BARU',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Kartu profil mahasiswa (StatelessWidget).
/// Foto profil (jaket coklat) dipakai sebagai avatar bulat.
class ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String prodiKelas;

  const ProfileCard({
    super.key,
    required this.nama,
    required this.nim,
    required this.prodiKelas,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 36,
              backgroundImage: AssetImage('assets/images/foto_profil.jpg'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('NIM: $nim'),
                  Text(prodiKelas),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      5,
                      (_) => const Icon(Icons.star, color: Colors.amber, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Format angka jadi Rupiah sederhana, tanpa package tambahan.
String formatRupiah(int angka) {
  final digits = angka.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < digits.length; i++) {
    final posFromRight = digits.length - i;
    buffer.write(digits[i]);
    if (posFromRight > 1 && posFromRight % 3 == 1) {
      buffer.write('.');
    }
  }
  return 'Rp $buffer';
}

/// Kartu produk (jasa pelatihan paskibra) menggunakan StatefulWidget.
class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  static const int hargaSatuan = 150000;

  int jumlah = 1;
  bool favorit = false;
  int jumlahSuka = 24;

  void tambahJumlah() {
    setState(() => jumlah++);
  }

  void kurangJumlah() {
    if (jumlah > 1) {
      setState(() => jumlah--);
    }
  }

  void toggleFavorit() {
    setState(() {
      favorit = !favorit;
      favorit ? jumlahSuka++ : jumlahSuka--;
    });
  }

  void tambahKeKeranjang() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$jumlah sesi pelatihan ditambahkan ke keranjang!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final totalHarga = hargaSatuan * jumlah;

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.flag_circle, size: 72, color: colors.primary),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    'Pelatihan Baris-Berbaris Paskibra',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: toggleFavorit,
                  icon: Icon(
                    favorit ? Icons.favorite : Icons.favorite_border,
                    color: favorit ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: colors.secondaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Pelatihan Kedisiplinan',
                style: TextStyle(fontSize: 12, color: colors.onSecondaryContainer),
              ),
            ),
            const SizedBox(height: 6),
            Text('$jumlahSuka disukai', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text(
              '${formatRupiah(totalHarga)} / sesi',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton.filledTonal(
                      onPressed: kurangJumlah,
                      icon: const Icon(Icons.remove),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('$jumlah', style: const TextStyle(fontSize: 18)),
                    ),
                    IconButton.filledTonal(
                      onPressed: tambahJumlah,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: tambahKeKeranjang,
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('Tambah ke Keranjang'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}