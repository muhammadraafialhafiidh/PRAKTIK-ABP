# Laporan Implementasi BLoC/Cubit - Aplikasi Keranjang Belanja Flutter

**Nama Proyek:** flutter_cart_app  
**State Management:** Cubit (bagian dari flutter_bloc)

---

## 1. Deskripsi Aplikasi

Aplikasi ini adalah toko online sederhana yang memungkinkan pengguna melihat daftar 7 produk elektronik, menambahkan produk ke keranjang, mengatur quantity, dan melihat total harga secara real-time. State management diimplementasikan menggunakan **Cubit** dari package `flutter_bloc`.

---

## 2. Struktur Proyek

```
lib/
├── main.dart                    # Entry point, BlocProvider root
├── models/
│   └── product.dart             # Model Product + data dummy 7 produk
├── cubit/
│   ├── cart_cubit.dart          # CartCubit - logika bisnis keranjang
│   └── cart_state.dart          # CartState - definisi state
├── screens/
│   ├── product_list_screen.dart # Layar daftar produk
│   └── cart_screen.dart         # Layar keranjang belanja
└── widgets/
    └── product_card.dart        # Widget kartu produk
```

---

## 3. Implementasi BLoC/Cubit

### 3.1 CartState (`cubit/cart_state.dart`)

```dart
class CartState extends Equatable {
  final Map<int, int> items; // {productId: quantity}

  int get totalItems => items.values.fold(0, (sum, qty) => sum + qty);
  double totalPrice(List<Product> products) { ... }
}
```

State berupa `Map<int, int>` yang memetakan ID produk ke jumlah quantity.  
`Equatable` digunakan agar BLoC dapat mendeteksi perubahan state secara efisien.

### 3.2 CartCubit (`cubit/cart_cubit.dart`)

```dart
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addProduct(Product product) { ... emit(newState); }
  void removeProduct(Product product) { ... emit(newState); }
  void removeProductCompletely(Product product) { ... emit(newState); }
  void clearCart() => emit(const CartState());
}
```

Cubit dipilih karena lebih sederhana dibanding BLoC penuh — tidak memerlukan Events, hanya method yang memanggil `emit()` untuk memperbarui state.

### 3.3 BlocProvider (`main.dart`)

```dart
BlocProvider(
  create: (context) => CartCubit(),
  child: MaterialApp(home: const ProductListScreen()),
)
```

`BlocProvider` ditempatkan di root aplikasi sehingga `CartCubit` dapat diakses dari semua layar (ProductListScreen maupun CartScreen).

### 3.4 BlocBuilder — Badge Keranjang Real-time (`product_list_screen.dart`)

```dart
BlocBuilder<CartCubit, CartState>(
  builder: (context, state) {
    return Stack(children: [
      IconButton(icon: Icon(Icons.shopping_cart), ...),
      if (state.totalItems > 0)
        Positioned(child: Text('${state.totalItems}')), // Badge angka
    ]);
  },
)
```

Setiap kali state berubah (produk ditambah/dihapus), `BlocBuilder` secara otomatis rebuild badge sehingga jumlah item selalu akurat.

### 3.5 BlocBuilder — Kontrol Quantity Per Produk (`product_card.dart`)

```dart
BlocBuilder<CartCubit, CartState>(
  builder: (context, state) {
    final qty = state.items[product.id] ?? 0;
    if (qty == 0) return ElevatedButton('Tambah ke Keranjang', ...);
    return Row(children: [
      IconButton(Icons.remove, onTap: cubit.removeProduct),
      Text('$qty'),
      IconButton(Icons.add, onTap: cubit.addProduct),
    ]);
  },
)
```

Tampilan tombol berubah dinamis: jika qty = 0 tampil tombol "Tambah", jika qty > 0 tampil kontrol +/−.

---

## 4. Alur State Management

```
User Tap "Tambah"
      ↓
CartCubit.addProduct(product)
      ↓
emit(CartState(items: {..., productId: qty+1}))
      ↓
BlocBuilder rebuild otomatis
      ↓
Badge AppBar & ProductCard diperbarui real-time
```

---

## 5. Fitur yang Diimplementasikan

| Fitur | Status |
|---|---|
| Daftar minimal 5 produk | ✅ 7 produk |
| Tambah produk ke keranjang | ✅ |
| Hapus / kurangi produk dari keranjang | ✅ |
| Jumlah item real-time di AppBar | ✅ |
| BlocProvider di root | ✅ |
| BlocBuilder di widget | ✅ |
| Total harga real-time | ✅ |
| Layar keranjang terpisah | ✅ |

---

## 6. Dependensi

```yaml
flutter_bloc: ^8.1.6   # BLoC/Cubit state management
equatable: ^2.0.5      # Perbandingan state yang efisien
```
