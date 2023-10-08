import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/favorite/domain/repositories/favorite_repository.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

@lazySingleton
class GetFavoriteProductUseCase
    extends UseCase<Product?, GetFavoriteProductUseCaseParams> {
  final FavoriteRepository _favoriteRepository;
  GetFavoriteProductUseCase(this._favoriteRepository);

  @override
  Future<Either<Failure, Product?>> call(
      GetFavoriteProductUseCaseParams params) {
    return _favoriteRepository.getProduct(params.id);
  }
}

class GetFavoriteProductUseCaseParams {
  final String id;
  const GetFavoriteProductUseCaseParams({required this.id});
}
