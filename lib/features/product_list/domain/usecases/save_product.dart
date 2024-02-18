
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';

import '../repository/product_repository.dart';

class SaveProductUseCase {
  
  final ProductRepository _productRepository;

  SaveProductUseCase(this._productRepository);

  Future<void> saveProducts(List<ProductEntity> list) async{
    return await _productRepository.saveProducts(list);
  }
  
}