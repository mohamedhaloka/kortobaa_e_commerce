import 'package:dartz/dartz.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<Product>>> getFavoriteProductsList();

  Future<Either<Failure, int>> addProduct(Product product);

  Future<Either<Failure, Unit>> deleteProduct(String id);
}
