import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';
import 'package:tr_store_app/shared/view_state/product_list_type.dart';
import 'package:tr_store_app/shared/widgets/common_app_bar.dart';
import '../../../../config/theme/app_themes.dart';
import '../../../../shared/view_state/view_state.dart';
import '../../../product_list/presentation/view/widgets/product_item.dart';
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
    final provider = context.watch<CartProvider>();
    return Scaffold(
      appBar: CommonAppBar.getAppBar(context: context, title: "Cart"),
      body: SafeArea(
        child: loadViewWithState(provider),
      ),
      bottomNavigationBar: loadTotalPrice(),
    );
  }


  Widget loadViewWithState(CartProvider provider){
    return provider.viewState == ViewStates.loading ? const Center(child: Text("Loading..."))
        : provider.viewState == ViewStates.hasData ? showProducts(provider)
        : Center(child: Text(provider.error));
  }

  Widget showProducts(CartProvider provider) {
    return ListView.builder(
      itemCount: provider.cartList.length,
      padding: const EdgeInsets.only(top: 16),
      clipBehavior: Clip.hardEdge,
      itemBuilder: (context, index) {
        return productItem(index, provider.cartList[index]);
      },
    );
  }

  Widget productItem(int index, ProductEntity product) {
    return ProductItem(
      listType: ProductListType.cart,
      product: product,
      onUpdate: (qty){
        _cartProvider.updateCart(cartIndex: index, product: product, updatedQty: qty);
      },
    );
  }

  Widget loadTotalPrice() {
    final provider = context.watch<CartProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
                style: buttonStyle,
                onPressed: () {

                }, child: Text("Total ${provider.totalPrice}")),
          )
        ],
      ),
    );
  }
}
