import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanilla_state/cart_cubit.dart';
import 'package:vanilla_state/cart_page.dart';
import 'package:vanilla_state/cart_state.dart';
import 'package:vanilla_state/product_cubit.dart';
import 'package:vanilla_state/product_state.dart';
import 'package:vanilla_state/products_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final CartCubit _cartCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (_, state) {
          if (state.exception != null) {
            final errorMessage = state.exception.toString();

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

          return Stack(
            children: <Widget>[
              ProductsPage(
                products: state.products,
              ),
              Positioned(
                bottom: 50,
                right: 12,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.zero),
                    fixedSize: WidgetStatePropertyAll(
                      Size(60, 60),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  onPressed: openCart,
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (_, state) => Stack(
                      children: <Widget>[
                        const Center(
                          child: Icon(Icons.shopping_cart),
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.pink[500],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              "${state.cartCount}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                decorationThickness: 0,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _cartCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    _cartCubit = context.read<CartCubit>();
    super.initState();
  }

  void openCart() => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const CartPage(),
        ),
      );
}
