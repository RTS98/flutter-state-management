import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_list_item.dart';
import 'package:vanilla_state/cart_notifier.dart';

class CartListItemView extends StatelessWidget {
  final CartListItem item;
  final CartNotifier cartNotifier;

  const CartListItemView({
    super.key,
    required this.item,
    required this.cartNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(item.product.name),
        subtitle: Text(item.product.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => cartNotifier.addToCart(
                CartListItem(
                  product: item.product,
                  quantity: 1,
                ),
              ),
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 15),
            ElevatedButton(
              onPressed: () => cartNotifier.removeFromCart(item),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
