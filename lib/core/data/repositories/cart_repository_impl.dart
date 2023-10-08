import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/data/datasource/local/cart_local_data_source.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/enums/server_error_code.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/respositories/cart_repository.dart';
import 'package:kortobaa_ecommerce/home/data/models/product_model.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImpl extends CartRepository {
  final CartLocalDataSource _cartLocalDataSource;
  CartRepositoryImpl(this._cartLocalDataSource);

  @override
  Future<Either<Failure, int>> addProduct(Product product) async {
    try {
      final result = await _cartLocalDataSource.addProduct(product.toData());
      return right(result);
    } catch (e) {
      return left(ServerFailure(errorCode: ServerErrorCode.serverError));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    try {
      await _cartLocalDataSource.deleteProduct(id);
      return right(unit);
    } catch (e) {
      return left(ServerFailure(errorCode: ServerErrorCode.serverError));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getCartProductsList() async {
    try {
      final result = await _cartLocalDataSource.getCartProductsList();
      return right(result.map((e) => e.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(errorCode: ServerErrorCode.serverError));
    }
  }

  @override
  Future<Either<Failure, Product?>> getProduct(String id) async {
    try {
      final result = await _cartLocalDataSource.getProduct(id);
      return right(result?.toDomain());
    } catch (e) {
      return left(ServerFailure(errorCode: ServerErrorCode.serverError));
    }
  }
}
