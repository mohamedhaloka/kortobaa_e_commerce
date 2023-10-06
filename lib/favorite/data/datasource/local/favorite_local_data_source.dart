import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/home/data/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class FavoriteLocalDataSource {
  Future<List<ProductModel>> getFavoriteProductsList();

  Future<int> addProduct(ProductModel product);

  Future<void> deleteProduct(String id);
}

@LazySingleton(as: FavoriteLocalDataSource)
class FavoriteLocalDataSourceImpl extends FavoriteLocalDataSource {
  Future<Database> _initializeCartDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      '${path}favorite.db',
      onCreate: (database, version) async {
        await database.execute(
          '''CREATE TABLE FavoriteProducts(id INTEGER NOT NULL UNIQUE,  
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            image_link TEXT NOT NULL,
            rate TEXT NOT NULL,
            quantity INTEGER NOT NULL,
            price TEXT NOT NULL)''',
        );
      },
      version: 1,
    );
  }

  @override
  Future<int> addProduct(ProductModel product) async {
    final Database db = await _initializeCartDB();

    final id = await db.insert(
      'FavoriteProducts',
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  @override
  Future<List<ProductModel>> getFavoriteProductsList() async {
    final db = await _initializeCartDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('FavoriteProducts');
    return queryResult.map((e) => ProductModel.fromJson(e)).toList();
  }

  @override
  Future<void> deleteProduct(String id) async {
    final db = await _initializeCartDB();
    try {
      await db.delete('FavoriteProducts', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      log('Something went wrong when deleting an item: $err');
    }
  }
}
