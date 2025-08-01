import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_notifier.dart';
import 'package:vanilla_state/cart_page.dart';
import 'package:vanilla_state/products_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final CartNotifier _cartNotifier = CartNotifier();

  void openCart() => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CartPage(
            cartNotifier: _cartNotifier,
          ),
        ),
      );

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ProductsPage(
            cartNotifier: _cartNotifier,
          ),
          Positioned(
            bottom: 50,
            right: 12,
            child: ElevatedButton(
              style: const ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.zero),
                fixedSize: WidgetStatePropertyAll(
                  Size(60, 60),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              onPressed: openCart,
              child: Stack(
                children: <Widget>[
                  const Center(
                    child: Icon(Icons.shopping_cart),
                  ),
                  Positioned(
                    right: 0,
                    child: ListenableBuilder(
                      listenable: _cartNotifier,
                      builder: (_, __) => Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.pink[500],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          "${_cartNotifier.cartCount}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            decorationThickness: 0,
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
