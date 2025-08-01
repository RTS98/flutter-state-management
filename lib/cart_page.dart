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

  @override
  void initState() {
    super.initState();
    _items = widget.items;
  }

  void addToCart(CartListItem item) {
    setState(() {
      _items.add(item);
    });

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

    widget.onRemoveFromCart(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (_, index) => CartListItemView(
            item: _items[index],
            onAddToCart: addToCart,
            onRemoveFromCart: removeFromCart,
          ),
        ),
      ),
    );
  }
}
