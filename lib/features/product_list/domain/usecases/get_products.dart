import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import '../../../../core/data/data_state.dart';
import '../repository/products_repository.dart';

class GetProductUseCase{
  
  final ProductsRepository _productRepository;

  GetProductUseCase(this._productRepository);

  Future<DataState<List<ProductEntity>>> getProducts() async{
    return await _productRepository.getProducts();
  }
  
}