import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/respositories/cart_repository.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

@lazySingleton
class GetCartProductListUseCase extends UseCase<List<Product>, NoParams> {
  final CartRepository _cartRepository;
  GetCartProductListUseCase(this._cartRepository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return _cartRepository.getCartProductsList();
  }
}
