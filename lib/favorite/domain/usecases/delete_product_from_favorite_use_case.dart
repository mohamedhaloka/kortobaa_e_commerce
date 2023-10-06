import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/favorite/domain/repositories/favorite_repository.dart';

@lazySingleton
class DeleteProductFromFavoriteUseCase
    extends UseCase<Unit, DeleteProductFromFavoriteUseCaseParams> {
  final FavoriteRepository _favoriteRepository;
  DeleteProductFromFavoriteUseCase(this._favoriteRepository);

  @override
  Future<Either<Failure, Unit>> call(
      DeleteProductFromFavoriteUseCaseParams params) {
    return _favoriteRepository.deleteProduct(params.id);
  }
}

class DeleteProductFromFavoriteUseCaseParams {
  final String id;
  DeleteProductFromFavoriteUseCaseParams(this.id);
}
