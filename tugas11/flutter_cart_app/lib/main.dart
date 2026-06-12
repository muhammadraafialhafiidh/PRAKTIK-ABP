import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cart_cubit.dart';
import 'screens/product_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider menyediakan CartCubit ke seluruh widget tree
    return BlocProvider(
      create: (context) => CartCubit(),
      child: MaterialApp(
        title: 'Toko Online - BLoC Cart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        home: const ProductListScreen(),
      ),
    );
  }
}
