import 'package:dartz/dartz.dart';
import 'package:kortobaa_ecommerce/category/domain/entities/category.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
}
