import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import 'package:tr_store_app/features/product_list/domain/usecases/get_products.dart';

import '../../../../core/networking/internet_connectivity.dart';
import '../../../../core/view_state/view_state.dart';
import '../../../../di/injection_container.dart';
import '../../domain/usecases/get_saved_products.dart';
import '../../domain/usecases/remove_products.dart';
import '../../domain/usecases/save_products.dart';

class ProductListProvider extends ChangeNotifier {

  late final GetProductsUseCase _getProductsUseCase = sl();
  late final GetSavedProductsUseCase _getSavedProductsUseCase = sl();
  late final RemoveProductsUseCase _removeProductsUseCase = sl();
  late final SaveProductsUseCase _saveProductsUseCase = sl();

  var viewState = ViewStates.loading;
  bool hasInternet = true;

  var productList = <ProductEntity>[];
  String error = "Something error!";


  Future<void> getProducts() async {
    hasInternet = await InternetConnectivity().checkInternet();
    if(hasInternet){
      final result = await _getProductsUseCase.getProducts();

      if(result.data?.isNotEmpty == true){
        viewState = ViewStates.hasData;
        productList = result.data ?? [];

        ///saving into database
        _removeAndSaveProducts(productList);

      } else if(result.error != null){
        viewState = ViewStates.hasError;
        error = result.error?.message ?? error;

      }else{
        viewState = ViewStates.noData;
        error = "No data found!";
      }

    }else{
      viewState = ViewStates.noInternet;
      error = "No Internet!";

      productList = await _getSavedProductsUseCase.getSavedProducts();
      viewState = ViewStates.hasData;
    }
    notifyListeners();
  }

  Future<void> _removeAndSaveProducts(List<ProductEntity> products) async {
    await _removeProductsUseCase.removeProduct(products);
    await _saveProductsUseCase.saveProducts(products);
  }
}