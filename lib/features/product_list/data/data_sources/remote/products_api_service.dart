import 'package:retrofit/retrofit.dart';
import 'package:tr_store_app/core/constants/urls.dart';
import 'package:dio/dio.dart';
import 'package:tr_store_app/features/product_list/data/models/product_model.dart';
part 'products_api_service.g.dart';

@RestApi(baseUrl:Urls.baseUrl)
abstract class ProductsApiService {
  factory ProductsApiService(Dio dio) = _ProductsApiService;
  
  @GET(Urls.posts)
  Future<HttpResponse<List<ProductModel>>> getProducts();
}