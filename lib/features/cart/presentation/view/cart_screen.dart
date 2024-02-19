import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import 'package:tr_store_app/shared/widgets/common_app_bar.dart';
import '../../../../shared/view_state/view_state.dart';
import '../provider/cart_provider.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  late final CartProvider _cartProvider;

  @override
  void initState() {
    _cartProvider = context.read<CartProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _cartProvider.getAddedProducts();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final productListProviderWatcher = context.watch<CartProvider>();
    return Scaffold(
      appBar: CommonAppBar.getAppBar(context: context, title: "Cart"),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16,16,16,0),
          child: loadViewWithState(productListProviderWatcher),
        ),
      ),
    );
  }

  Widget loadViewWithState(CartProvider provider){
    return provider.viewState == ViewStates.loading ? const Center(child: Text("Loading..."))
        : provider.viewState == ViewStates.hasData ? showProducts(provider)
        : Center(child: Text(provider.error));
  }


  Widget showProducts(CartProvider provider) {
    List<Widget> products = [];

    for(var product in provider.cartList) {
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
