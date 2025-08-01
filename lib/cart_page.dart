import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_list_item.dart';
import 'package:vanilla_state/cart_list_item_view.dart';

class CartPage extends StatefulWidget {
  final ValueNotifier<Map<String, CartListItem>> items;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ValueListenableBuilder<Map<String, CartListItem>>(
          valueListenable: widget.items,
          builder: (_, items, __) {
            final int totalPrice = items.values.fold(
              0,
              (int price, item) => price + item.product.price * item.quantity,
            );

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, index) => CartListItemView(
                    item: items.values.toList()[index],
                    onAddToCart: widget.onAddToCart,
                    onRemoveFromCart: widget.onRemoveFromCart,
                  ),
                )),
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
            );
          },
        ),
      ),
    );
  }
}
