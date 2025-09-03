import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanilla_state/cart_cubit.dart';
import 'package:vanilla_state/main_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => CartCubit(),
      child: const MaterialApp(
        home: MainPage(),
      ),
    ),
  );
}
