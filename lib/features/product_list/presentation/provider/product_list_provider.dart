import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:tr_store_app/core/data_state/data_state.dart';
import 'package:tr_store_app/features/cart/presentation/provider/cart_provider.dart';
import 'package:tr_store_app/features/product_list/data/models/product_model.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import 'package:tr_store_app/features/product_list/domain/usecases/get_products.dart';
import 'package:tr_store_app/shared/utility/extensions.dart';

import '../../../../core/networking/internet_connectivity.dart';
import '../../../../shared/view_state/view_state.dart';
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
  var cartList = <ProductEntity>[];
  String error = "Something error!";


  Future<void> getProducts({bool hasInternet = false, bool onRefresh = false}) async {
    this.hasInternet = onRefresh ? await InternetConnectivity().checkInternet() : hasInternet;
    DataState<List<ProductEntity>>? result;
    productList = await _getSavedProductsUseCase.getSavedProducts();
    if(hasInternet){
      result = await _getProductsUseCase.getProducts();
      ///saving into database
      if(result.data?.isNotEmpty == true) {
        var carts = productList.where((element) => (element.qty??0)>0).toList();
        final list = result.data?.map((e) {
          return carts.firstWhere((element) => element.id == e.id, orElse: ()=> ProductModel.fromEntity(e));
        }).toList();
        await _updateProductsUseCase.updateProducts(list??[]);
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

  Future<void> onConnectionUpdate(bool hasInternet, CartProvider cartProvider) async {
    this.hasInternet = hasInternet;
    await getProducts(hasInternet: hasInternet);
    await cartProvider.getAddedProducts();
  }

  Future<void> updateCart(int index, ProductEntity product, int updatedQty) async {
    int qty = product.qty ?? 0;
    product = product.updateQty(qty+updatedQty);
    _updateProductList(index, product);
    notifyListeners();
  }

  void _updateProductList(int index, ProductEntity entity) {
    if(productList.length > index) {
      productList[index] = entity;
    }
  }
}