import 'package:floor/floor.dart';
import 'package:tr_store_app/features/product_list/data/models/product_model.dart';

@dao
abstract class ProductsDao {

  @Insert(onConflict : OnConflictStrategy.replace)
  Future<void> insertProduct(ProductModel product);

  @Insert(onConflict : OnConflictStrategy.replace)
  Future<void> insertProducts(List<ProductModel> products);

  @Insert(onConflict : OnConflictStrategy.replace)
  Future<void> updateProduct(ProductModel product);

  @Insert(onConflict : OnConflictStrategy.replace)
  Future<void> updateProducts(List<ProductModel> products);
  
  @delete
  Future<void> deleteProduct(ProductModel products);

  @delete
  Future<void> deleteProducts(List<ProductModel> products);

  @Query('SELECT * FROM product')
  Future<List<ProductModel>> getProducts();

  @Query('SELECT * FROM product')
  Stream<List<ProductModel>> getProductsStream();
}