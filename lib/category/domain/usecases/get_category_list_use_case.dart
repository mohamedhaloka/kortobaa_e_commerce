import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/category/domain/entities/category.dart';
import 'package:kortobaa_ecommerce/category/domain/repositories/category_repository.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';

@lazySingleton
class GetCategoryListUseCase extends UseCase<List<Category>, NoParams> {
  final CategoryRepository _categoryRepository;
  GetCategoryListUseCase(this._categoryRepository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) {
    return _categoryRepository.getAllCategories();
  }
}
