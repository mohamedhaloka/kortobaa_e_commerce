import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/respositories/cart_repository.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

@lazySingleton
class AddProductToCartUseCase
    extends UseCase<int, AddProductToCartUseCaseParams> {
  final CartRepository _cartRepository;
  AddProductToCartUseCase(this._cartRepository);

  @override
  Future<Either<Failure, int>> call(AddProductToCartUseCaseParams params) {
    return _cartRepository.addProduct(params.product);
  }
}

class AddProductToCartUseCaseParams {
  final Product product;
  AddProductToCartUseCaseParams(this.product);
}
