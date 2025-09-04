import 'package:get_it/get_it.dart';
import 'package:vanilla_state/cart_model.dart';
import 'package:vanilla_state/hive_service.dart';

import 'package:vanilla_state/product_repository.dart';
import 'package:vanilla_state/products_api_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingletonAsync<ProductRepository>(
    () async {
      final HiveService hiveService = HiveService();
      await hiveService.initializeHive();

      return ProductRepositoryImpl(
        remoteProductRepository: RemoteProductRepository(
          productsApiService: ProductsApiService(),
        ),
        localProductRepository: LocalProductRepository(
          productBox: hiveService.getProductBox(),
        ),
      );
    },
  );

  getIt.registerLazySingleton<CartModel>(() => CartModel());

  await getIt.allReady();
}
