import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tr_store_app/features/product_list/presentation/provider/product_list_provider.dart';

import '../../../../core/networking/internet_connectivity.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  late final StreamSubscription internetCheckSubscription;

  @override
  void initState() {
    internetCheckSubscription = InternetConnectivity().connectivityStream.listen((hasInternet) {
      print("ProductDetails $hasInternet");
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    context.read<ProductListProvider>().getProducts();
    return const Placeholder();
  }


  @override
  void dispose() {
    internetCheckSubscription.cancel();
    super.dispose();
  }
}
