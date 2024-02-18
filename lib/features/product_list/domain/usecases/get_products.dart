import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import '../../../../core/data_state/data_state.dart';
import '../repository/products_repository.dart';

class GetProductsUseCase{
  
  final ProductsRepository _productRepository;

  GetProductsUseCase(this._productRepository);

  Future<DataState<List<ProductEntity>>> getProducts() async{
    return await _productRepository.getProducts();
  }
  
}