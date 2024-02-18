import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import '../repository/product_repository.dart';

class GetSavedProductUseCase{

  final ProductRepository _productRepository;

  GetSavedProductUseCase(this._productRepository);

  Future<List<ProductEntity>> getSavedProducts() async{
    return await _productRepository.getSavedProducts();
  }

}