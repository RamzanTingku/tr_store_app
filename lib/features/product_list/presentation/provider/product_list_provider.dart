import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:tr_store_app/core/data_state/data_state.dart';
import 'package:tr_store_app/core/utility/extensions.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import 'package:tr_store_app/features/product_list/domain/usecases/get_products.dart';

import '../../../../core/networking/internet_connectivity.dart';
import '../../../../core/view_state/view_state.dart';
import '../../../../di/injection_container.dart';
import '../../domain/usecases/get_saved_products.dart';
import '../../domain/usecases/update_products.dart';

class ProductListProvider extends ChangeNotifier {

  late final GetProductsUseCase _getProductsUseCase = sl();
  late final GetSavedProductsUseCase _getSavedProductsUseCase = sl();
  late final UpdateProductsUseCase _updateProductsUseCase = sl();

  var viewState = ViewStates.loading;
  bool hasInternet = true;

  var productList = <ProductEntity>[];
  String error = "Something error!";


  Future<void> getProducts({bool hasInternet = false, bool onRefresh = false}) async {
    this.hasInternet = onRefresh ? await InternetConnectivity().checkInternet() : hasInternet;
    DataState<List<ProductEntity>>? result;
    if(hasInternet){
      result = await _getProductsUseCase.getProducts();
      ///saving into database
      if(result.data?.isNotEmpty == true) {
        await _updateProductsUseCase.updateProducts(result.data ?? []);
      }
    }
    productList = await _getSavedProductsUseCase.getSavedProducts();

    updateViewState(productList, result);
  }

  void updateViewState(List<ProductEntity> productList, DataState<List<ProductEntity>>? result) {
    if(productList.isNotEmpty == true){
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

  void onConnectionUpdate(bool hasInternet){
    this.hasInternet = hasInternet;
    getProducts(hasInternet: hasInternet);
  }
}