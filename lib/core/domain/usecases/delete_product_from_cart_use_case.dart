import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/respositories/cart_repository.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';

@lazySingleton
class DeleteProductFromCartUseCase
    extends UseCase<Unit, DeleteProductFromCartUseCaseParams> {
  final CartRepository _cartRepository;
  DeleteProductFromCartUseCase(this._cartRepository);

  @override
  Future<Either<Failure, Unit>> call(
      DeleteProductFromCartUseCaseParams params) {
    return _cartRepository.deleteProduct(params.id);
  }
}

class DeleteProductFromCartUseCaseParams {
  final String id;
  DeleteProductFromCartUseCaseParams(this.id);
}
