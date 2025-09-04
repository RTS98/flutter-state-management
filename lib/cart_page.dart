import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanilla_state/cart_cubit.dart';
import 'package:vanilla_state/cart_list_item_view.dart';
import 'package:vanilla_state/cart_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartCubit _cartCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (_, state) {
            if (state.error != null) {
              final errorMessage = state.error.toString();

              _cartCubit.clearError();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorMessage),
                ),
              );
            }
          },
          builder: (_, state) {
            if (state.isProcessing == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (_, index) => CartListItemView(
                      item: state.items[index],
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
                      Text("${state.totalPrice}\$")
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

  // @override
  // void dispose() {
  //   _cartCubit.close();
  //   super.dispose();
  // }

  @override
  void initState() {
    _cartCubit = context.read<CartCubit>();
    super.initState();
  }
}
