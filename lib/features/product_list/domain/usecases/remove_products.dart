import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import '../repository/products_repository.dart';

class RemoveProductsUseCase{

  final ProductsRepository _productRepository;

  RemoveProductsUseCase(this._productRepository);

  Future<void> removeProduct(List<ProductEntity> products) async{
    return await _productRepository.removeProducts(products);
  }

}