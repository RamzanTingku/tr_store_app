import 'package:floor/floor.dart';
import 'package:tr_store_app/features/product_list/data/models/product_model.dart';

@dao
abstract class ProductsDao {

  @Insert()
  Future<void> insertProducts(List<ProductModel> products);

  @Insert()
  Future<void> updateProducts(List<ProductModel> products);
  
  @delete
  Future<void> deleteProducts(List<ProductModel> products);

  @Query('SELECT * FROM product')
  Future<List<ProductModel>> getProducts();
}