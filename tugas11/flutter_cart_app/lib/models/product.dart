import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageEmoji;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageEmoji,
  });

  @override
  List<Object?> get props => [id, name, description, price, imageEmoji];
}

/// Daftar produk statis (minimal 5 produk)
final List<Product> dummyProducts = [
  const Product(
    id: 1,
    name: 'Laptop Gaming Pro',
    description: 'Laptop gaming bertenaga tinggi dengan RTX 4070',
    price: 18500000,
    imageEmoji: '💻',
  ),
  const Product(
    id: 2,
    name: 'Smartphone Ultra',
    description: 'Smartphone flagship dengan kamera 200MP',
    price: 12000000,
    imageEmoji: '📱',
  ),
  const Product(
    id: 3,
    name: 'Wireless Headphone',
    description: 'Headphone noise-cancelling premium',
    price: 2500000,
    imageEmoji: '🎧',
  ),
  const Product(
    id: 4,
    name: 'Smart Watch Series 9',
    description: 'Jam tangan pintar dengan fitur kesehatan lengkap',
    price: 4300000,
    imageEmoji: '⌚',
  ),
  const Product(
    id: 5,
    name: 'Mechanical Keyboard',
    description: 'Keyboard mekanikal RGB dengan switch red',
    price: 850000,
    imageEmoji: '⌨️',
  ),
  const Product(
    id: 6,
    name: 'Gaming Mouse',
    description: 'Mouse gaming 25600 DPI dengan sensor optik presisi',
    price: 650000,
    imageEmoji: '🖱️',
  ),
  const Product(
    id: 7,
    name: 'Monitor 4K 144Hz',
    description: 'Monitor gaming 27 inci 4K resolusi tinggi',
    price: 7200000,
    imageEmoji: '🖥️',
  ),
];
