import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';

import '../../../../core/data/data_state.dart';
import '../../../../core/local_db/app_database.dart';
import '../../domain/repository/products_repository.dart';
import '../data_sources/remote/products_api_service.dart';
import '../models/product_model.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsApiService _newsApiService;
  final AppDatabase _appDatabase;
  ProductsRepositoryImpl(this._newsApiService,this._appDatabase);

  @override
  Future<DataState<List<ProductEntity>>> getProducts() async {
    try {
      final httpResponse = await _newsApiService.getProducts();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            DioError(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioErrorType.response,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioError catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<List<ProductEntity>> getSavedProducts() async {
    return await _appDatabase.productDAO.getProducts();
  }

  @override
  Future<void> removeProducts(List<ProductEntity> products) async{
    await _appDatabase.productDAO.deleteProducts(products.map((e) => ProductModel.fromEntity(e)).toList());
  }

  @override
  Future<void> saveProducts(List<ProductEntity> products) async {
    await _appDatabase.productDAO.insertProducts(products.map((e) => ProductModel.fromEntity(e)).toList());
  }


  @override
  Future<void> updateProducts(List<ProductEntity> products) async {
    await _appDatabase.productDAO.updateProducts(products.map((e) => ProductModel.fromEntity(e)).toList());
  }

}