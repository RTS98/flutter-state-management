import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanilla_state/cart/domain/repository/cart_repository.dart';
import 'package:vanilla_state/cart/presentation/bloc/cart_cubit.dart';
import 'package:vanilla_state/firebase_options.dart';
import 'package:vanilla_state/main_page.dart';
import 'package:vanilla_state/product/domain/repository/product_repository.dart';
import 'package:vanilla_state/product/presentation/bloc/product_cubit.dart';
import 'package:vanilla_state/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(
          create: (_) => CartCubit(
            cartModel: getIt.get<CartRepository>(),
          )..fetchCartItems(),
        ),
        BlocProvider<ProductCubit>(
          create: (_) => ProductCubit(
            productRepository: getIt.get<ProductRepository>(),
          )..fetchProducts(),
        ),
      ],
      child: const MaterialApp(
        home: MainPage(),
      ),
    ),
  );
}
