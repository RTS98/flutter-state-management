import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_list_item_view.dart';
import 'package:vanilla_state/cart_notifier.dart';
import 'package:vanilla_state/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CartNotifier cartNotifier = CartProvider.of(context).cartNotifier;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListenableBuilder(
          listenable: cartNotifier,
          builder: (_, __) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                  itemCount: cartNotifier.items.length,
                  itemBuilder: (_, index) => CartListItemView(
                    item: cartNotifier.items.values.toList()[index],
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
                      Text("${cartNotifier.totalPrice}\$")
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
