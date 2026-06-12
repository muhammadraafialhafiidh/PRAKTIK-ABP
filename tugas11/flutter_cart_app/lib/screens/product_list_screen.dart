import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cart_cubit.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

/// Layar utama yang menampilkan daftar produk.
/// Menggunakan BlocBuilder untuk menampilkan jumlah item keranjang secara real-time.
class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        title: const Text(
          '🛍️ Toko Online',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          // BlocBuilder memantau CartState dan memperbarui badge keranjang secara real-time
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart, size: 28),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CartScreen(),
                        ),
                      );
                    },
                  ),
                  // Badge jumlah item - hanya tampil jika ada item
                  if (state.totalItems > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          '${state.totalItems}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Banner info keranjang real-time
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state.totalItems == 0) {
                return Container(
                  width: double.infinity,
                  color: const Color(0xFF1565C0).withValues(alpha: 0.1),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: const Text(
                    'Belum ada produk di keranjang. Yuk mulai belanja!',
                    style: TextStyle(color: Color(0xFF1565C0), fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return Container(
                width: double.infinity,
                color: Colors.green.shade50,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_cart, color: Colors.green, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      '${state.totalItems} item di keranjang  •  Total: ${_formatPrice(state.totalPrice(dummyProducts))}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Daftar produk
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: dummyProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(product: dummyProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(double price) {
    final formatted = price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
    return 'Rp $formatted';
  }
}
