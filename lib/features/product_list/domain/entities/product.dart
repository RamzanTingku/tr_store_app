import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable{
  final int? id;
  final String? name;
  final String? description;
  final double? price;
  final String? image;
  final String? thumbnail;
  final int? qty;

  const ProductEntity(
      {this.id,this.name, this.description, this.price, this.image, this.thumbnail, this.qty});

  @override
  List<Object?> get props {
    return [
      id
    ];
  }
}