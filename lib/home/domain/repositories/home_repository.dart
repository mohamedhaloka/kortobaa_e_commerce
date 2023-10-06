import 'package:dartz/dartz.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Product>>> getProductListByCategoryId(
      String categoryId);
}
