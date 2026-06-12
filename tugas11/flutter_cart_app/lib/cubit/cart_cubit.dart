import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/product.dart';

part 'cart_state.dart';

/// CartCubit mengelola logika bisnis keranjang belanja.
/// Menggunakan Cubit (versi sederhana dari BLoC) untuk state management.
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  /// Tambahkan produk ke keranjang.
  /// Jika produk sudah ada, naikkan quantity-nya.
  void addProduct(Product product) {
    final updatedItems = Map<int, int>.from(state.items);
    updatedItems[product.id] = (updatedItems[product.id] ?? 0) + 1;
    emit(state.copyWith(items: updatedItems));
  }

  /// Hapus satu item produk dari keranjang.
  /// Jika quantity menjadi 0, produk dihapus dari keranjang.
  void removeProduct(Product product) {
    final updatedItems = Map<int, int>.from(state.items);
    if (updatedItems.containsKey(product.id)) {
      final currentQty = updatedItems[product.id]!;
      if (currentQty <= 1) {
        updatedItems.remove(product.id);
      } else {
        updatedItems[product.id] = currentQty - 1;
      }
      emit(state.copyWith(items: updatedItems));
    }
  }

  /// Hapus produk sepenuhnya dari keranjang (semua quantity).
  void removeProductCompletely(Product product) {
    final updatedItems = Map<int, int>.from(state.items);
    updatedItems.remove(product.id);
    emit(state.copyWith(items: updatedItems));
  }

  /// Kosongkan seluruh keranjang.
  void clearCart() {
    emit(const CartState());
  }

  /// Cek apakah produk ada di keranjang
  bool isInCart(int productId) => state.items.containsKey(productId);

  /// Ambil quantity produk tertentu di keranjang
  int getQuantity(int productId) => state.items[productId] ?? 0;
}
