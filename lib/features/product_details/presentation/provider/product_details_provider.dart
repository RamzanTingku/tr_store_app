import 'package:flutter/widgets.dart';
import 'package:tr_store_app/features/product_list/data/models/product_model.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/networking/internet_connectivity.dart';
import '../../../../di/injection_container.dart';
import '../../../../shared/view_state/view_state.dart';
import '../../../product_list/domain/entities/product.dart';
import '../../domain/usecases/get_product.dart';
import '../../domain/usecases/get_saved_product.dart';

class ProductDetailsProvider  extends ChangeNotifier {

  late final GetProductUseCase _getProductUseCase = sl();
  late final GetSavedProductUseCase _getSavedProductUseCase = sl();

  var viewState = ViewStates.loading;
  bool hasInternet = true;

  ProductEntity? product;
  int? qty;
  String error = "Something error!";

  Future<void> getProduct({required int productId, int? qty}) async {
    showLoader();
    this.qty = qty;
    notifyListeners();
    hasInternet = InternetConnectivity().hasInternet;
    DataState<ProductEntity>? result;
    if(hasInternet){
      result = await _getProductUseCase.getProducts(productId);
      product = result.data;
    }else{
      product = await _getSavedProductUseCase.getSavedProduct(productId);
    }
    updateQty();
    updateViewState(product, result);
  }


  void updateViewState(ProductEntity? product, DataState<ProductEntity>? result) {
    if(product != null){
      viewState = ViewStates.hasData;

    } else if(result?.error != null){
      viewState = ViewStates.hasError;
      error = result?.error?.message ?? error;

    }else{
      viewState = ViewStates.noData;
      error = "No data found!";
    }

    notifyListeners();
  }

  void updateQty(){
    if(product!=null && qty != null) {
      product = ProductModel.updateQty(product!, qty!);
    }
  }

  void showLoader() {
    viewState = ViewStates.loading;
    notifyListeners();
  }

}