import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tr_store_app/features/product_list/data/repository/products_repository_impl.dart';
import '../../core/local_db/app_database.dart';
import '../../features/product_list/data/data_sources/remote/products_api_service.dart';
import '../../features/product_list/domain/repository/products_repository.dart';
import '../../features/product_list/domain/usecases/get_products.dart';
import '../../features/product_list/domain/usecases/get_saved_products.dart';
import '../../features/product_list/domain/usecases/remove_products.dart';
import '../../features/product_list/domain/usecases/save_products.dart';
import '../features/product_details/data/repository/product_repository_impl.dart';
import '../features/product_details/domain/repository/product_repository.dart';
import '../features/product_details/domain/usecases/get_product.dart';
import '../features/product_details/domain/usecases/get_saved_product.dart';
import '../features/product_list/domain/usecases/remove_product.dart';
import '../features/product_list/domain/usecases/update_product.dart';
import '../features/product_list/domain/usecases/update_products.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);
  
  // Dio
  sl.registerSingleton<Dio>(Dio()
    ..interceptors.add(
      PrettyDioLogger(requestHeader: true, requestBody: true),
    ));

  // Dependencies
  sl.registerSingleton<ProductsApiService>(ProductsApiService(sl()));

  sl.registerSingleton<ProductsRepository>(
      ProductsRepositoryImpl(sl(),sl())
  );

  sl.registerSingleton<ProductRepository>(
      ProductRepositoryImpl(sl(),sl())
  );
  
  //UseCases
  sl.registerSingleton<GetProductsUseCase>(
    GetProductsUseCase(sl())
  );

  sl.registerSingleton<GetSavedProductsUseCase>(
    GetSavedProductsUseCase(sl())
  );

  sl.registerSingleton<SaveProductsUseCase>(
    SaveProductsUseCase(sl())
  );
  
  sl.registerSingleton<RemoveProductsUseCase>(
    RemoveProductsUseCase(sl())
  );

  sl.registerSingleton<UpdateProductsUseCase>(
      UpdateProductsUseCase(sl())
  );

  sl.registerSingleton<UpdateProductUseCase>(
      UpdateProductUseCase(sl())
  );

  sl.registerSingleton<RemoveProductUseCase>(
      RemoveProductUseCase(sl())
  );

  sl.registerSingleton<GetProductUseCase>(
      GetProductUseCase(sl())
  );

  sl.registerSingleton<GetSavedProductUseCase>(
      GetSavedProductUseCase(sl())
  );


}