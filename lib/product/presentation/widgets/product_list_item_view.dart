import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanilla_state/cart/presentation/bloc/cart_cubit.dart';
import 'package:vanilla_state/product/domain/models/product.dart';


class ProductListItemView extends StatelessWidget {
  final Product productItem;

  const ProductListItemView({
    super.key,
    required this.productItem,
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
        title: Text(
          productItem.name,
          style: const TextStyle(
            decoration: TextDecoration.none,
          ),
        ),
        subtitle: Text(
          productItem.description,
          style: const TextStyle(
            decoration: TextDecoration.none,
          ),
        ),
        trailing: ElevatedButton(
          onPressed: () => context.read<CartCubit>().addToCart(productItem),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
