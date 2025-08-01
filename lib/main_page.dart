import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_list_item.dart';
import 'package:vanilla_state/cart_page.dart';
import 'package:vanilla_state/products_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ValueNotifier<Map<String, CartListItem>> items =
      ValueNotifier<Map<String, CartListItem>>({});
  final ValueNotifier<int> cartCount = ValueNotifier(0);

  void addToCart(CartListItem item) {
    items.value.update(
      item.product.id,
      (item) => CartListItem(
        product: item.product,
        quantity: item.quantity + 1,
      ),
      ifAbsent: () => item,
    );

    items.value = Map.from({...items.value});

    _calculatateCartCount();
  }

  void removeFromCart(CartListItem item) {
    final cartItem = items.value[item.product.id];

    if (cartItem == null) return;

    if (cartItem.quantity == 1) {
      items.value.remove(cartItem.product.id);
      items.value = Map.from({...items.value});
    } else {
      items.value.update(
        item.product.id,
        (item) => CartListItem(
          product: item.product,
          quantity: item.quantity - 1,
        ),
      );

      items.value = Map.from({...items.value});
    }

    _calculatateCartCount();
  }

  void _calculatateCartCount() => cartCount.value = items.value.entries.fold(
        0,
        (int count, item) => count + item.value.quantity,
      );

  void openCart() => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CartPage(
            items: items,
            onAddToCart: addToCart,
            onRemoveFromCart: removeFromCart,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ProductsPage(onAddToCart: addToCart),
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
                    child: ValueListenableBuilder<int>(
                      valueListenable: cartCount,
                      builder: (_, count, __) => Container(
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
                          "$count",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            decorationThickness: 0,
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
