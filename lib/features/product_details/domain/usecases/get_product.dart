import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import '../../../../core/data_state/data_state.dart';
import '../repository/product_repository.dart';

class GetProductUseCase{

  final ProductRepository _productRepository;

  GetProductUseCase(this._productRepository);

  Future<DataState<ProductEntity>> getProducts(int? id) async{
    return await _productRepository.getProduct(id);
  }

}