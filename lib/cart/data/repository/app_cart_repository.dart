import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:vanilla_state/cart/data/repository/local_cart_repository.dart';
import 'package:vanilla_state/cart/data/repository/remote_cart_repository.dart';
import 'package:vanilla_state/cart/domain/models/cart_info.dart';
import 'package:vanilla_state/cart/domain/models/cart_list_item.dart';
import 'package:vanilla_state/cart/domain/repository/cart_repository.dart';
import 'package:vanilla_state/product/domain/models/product.dart';

class AppCartRepository implements CartRepository {
  CartRepository _cartRepository;
  final RemoteCartRepository _remoteCartRepository;
  final LocalCartRepository _localCartRepository;
  final Connectivity _connectivity = Connectivity();

  AppCartRepository({
    required CartRepository cartRepository,
    required RemoteCartRepository remoteCartRepository,
    required LocalCartRepository localCartRepository,
  })  : _remoteCartRepository = remoteCartRepository,
        _cartRepository = cartRepository,
        _localCartRepository = localCartRepository {
    _connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult.first == ConnectivityResult.none) {
        _cartRepository = _localCartRepository;
        return;
      }
      _cartRepository = _remoteCartRepository;
    });
  }

  @override
  Stream<CartInfo> get stream => _cartRepository.stream;

  @override
  Future<void> addToCart(Product product) {
    return _cartRepository.addToCart(product);
  }

  @override
  Future<Iterable<CartListItem>> fetchCartItems() {
    return _cartRepository.fetchCartItems();
  }

  @override
  Future<void> removeFromCart(CartListItem item) {
    return _cartRepository.removeFromCart(item);
  }
}
