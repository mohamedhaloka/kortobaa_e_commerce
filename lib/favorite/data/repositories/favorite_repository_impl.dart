import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/enums/server_error_code.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/favorite/data/datasource/local/favorite_local_data_source.dart';
import 'package:kortobaa_ecommerce/home/data/models/product_model.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

import '../../domain/repositories/favorite_repository.dart';

@LazySingleton(as: FavoriteRepository)
class FavoriteRepositoryImpl extends FavoriteRepository {
  final FavoriteLocalDataSource _favoriteLocalDataSource;
  FavoriteRepositoryImpl(this._favoriteLocalDataSource);

  @override
  Future<Either<Failure, int>> addProduct(Product product) async {
    try {
      final result =
          await _favoriteLocalDataSource.addProduct(product.toData());
      return right(result);
    } catch (e) {
      return left(ServerFailure(errorCode: ServerErrorCode.serverError));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    try {
      await _favoriteLocalDataSource.deleteProduct(id);
      return right(unit);
    } catch (e) {
      return left(ServerFailure(errorCode: ServerErrorCode.serverError));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getFavoriteProductsList() async {
    try {
      final result = await _favoriteLocalDataSource.getFavoriteProductsList();
      return right(result.map((e) => e.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(errorCode: ServerErrorCode.serverError));
    }
  }

  @override
  Future<Either<Failure, Product?>> getProduct(String id) async {
    try {
      final result = await _favoriteLocalDataSource.getProduct(id);
      return right(result?.toDomain());
    } catch (e) {
      return left(ServerFailure(errorCode: ServerErrorCode.serverError));
    }
  }
}
