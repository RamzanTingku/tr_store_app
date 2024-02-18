import 'package:flutter/material.dart';
import 'package:tr_store_app/config/routes/route_constants.dart';

import '../../features/product_list/presentation/view/product_list_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case RouteConstants.productList:
        return _materialRoute(const ProductListScreen());

      default:
        return _materialRoute(const ProductListScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}