import 'dart:async';
import 'package:floor/floor.dart';
import 'package:tr_store_app/features/product_list/data/models/product_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../../features/product_list/data/data_sources/local/products_dao.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [ProductModel])
abstract class AppDatabase extends FloorDatabase {
  ProductsDao get productDAO;
}