import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tr_store_app/config/routes/route_constants.dart';
import 'package:tr_store_app/features/cart/presentation/provider/cart_provider.dart';

class CommonAppBar{

  static getAppBarWithCart(
      {required String title, required BuildContext context}) {
    final provider = context.watch<CartProvider>();
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.w500),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteConstants.cart);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Stack(
              children: [
                const Positioned(
                  top: 0, bottom: 0,
                  child: Icon(
                    Icons.shopping_cart
                  ),
                ),
                Positioned(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(provider.cartList.length.toString(), style: const TextStyle(
                        color: Colors.greenAccent, fontWeight: FontWeight.w600
                      )),
                    )
                )
              ],
            ),
          ),
        ),
      ],
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  static getAppBar(
      {required String title, required BuildContext context}) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.w500),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

}