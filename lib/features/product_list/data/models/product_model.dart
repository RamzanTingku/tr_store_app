import 'package:floor/floor.dart';
import 'package:tr_store_app/features/product_list/domain/entities/product.dart';

@Entity(tableName: 'product',primaryKeys: ['id'])
class ProductModel extends ProductEntity{

  ProductModel({
    int ? id,
    String ? title,
    String ? content,
    String ? image,
    String ? thumbnail,
    String ? userId,
  }): super(
    id: id,
    name: title,
    description: content,
    image: image,
    thumbnail: thumbnail,
    price: double.tryParse(userId??"0"),
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      content: json['content'],
      title: json['title'],
      image: json['image'],
      thumbnail: json['thumbnail'],
      userId: json['userId']?.toString(),
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
        id: entity.id,
        title: entity.name,
        content: entity.description,
        image: entity.image,
        thumbnail: entity.thumbnail,
        userId: entity.price?.toString()
    );
  }
}

