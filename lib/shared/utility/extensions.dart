import '../../features/product_list/data/models/product_model.dart';
import '../../features/product_list/domain/entities/product.dart';

extension ProductUpdate on ProductEntity {

  ProductModel updateQty(int qty) {
    final product = ProductModel.updateQty(this, qty);
    return product;
  }

}