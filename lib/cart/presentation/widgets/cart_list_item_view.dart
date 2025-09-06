import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanilla_state/cart/presentation/bloc/cart_cubit.dart';
import 'package:vanilla_state/cart/domain/models/cart_list_item.dart';

class CartListItemView extends StatelessWidget {
  final CartListItem item;

  const CartListItemView({
    super.key,
    required this.item,
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
              onPressed: () =>
                  context.read<CartCubit>().addToCart(item.product),
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 15),
            ElevatedButton(
              onPressed: () => context.read<CartCubit>().removeFromCart(item),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
