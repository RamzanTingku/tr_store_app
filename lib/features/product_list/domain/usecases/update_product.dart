
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';

import '../repository/products_repository.dart';

class UpdateProductUseCase {

  final ProductsRepository _productRepository;

  UpdateProductUseCase(this._productRepository);

  Future<void> updateProducts(ProductEntity entity) async{
    return await _productRepository.updateProduct(entity);
  }

}