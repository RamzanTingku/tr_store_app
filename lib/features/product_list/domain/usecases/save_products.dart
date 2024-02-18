
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';

import '../repository/products_repository.dart';

class SaveProductsUseCase {
  
  final ProductsRepository _productRepository;

  SaveProductsUseCase(this._productRepository);

  Future<void> saveProducts(List<ProductEntity> list) async{
    return await _productRepository.saveProducts(list);
  }
  
}