import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_list_item_view.dart';
import 'package:vanilla_state/cart_view_model.dart';
import 'package:vanilla_state/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CartViewModel cartViewModel = CartProvider.of(context).cartViewModel;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListenableBuilder(
          listenable: cartViewModel,
          builder: (_, __) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: ListView.builder(
                  itemCount: cartViewModel.state.items.length,
                  itemBuilder: (_, index) => CartListItemView(
                    item: cartViewModel.state.items[index],
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
                      Text("${cartViewModel.state.totalPrice}\$")
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
