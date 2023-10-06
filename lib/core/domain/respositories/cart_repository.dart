import 'package:dartz/dartz.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

abstract class CartRepository {
  Future<Either<Failure, List<Product>>> getCartProductsList();

  Future<Either<Failure, int>> addProduct(Product product);

  Future<Either<Failure, Unit>> deleteProduct(String id);
}
