import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';

import '../../../../../core/data_state/data_state.dart';
import '../../../../../core/local_db/app_database.dart';
import '../../../product_list/data/data_sources/remote/products_api_service.dart';
import '../../domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductsApiService _productApiService;
  final AppDatabase _appDatabase;
  ProductRepositoryImpl(this._productApiService, this._appDatabase);

  @override
  Future<DataState<ProductEntity>> getProduct(int? id) async {
    try {
      final httpResponse = await _productApiService.getProductDetails(postId: id);

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
  Future<ProductEntity?> getSavedProduct(int? id) async {
    return await _appDatabase.productDAO.findProductById(id!);
  }
}