
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import '../../../../../core/data_state/data_state.dart';

abstract class ProductRepository {
  // API methods
  Future<DataState<ProductEntity>> getProduct(int? id);

  // Database methods
  Future<ProductEntity?> getSavedProduct(int? id);
}