import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanilla_state/cart/domain/models/cart_info.dart';
import 'package:vanilla_state/cart/domain/models/cart_list_item.dart';
import 'package:vanilla_state/cart/domain/repository/cart_repository.dart';
import 'package:vanilla_state/cart/presentation/bloc/cart_state.dart';
import 'package:vanilla_state/product/domain/models/product.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;

  CartCubit({
    required CartRepository cartModel,
  })  : _cartRepository = cartModel,
        super(
          CartState(
            items: [],
            totalPrice: 0,
            cartCount: 0,
          ),
        ) {
    _cartRepository.stream.listen(
      (CartInfo cartInfo) {
        emit(
          state.copyWith(
            items: cartInfo.items,
            totalPrice: cartInfo.totalPrice,
            cartCount: cartInfo.cartCount,
          ),
        );
      },
    );
  }

  Future<void> addToCart(Product item) async {
    emit(state.copyWith(isProcessing: true));

    try {
      await _cartRepository.addToCart(item);
      emit(state.copyWith(isProcessing: false));
    } on Exception catch (e) {
      emit(state.copyWith(error: e, isProcessing: false));
    }
  }

  Future<void> removeFromCart(CartListItem item) async {
    emit(state.copyWith(isProcessing: true));

    try {
      await _cartRepository.removeFromCart(item);
      emit(state.copyWith(isProcessing: false));
    } on Exception catch (e) {
      emit(state.copyWith(error: e, isProcessing: false));
    }
  }

  Future<void> fetchCartItems() async {
    emit(state.copyWith(isProcessing: true));
    try {
      final items = await _cartRepository.fetchCartItems();
      emit(state.copyWith(items: items.toList(), isProcessing: false));
    } on Exception catch (e) {
      emit(state.copyWith(error: e, isProcessing: false));
    }
  }

  void clearError() => emit(state.copyWith(error: null));

  // @override
  // Future<void> close() async {
  //   _cartRepository.dispose();
  //   super.close();
  // }
}
