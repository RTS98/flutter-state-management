import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_view_model.dart';
import 'package:vanilla_state/cart_provider.dart';
import 'package:vanilla_state/main_page.dart';

void main() {
  runApp(
    CartProvider(
      cartViewModel: CartViewModel(),
      child: const MaterialApp(
        home: MainPage(),
      ),
    ),
  );
}
