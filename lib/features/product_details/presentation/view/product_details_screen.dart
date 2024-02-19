import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tr_store_app/features/product_details/presentation/view/widget/product_detail_view.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';

import '../../../../../config/theme/app_themes.dart';
import '../../../../../shared/view_state/view_state.dart';
import '../../../../../shared/widgets/common_app_bar.dart';
import '../../../cart/presentation/provider/cart_provider.dart';
import '../provider/product_details_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;
  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  late final ProductDetailsProvider _productDetailsProvider;

  @override
  void initState() {
    _productDetailsProvider = context.read<ProductDetailsProvider>();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _productDetailsProvider.getProduct(
          productId: widget.product.id??-999,
          qty: widget.product.qty);
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerWatcher = context.watch<ProductDetailsProvider>();
    return Scaffold(
      appBar: CommonAppBar.getAppBarWithCart(context: context, title: "Product Details"),
      body: SafeArea(
        child: loadViewWithState(providerWatcher),
      ),
      bottomNavigationBar: loadAddRemoveButton(providerWatcher),
    );
  }

  Widget loadViewWithState(ProductDetailsProvider provider){
    return provider.viewState == ViewStates.loading ? const Center(child: Text("Loading..."))
        : (provider.viewState == ViewStates.hasData && provider.product != null) ? showProduct(provider)
        : Center(child: Text(provider.error));
  }

  Widget showProduct(ProductDetailsProvider provider) {
    return SingleChildScrollView(
      child: ProductDetailsView(product: provider.product!),
    );
  }

  Widget loadAddRemoveButton(ProductDetailsProvider provider) {

    if(provider.product == null){
      return const SizedBox.shrink();
    }

    final cartProvider = context.watch<CartProvider>();
    final int qty = provider.product!.qty??0;
    final bool added = qty>0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  cartProvider.updateCart(
                      product: provider.product!,
                      updatedQty: added ? 0 : qty + 1);
                }, child: Text(added ? "Remove" : "Add")),
          )
        ],
      ),
    );
  }
}
