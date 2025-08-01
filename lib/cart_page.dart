import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_list_item.dart';
import 'package:vanilla_state/cart_list_item_view.dart';

class CartPage extends StatefulWidget {
  final List<CartListItem> items;
  final Function(CartListItem) onAddToCart;
  final Function(CartListItem) onRemoveFromCart;

  const CartPage({
    super.key,
    required this.items,
    required this.onAddToCart,
    required this.onRemoveFromCart,
  });

  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final List<CartListItem> _items;
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _items = widget.items;
    _calculateTotalPrice();
  }

  void addToCart(CartListItem item) {
    setState(() {
      _items.add(item);
    });

    _calculateTotalPrice();
    widget.onAddToCart(item);
  }

  void removeFromCart(CartListItem item) {
    if (item.quantity == 1) {
      setState(() {
        _items.remove(item);
      });
    } else {
      setState(() {
        final index = _items.indexWhere(
          (cartItem) => cartItem.product.id == item.product.id,
        );

        _items[index] = CartListItem(
          product: item.product,
          quantity: item.quantity - 1,
        );
      });
    }

    _calculateTotalPrice();
    widget.onRemoveFromCart(item);
  }

  void _calculateTotalPrice() => totalPrice = _items.fold(
        0,
        (int price, item) => price + item.product.price,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (_, index) => CartListItemView(
                  item: _items[index],
                  onAddToCart: addToCart,
                  onRemoveFromCart: removeFromCart,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: <Widget>[
                  const Text("Total Price:"),
                  const SizedBox(width: 5),
                  Text("$totalPrice\$")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
