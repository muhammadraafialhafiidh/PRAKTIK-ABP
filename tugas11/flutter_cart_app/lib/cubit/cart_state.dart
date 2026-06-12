part of 'cart_cubit.dart';

/// CartState menyimpan daftar produk yang ada di keranjang.
/// Menggunakan Map untuk menyimpan {productId: quantity}.
class CartState extends Equatable {
  final Map<int, int> items; // productId -> quantity

  const CartState({this.items = const {}});

  /// Hitung total jumlah item di keranjang
  int get totalItems => items.values.fold(0, (sum, qty) => sum + qty);

  /// Hitung total harga keranjang berdasarkan daftar produk
  double totalPrice(List<Product> products) {
    double total = 0;
    for (final entry in items.entries) {
      final product = products.firstWhere(
        (p) => p.id == entry.key,
        orElse: () => const Product(
          id: -1,
          name: '',
          description: '',
          price: 0,
          imageEmoji: '',
        ),
      );
      total += product.price * entry.value;
    }
    return total;
  }

  /// Salin state dengan perubahan items
  CartState copyWith({Map<int, int>? items}) {
    return CartState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}
