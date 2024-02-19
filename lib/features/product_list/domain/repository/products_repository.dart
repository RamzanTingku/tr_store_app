
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import '../../../../core/data_state/data_state.dart';

abstract class ProductsRepository {
  // API methods
  Future<DataState<List<ProductEntity>>> getProducts();

  // Database methods
  Future <List<ProductEntity>> getSavedProducts();

  Stream<List<ProductEntity>> getSavedProductsStream();

  Future <void> saveProducts(List<ProductEntity> products);

  Future <void> updateProduct(ProductEntity product);

  Future <void> updateProducts(List<ProductEntity> products);

  Future <void> removeProduct(ProductEntity product);

  Future <void> removeProducts(List<ProductEntity> products);
}