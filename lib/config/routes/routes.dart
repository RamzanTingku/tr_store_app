import 'package:flutter/material.dart';
import 'package:tr_store_app/config/routes/route_constants.dart';
import 'package:tr_store_app/features/cart/presentation/view/cart_screen.dart';
import 'package:tr_store_app/features/product_details/presentation/view/product_details_screen.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';

import '../../features/product_list/presentation/view/product_list_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case RouteConstants.productList:
        return _materialRoute(const ProductListScreen());

      case RouteConstants.productDetails:
        return _materialRoute(ProductDetailsScreen(product: settings.arguments as ProductEntity));

      case RouteConstants.cart:
        return _materialRoute(const CartScreen());

      default:
        return _materialRoute(const ProductListScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}