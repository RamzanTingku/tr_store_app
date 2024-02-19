
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';

import '../repository/products_repository.dart';

class UpdateProductsUseCase {

  final ProductsRepository _productRepository;

  UpdateProductsUseCase(this._productRepository);

  Future<void> updateProducts(List<ProductEntity> list) async{
    return await _productRepository.updateProducts(list);
  }

}