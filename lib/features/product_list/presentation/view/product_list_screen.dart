import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import 'package:tr_store_app/features/product_list/presentation/view/product_details.dart';

import '../../../../core/networking/internet_connectivity.dart';
import '../../../../core/view_state/view_state.dart';
import '../../../../core/view_state/view_state.dart';
import '../../../../core/view_state/view_state.dart';
import '../provider/product_list_provider.dart';
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  late final StreamSubscription _internetCheckSubscription;
  late final ProductListProvider _productListProvider;


  @override
  void initState() {
    _productListProvider = context.read<ProductListProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _internetCheckSubscription = InternetConnectivity().connectivityStream.listen((hasInternet) {
        _productListProvider.onConnectionUpdate(hasInternet);
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final productListProviderWatcher = context.watch<ProductListProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("Product List")),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16,16,16,0),
          child: loadViewWithState(productListProviderWatcher),
        ),
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
    List<Widget> products = [];

    for(var product in provider.productList) {
      products.add(productItem(product));
    }

    return SingleChildScrollView(
      child: Column(
        children: products,
      ),
    );
  }

  Widget productItem(ProductEntity product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.id.toString()??""),
                    Row(
                      children: [
                        Expanded(child: Text(product.name??"")),
                      ],
                    ),
                    Text(product.price.toString()??""),
                    Text(product.qty.toString()??""),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
