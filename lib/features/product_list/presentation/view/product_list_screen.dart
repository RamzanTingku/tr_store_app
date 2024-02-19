import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import 'package:tr_store_app/features/product_list/presentation/view/widgets/product_item.dart';
import 'package:tr_store_app/shared/utility/extensions.dart';
import 'package:tr_store_app/shared/widgets/common_app_bar.dart';

import '../../../../core/networking/internet_connectivity.dart';
import '../../../../shared/view_state/view_state.dart';
import '../../../cart/presentation/provider/cart_provider.dart';
import '../provider/product_list_provider.dart';
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  late final StreamSubscription _internetCheckSubscription;
  late final ProductListProvider _productListProvider;
  late final CartProvider _cartProvider;


  @override
  void initState() {
    _productListProvider = context.read<ProductListProvider>();
    _cartProvider = context.read<CartProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _internetCheckSubscription = InternetConnectivity().connectivityStream.listen((hasInternet) {
        _productListProvider.onConnectionUpdate(hasInternet, _cartProvider);
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final productListProviderWatcher = context.watch<ProductListProvider>();
    return Scaffold(
      appBar: CommonAppBar.getAppBarWithCart(context: context, title: "Product List"),
      body: SafeArea(
        child: loadViewWithState(productListProviderWatcher),
      ),
    );
  }

  Widget loadViewWithState(ProductListProvider provider){
    return provider.viewState == ViewStates.loading ? const Center(child: Text("Loading..."))
        : provider.viewState == ViewStates.hasData ? showProducts(provider)
        : Center(child: Text(provider.error));
  }


  @override
  void dispose() {
    _internetCheckSubscription.cancel();
    super.dispose();
  }

  Widget showProducts(ProductListProvider provider) {
    return ListView.builder(
      itemCount: provider.productList.length,
      padding: const EdgeInsets.only(top: 16),
      clipBehavior: Clip.hardEdge,
      itemBuilder: (context, index) {
        return productItem(index, provider.productList[index]);
      },
    );
  }

  Widget productItem(int index, ProductEntity product) {
    return ProductItem(
      product: product,
      onRemove: (){
        _cartProvider.updateCart(productIndex: index, product: product, updatedQty: 0);
      },
      onAdd: (){
        _cartProvider.updateCart(productIndex: index, product: product, updatedQty: 1);
      },
    );
  }
}
