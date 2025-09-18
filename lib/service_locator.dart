import 'package:get_it/get_it.dart';
import 'package:vanilla_state/cart/data/repository/app_cart_repository.dart';
import 'package:vanilla_state/cart/data/repository/local_cart_repository.dart';
import 'package:vanilla_state/cart/data/repository/remote_cart_repository.dart';
import 'package:vanilla_state/cart/data/services/cart_api_service.dart';
import 'package:vanilla_state/cart/domain/repository/cart_repository.dart';
import 'package:vanilla_state/product/data/repository/app_product_repository.dart';
import 'package:vanilla_state/product/data/repository/local_product_repository.dart';
import 'package:vanilla_state/product/data/repository/remote_product_repository.dart';
import 'package:vanilla_state/product/data/services/hive_service.dart';
import 'package:vanilla_state/product/domain/repository/product_repository.dart';
import 'package:vanilla_state/product/data/services/products_api_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final HiveService hiveService = HiveService();
  await hiveService.initializeHive();

  getIt.registerSingletonAsync<ProductRepository>(
    () async {
      return AppProductRepositoryImpl(
        remoteProductRepository: RemoteProductRepository(
          productsApiService: ProductsApiService(),
        ),
        localProductRepository: LocalProductRepository(
          productBox: hiveService.getProductBox(),
        ),
      );
    },
  );

  getIt.registerSingletonAsync<CartRepository>(
    () async => AppCartRepository(
      remoteCartRepository: RemoteCartRepository(
        cartApiService: CartApiService(),
      ),
      localCartRepository: LocalCartRepository(
        cartBox: hiveService.getCartBox(),
      ),
    ),
  );

  await getIt.allReady();
}
