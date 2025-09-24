import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:vanilla_state/cart/data/repository/local_cart_repository.dart';
import 'package:vanilla_state/cart/data/repository/remote_cart_repository.dart';
import 'package:vanilla_state/cart/domain/models/cart_info.dart';
import 'package:vanilla_state/cart/domain/models/cart_list_item.dart';
import 'package:vanilla_state/cart/domain/repository/cart_repository.dart';
import 'package:vanilla_state/product/domain/models/product.dart';

class AppCartRepository implements CartRepository {
  bool hasInternetConnection = false;
  final RemoteCartRepository _remoteCartRepository;
  final LocalCartRepository _localCartRepository;
  final Connectivity _connectivity = Connectivity();

  AppCartRepository({
    required RemoteCartRepository remoteCartRepository,
    required LocalCartRepository localCartRepository,
  })  : _remoteCartRepository = remoteCartRepository,
        _localCartRepository = localCartRepository {
    _connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult.first == ConnectivityResult.none) {
        hasInternetConnection = !hasInternetConnection;
        return;
      }
      hasInternetConnection = !hasInternetConnection;
      //TO DO: Solve Firebase.initializeApp() issue
      sync();
    });
  }

  @override
  Stream<CartInfo> get stream {
    if (hasInternetConnection) {
      return _remoteCartRepository.stream;
    }
    return _localCartRepository.stream;
  }

  @override
  Future<void> addToCart(Product product) async {
    if (hasInternetConnection) {
      await _remoteCartRepository.addToCart(product);
    }

    return _localCartRepository.addToCart(product);
  }

  @override
  Future<Iterable<CartListItem>> fetchCartItems() =>
      _localCartRepository.fetchCartItems();

  @override
  Future<void> removeFromCart(CartListItem item) async {
    if (hasInternetConnection) {
      await _remoteCartRepository.removeFromCart(item);
    }

    return _localCartRepository.removeFromCart(item);
  }

  Future<void> sync() async {
    final items = await _localCartRepository.fetchCartItems();

    return _remoteCartRepository.addMultipleCartItems(items);
  }
}
