import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanilla_state/cart_cubit.dart';
import 'package:vanilla_state/firebase_options.dart';
import 'package:vanilla_state/hive_service.dart';
import 'package:vanilla_state/main_page.dart';
import 'package:vanilla_state/product_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().initializeHive();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(create: (_) => CartCubit()),
        BlocProvider<ProductCubit>(create: (_) => ProductCubit()),
      ],
      child: const MaterialApp(
        home: MainPage(),
      ),
    ),
  );
}
