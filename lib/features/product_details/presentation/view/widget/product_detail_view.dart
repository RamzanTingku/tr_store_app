import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailsView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        loadImage(product.image),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name??'', style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 16)),
              const SizedBox(height: 16),
              Text(product.description??'', style: const TextStyle(
                  fontWeight: FontWeight.w400)),

              loaPriceView()

            ],
          ),
        ),
      ],
    );
  }


  Widget loadImage(String? imageUrl) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 1),
      ),
      child: CachedNetworkImage(
        height: 200.0,
        width: double.infinity,
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

  Widget loaPriceView() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          const Text("Unit Price", style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 16)),
          const SizedBox(width: 16,),
          Text(product.price.toString(), style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 16)),
        ],
      ),
    );
  }
}
