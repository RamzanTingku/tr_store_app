
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import '../../../../core/data/data_state.dart';

abstract class ProductsRepository {
  // API methods
  Future<DataState<List<ProductEntity>>> getProducts();

  // Database methods
  Future <List<ProductEntity>> getSavedProducts();

  Future <void> saveProducts(List<ProductEntity> products);

  Future <void> updateProducts(List<ProductEntity> products);

  Future <void> removeProducts(List<ProductEntity> products);
}