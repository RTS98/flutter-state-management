import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanilla_state/product_repository.dart';
import 'package:vanilla_state/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository = ProductRepositoryImpl();

  ProductCubit()
      : super(
          ProductState(
            products: [],
            isProcessing: false,
            cartCount: 0,
          ),
        ) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    emit(state.copyWith(isProcessing: true));
    try {
      final products = await _productRepository.fetchProducts();
      emit(state.copyWith(products: products, isProcessing: false));
    } on Exception catch (e) {
      emit(state.copyWith(exception: e, isProcessing: false));
    }
  }

  void clearError() => emit(state.copyWith(exception: null));
}
