import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';
import 'package:kortobaa_ecommerce/home/domain/repositories/home_repository.dart';

@lazySingleton
class GetProductListByCategoryIdUseCase
    extends UseCase<List<Product>, GetProductListByCategoryIdUseCaseParams> {
  final HomeRepository _homeRepository;
  GetProductListByCategoryIdUseCase(this._homeRepository);

  @override
  Future<Either<Failure, List<Product>>> call(
      GetProductListByCategoryIdUseCaseParams params) {
    return _homeRepository.getProductListByCategoryId(params.categoryId);
  }
}

class GetProductListByCategoryIdUseCaseParams {
  final String categoryId;

  GetProductListByCategoryIdUseCaseParams({required this.categoryId});
}
