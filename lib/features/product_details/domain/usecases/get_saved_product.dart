import '../../../product_list/domain/entities/product.dart';
import '../repository/product_repository.dart';

class GetSavedProductUseCase{

  final ProductRepository _productRepository;

  GetSavedProductUseCase(this._productRepository);

  Future<ProductEntity?> getSavedProduct(int id) async{
    return await _productRepository.getSavedProduct(id);
  }

}