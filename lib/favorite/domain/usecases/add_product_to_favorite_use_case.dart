import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/favorite/domain/repositories/favorite_repository.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

@lazySingleton
class AddProductToFavoriteUseCase
    extends UseCase<int, AddProductToFavoriteUseCaseParams> {
  final FavoriteRepository _favoriteRepository;
  AddProductToFavoriteUseCase(this._favoriteRepository);

  @override
  Future<Either<Failure, int>> call(AddProductToFavoriteUseCaseParams params) {
    return _favoriteRepository.addProduct(params.product);
  }
}

class AddProductToFavoriteUseCaseParams {
  final Product product;
  AddProductToFavoriteUseCaseParams(this.product);
}
