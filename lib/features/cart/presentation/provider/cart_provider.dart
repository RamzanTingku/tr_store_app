import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import 'package:tr_store_app/shared/utility/extensions.dart';

import '../../../../di/injection_container.dart';
import '../../../../main.dart';
import '../../../../shared/view_state/view_state.dart';
import '../../../product_list/domain/usecases/get_saved_products.dart';
import '../../../product_list/domain/usecases/remove_product.dart';
import '../../../product_list/domain/usecases/update_product.dart';
import '../../../product_list/presentation/provider/product_list_provider.dart';

class CartProvider extends ChangeNotifier {

  late final GetSavedProductsUseCase _getSavedProductsUseCase = sl();
  late final UpdateProductUseCase _updateProductUseCase = sl();

  var viewState = ViewStates.loading;
  var cartList = <ProductEntity>[];
  var productList = <ProductEntity>[];
  String error = "Something error!";

  double totalPrice = 0;

  Future<void> getAddedProducts() async {
    productList = await _getSavedProductsUseCase.getSavedProducts();
    totalPrice = 0;
    cartList = productList.where((element) => (element.qty??0)>0).toList();
    _updateTotalPrice();
    updateViewState(cartList);
  }

  void updateViewState(List<ProductEntity> productList) {
    if(productList.isNotEmpty == true){
      viewState = ViewStates.hasData;

    } else{
      viewState = ViewStates.noData;
      error = "No product added!";
    }
    notifyListeners();
  }

  Future<void> updateCart(
      {int? productIndex,
      int? cartIndex,
      required ProductEntity product,
      required int updatedQty}) async {

    if (productList.isEmpty) await getAddedProducts();

    product = product.updateQty(updatedQty>0 ? updatedQty : 0);

    ///update view
    _updateCartList(cartIndex, product);
    _updateProductList(productIndex, product);
    _updateTotalPrice();
    _updateOtherProviders();

    ///update database
    _updateProductUseCase.updateProducts(product);
  }

  void _updateOtherProviders(){
    navigatorKey.currentContext!.read<ProductListProvider>().productList = productList;
    updateViewState(cartList);
  }

  void _updateCartList(int? cartIndex, ProductEntity entity) {
    int index = (cartIndex != null && cartList.length > cartIndex)
        ? cartIndex
        : cartList.indexWhere((element) => element.id == entity.id);

    if (!index.isNegative) {
      if ((entity.qty ?? 0) > 0) {
        cartList[index] = entity;
      }else{
        cartList.removeAt(index);
      }
    } else {
      cartList.add(entity);
    }
  }

  void _updateProductList(int? productIndex, ProductEntity entity) {
    int index = (productIndex != null && cartList.length > productIndex)
        ? productIndex
        : productList.indexWhere((element) => element.id == entity.id);

    if(!index.isNegative){
      productList[index] = entity;
    }
  }

  void _updateTotalPrice(){
    totalPrice = 0;
    for (var element in cartList) {
      if((element.qty??0)>0){
        totalPrice += (element.qty??0)*(element.price??0);
      }
    }
  }
}