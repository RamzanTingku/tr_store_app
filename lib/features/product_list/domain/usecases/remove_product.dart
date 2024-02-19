
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';

import '../repository/products_repository.dart';

class RemoveProductUseCase {

  final ProductsRepository _productRepository;

  RemoveProductUseCase(this._productRepository);

  Future<void> removeProducts(ProductEntity entity) async{
    return await _productRepository.removeProduct(entity);
  }

}