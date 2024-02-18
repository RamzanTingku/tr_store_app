import 'package:floor/floor.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';

@Entity(tableName: 'product', primaryKeys: ['id'])
class ProductModel extends ProductEntity{

  const ProductModel({
    required int  id,
    String ? name,
    String ? description,
    String ? image,
    String ? thumbnail,
    double ? price,
  }): super(
    id: id,
    name: name,
    description: description,
    image: image,
    thumbnail: thumbnail,
    price: price,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      description: json['content'],
      name: json['title'],
      image: json['image'],
      thumbnail: json['thumbnail'],
      price:  double.tryParse(json['userId']?.toString()??"0"),
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
        id: entity.id??0,
        name: entity.name,
        description: entity.description,
        image: entity.image,
        thumbnail: entity.thumbnail,
        price: entity.price
    );
  }
}

