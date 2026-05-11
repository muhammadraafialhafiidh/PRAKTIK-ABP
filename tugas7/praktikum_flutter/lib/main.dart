import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
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
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          title: const Text('Praktikum Flutter Widget'),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.amber,
            tabs: [
              Tab(text: 'Container'),
              Tab(text: 'GridView'),
              Tab(text: 'ListView'),
              Tab(text: 'LV.builder'),
              Tab(text: 'LV.separated'),
              Tab(text: 'Stack'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ContainerPage(),
            GridViewPage(),
            ListViewPage(),
            ListViewBuilderPage(),
            ListViewSeparatedPage(),
            StackPage(),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 1. CONTAINER
// ─────────────────────────────────────────────
class ContainerPage extends StatelessWidget {
  const ContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Container Widget',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Container dasar berwarna
          Container(
            width: double.infinity,
            height: 100,
            color: Colors.indigo,
            alignment: Alignment.center,
            child: const Text(
              'Container Biru',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          const SizedBox(height: 12),

          // Container dengan border radius & shadow
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'Container Oranye + Shadow',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 12),

          // Container dengan gradient
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.pink],
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Container Gradient',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 12),

          // Container dengan border
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green, width: 3),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Container dengan Border Hijau',
              style: TextStyle(color: Colors.green, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 2. GRIDVIEW
// ─────────────────────────────────────────────
class GridViewPage extends StatelessWidget {
  const GridViewPage({super.key});

  final List<Map<String, dynamic>> _items = const [
    {'label': 'Item 1', 'color': Colors.red, 'icon': Icons.star},
    {'label': 'Item 2', 'color': Colors.blue, 'icon': Icons.favorite},
    {'label': 'Item 3', 'color': Colors.green, 'icon': Icons.home},
    {'label': 'Item 4', 'color': Colors.orange, 'icon': Icons.music_note},
    {'label': 'Item 5', 'color': Colors.purple, 'icon': Icons.camera_alt},
    {'label': 'Item 6', 'color': Colors.teal, 'icon': Icons.flight},
    {'label': 'Item 7', 'color': Colors.pink, 'icon': Icons.sports_soccer},
    {'label': 'Item 8', 'color': Colors.brown, 'icon': Icons.book},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'GridView Widget (8 item)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: _items.map((item) {
                return Container(
                  decoration: BoxDecoration(
                    color: item['color'] as Color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        color: Colors.white,
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['label'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 3. LISTVIEW (3 item statis: A, B, C)
// ─────────────────────────────────────────────
class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ListView Widget (3 item)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                _buildTile('A', 'Item A - ListView statis', Colors.indigo, Icons.looks_one),
                const SizedBox(height: 8),
                _buildTile('B', 'Item B - ListView statis', Colors.teal, Icons.looks_two),
                const SizedBox(height: 8),
                _buildTile('C', 'Item C - ListView statis', Colors.deepOrange, Icons.looks_3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(String label, String subtitle, Color color, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 18,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, color: color, size: 16),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 4. LISTVIEW.BUILDER
// ─────────────────────────────────────────────
class ListViewBuilderPage extends StatelessWidget {
  const ListViewBuilderPage({super.key});

  final List<Map<String, String>> _data = const [
    {'nama': 'Andi Pratama', 'nim': '2301001'},
    {'nama': 'Budi Santoso', 'nim': '2301002'},
    {'nama': 'Citra Dewi', 'nim': '2301003'},
    {'nama': 'Dian Rahayu', 'nim': '2301004'},
    {'nama': 'Eko Wahyudi', 'nim': '2301005'},
    {'nama': 'Fitri Handayani', 'nim': '2301006'},
    {'nama': 'Gilang Ramadhan', 'nim': '2301007'},
    {'nama': 'Hana Pertiwi', 'nim': '2301008'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ListView.builder (dari array)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '${_data.length} data mahasiswa',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                final item = _data[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      item['nama']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('NIM: ${item['nim']}'),
                    trailing: const Icon(Icons.person, color: Colors.indigo),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 5. LISTVIEW.SEPARATED
// ─────────────────────────────────────────────
class ListViewSeparatedPage extends StatelessWidget {
  const ListViewSeparatedPage({super.key});

  final List<Map<String, dynamic>> _menu = const [
    {'nama': 'Nasi Goreng', 'harga': 'Rp 15.000', 'icon': Icons.rice_bowl},
    {'nama': 'Mie Ayam', 'harga': 'Rp 12.000', 'icon': Icons.ramen_dining},
    {'nama': 'Soto Ayam', 'harga': 'Rp 13.000', 'icon': Icons.soup_kitchen},
    {'nama': 'Bakso', 'harga': 'Rp 14.000', 'icon': Icons.lunch_dining},
    {'nama': 'Gado-Gado', 'harga': 'Rp 11.000', 'icon': Icons.eco},
    {'nama': 'Es Teh', 'harga': 'Rp 5.000', 'icon': Icons.local_drink},
    {'nama': 'Jus Alpukat', 'harga': 'Rp 10.000', 'icon': Icons.local_bar},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ListView.separated (+ garis pembatas)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Daftar Menu Kantin',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: _menu.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.indigo,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              itemBuilder: (context, index) {
                final item = _menu[index];
                return ListTile(
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.indigo.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: Colors.indigo,
                    ),
                  ),
                  title: Text(
                    item['nama'] as String,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: Text(
                    item['harga'] as String,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 6. STACK
// ─────────────────────────────────────────────
class StackPage extends StatelessWidget {
  const StackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stack Widget',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Stack 1: kotak bertumpuk
          const Text(
            '1. Kotak Bertumpuk',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: Stack(
              children: [
                // Kotak paling bawah (besar)
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                // Kotak tengah
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                // Kotak paling atas (kecil)
                Positioned(
                  top: 40,
                  left: 40,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Stack!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Stack 2: gambar + teks overlay
          const Text(
            '2. Teks di Atas Kotak (Overlay)',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              // Background
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.deepPurple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              // Lingkaran dekorasi kiri atas
              Positioned(
                top: -20,
                left: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Lingkaran dekorasi kanan bawah
              Positioned(
                bottom: -30,
                right: -10,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Teks overlay di tengah
              const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.layers, color: Colors.white, size: 36),
                  SizedBox(height: 8),
                  Text(
                    'Stack Overlay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Teks di atas background',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Stack 3: badge / notifikasi
          const Text(
            '3. Badge Notifikasi',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  Positioned(
                    top: -6,
                    right: -6,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '5',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              const Text(
                'Ikon + Badge (Stack)',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
