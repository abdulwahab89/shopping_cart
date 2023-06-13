import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/cart_provide.dart';
import 'package:shopping_cart/product_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CartProvider(),
        child: Builder(builder: (BuildContext context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: ProductListScreen(),
          );
        }));
  }
}
