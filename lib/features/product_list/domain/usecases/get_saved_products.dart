import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import '../repository/products_repository.dart';

class GetSavedProductsUseCase{

  final ProductsRepository _productRepository;

  GetSavedProductsUseCase(this._productRepository);

  Future<List<ProductEntity>> getSavedProducts() async{
    return await _productRepository.getSavedProducts();
  }

  Stream<List<ProductEntity>> getSavedProductsStream(){
    return _productRepository.getSavedProductsStream();
  }

}