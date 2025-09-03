import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_page.dart';
import 'package:vanilla_state/cart_provider.dart';
import 'package:vanilla_state/cart_view_model.dart';
import 'package:vanilla_state/products_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final CartViewModel _cartViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: _cartViewModel,
        builder: (_, __) {
          if (_cartViewModel.state.isProcessing == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Stack(
            children: <Widget>[
              const ProductsPage(),
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
                        child: Container(
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
                            "${_cartViewModel.state.cartCount}",
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
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _cartViewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _cartViewModel = CartProvider.read(context);
    _cartViewModel.addListener(_onCartViewModelStateChanged);
    super.initState();
  }

  void openCart() => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const CartPage(),
        ),
      );

  void _onCartViewModelStateChanged() {
    if (_cartViewModel.state.error != null) {
      final errorMessage = _cartViewModel.state.error.toString();

      _cartViewModel.clearError();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }
}
