import 'package:flutter/material.dart';
import 'package:vanilla_state/cart_list_item_view.dart';
import 'package:vanilla_state/cart_provider.dart';
import 'package:vanilla_state/cart_view_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartViewModel _cartViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListenableBuilder(
          listenable: _cartViewModel,
          builder: (_, __) {
            if (_cartViewModel.state.isProcessing == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: _cartViewModel.state.items.length,
                    itemBuilder: (_, index) => CartListItemView(
                      item: _cartViewModel.state.items[index],
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
                      Text("${_cartViewModel.state.totalPrice}\$")
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

  @override
  void dispose() {
    _cartViewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _cartViewModel = CartProvider.read(context);
    _cartViewModel.addListener(_onCartViewModelStateChanged);
    super.initState();
  }

  void _onCartViewModelStateChanged() {
    if (_cartViewModel.state.error != null) {
      final errorMessage = _cartViewModel.state.error.toString();

      _cartViewModel.clearError();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }
}
