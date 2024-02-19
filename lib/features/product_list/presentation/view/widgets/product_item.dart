import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';

import '../../../../../config/theme/app_themes.dart';
import '../../../../../shared/view_state/product_list_type.dart';

class ProductItem extends StatelessWidget {
  final ProductEntity product;
  final Function(int qty) onUpdate;
  final ProductListType listType;
  const ProductItem({Key? key, required this.product, required this.listType, required this.onUpdate}) : super(key: key);

  bool get isAdded => (product.qty??0) > 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      margin: const EdgeInsets.only(bottom: 14, right: 16, left: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(15, 15, 15, 0.15),
                spreadRadius: 0,
                blurRadius: 7,
                offset: Offset(0,-1)
            )
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          loadImage(product.thumbnail),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(product.name??"", style: const TextStyle(
                      fontWeight: FontWeight.w500
                    ),)),
                  ],
                ),
                loadDataLine("Unit Price", product.price.toString()),

                if(listType == ProductListType.cart)
                  loadDataLine("Quantity", product.qty.toString()),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(listType == ProductListType.cart)
                      loadElegantButton(),
                    loadAddRemoveButton()
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget loadDataLine(String label, String value){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Text(label),
          const SizedBox(width: 16,),
          Text(value),
        ],
      ),
    );
  }

  Widget loadImage(String? thumbnail) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 1),
      ),
      child: CachedNetworkImage(
        height: 50.0,
        width: 50.0,
        imageUrl: product.thumbnail ?? "",
        placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300] ?? Colors.blueGrey,
            highlightColor: Colors.grey[100] ?? Colors.blueGrey,
            child: Image.asset("assets/images/service_place_holder.png",
                fit: BoxFit.fill)),
        errorWidget: (context, url, error) => Image.asset("assets/images/service_place_holder.png",
            fit: BoxFit.fill),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget loadElegantButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 50,
          child: ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                onUpdate((product.qty??0)+1);
              }, child: const Text("+")),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 50,
          child: ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            onUpdate((product.qty??0)-1);
          }, child: const Text("-")),
        ),

        const SizedBox(width: 16),
      ],
    );
  }

  Widget loadAddRemoveButton() {
    return ElevatedButton(
        style: buttonStyle,
        onPressed: () {
          isAdded ? onUpdate(0) : onUpdate(1);
        }, child: Text(isAdded ? "Remove" : "Add"));
  }
}


