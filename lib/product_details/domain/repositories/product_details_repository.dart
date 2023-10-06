import 'package:dartz/dartz.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, Product>> getProductById(String id);
}
