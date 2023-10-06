import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/favorite/domain/repositories/favorite_repository.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

@lazySingleton
class GetFavoriteProductListUseCase extends UseCase<List<Product>, NoParams> {
  final FavoriteRepository _favoriteRepository;
  GetFavoriteProductListUseCase(this._favoriteRepository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return _favoriteRepository.getFavoriteProductsList();
  }
}
