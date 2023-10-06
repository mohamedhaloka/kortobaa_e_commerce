import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/home/data/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class CartLocalDataSource {
  Future<List<ProductModel>> getCartProductsList();

  Future<int> addProduct(ProductModel product);

  Future<void> deleteProduct(String id);
}

@LazySingleton(as: CartLocalDataSource)
class CartLocalDataSourceImpl extends CartLocalDataSource {
  Future<Database> _initializeCartDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      '${path}cart.db',
      onCreate: (database, version) async {
        await database.execute(
          '''CREATE TABLE CartProducts(id INTEGER NOT NULL UNIQUE,  
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
      'CartProducts',
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  @override
  Future<List<ProductModel>> getCartProductsList() async {
    final db = await _initializeCartDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('CartProducts');
    return queryResult.map((e) => ProductModel.fromJson(e)).toList();
  }

  @override
  Future<void> deleteProduct(String id) async {
    final db = await _initializeCartDB();
    try {
      await db.delete('CartProducts', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      log('Something went wrong when deleting an item: $err');
    }
  }
}
