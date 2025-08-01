import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_notifier.dart';
import 'package:vanilla_state/cart_provider.dart';
import 'package:vanilla_state/main_page.dart';

void main() {
  runApp(
    CartProvider(
      cartNotifier: CartNotifier(),
      child: const MaterialApp(
        home: MainPage(),
      ),
    ),
  );
}
