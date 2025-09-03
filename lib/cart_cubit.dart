import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanilla_state/cart_info.dart';
import 'package:vanilla_state/cart_list_item.dart';
import 'package:vanilla_state/cart_model.dart';
import 'package:vanilla_state/cart_state.dart';
import 'package:vanilla_state/product_list_item.dart';

class CartCubit extends Cubit<CartState> {
  final CartModel _cartModel = CartModel();

  CartCubit()
      : super(
          CartState(
            items: [],
            totalPrice: 0,
            cartCount: 0,
          ),
        ) {
    _cartModel.stream.listen(
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

  Future<void> addToCart(ProductListItem item) async {
    emit(state.copyWith(isProcessing: true));

    try {
      await _cartModel.addToCart(item);
      emit(state.copyWith(isProcessing: false));
    } on Exception catch (e) {
      emit(state.copyWith(error: e, isProcessing: false));
    }
  }

  Future<void> removeFromCart(CartListItem item) async {
    emit(state.copyWith(isProcessing: true));

    try {
      await _cartModel.removeFromCart(item);
      emit(state.copyWith(isProcessing: false));
    } on Exception catch (e) {
      emit(state.copyWith(error: e, isProcessing: false));
    }
  }

  void clearError() => emit(state.copyWith(error: null));

  @override
  Future<void> close() async {
    _cartModel.dispose();
    super.close();
  }
}
