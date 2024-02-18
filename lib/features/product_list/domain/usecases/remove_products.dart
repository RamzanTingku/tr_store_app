import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import '../repository/product_repository.dart';

class RemoveProductUseCase{

  final ProductRepository _productRepository;

  RemoveProductUseCase(this._productRepository);

  Future<void> removeProduct() async{
    return await _productRepository.removeProducts();
  }

}