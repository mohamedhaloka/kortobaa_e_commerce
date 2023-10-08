import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/respositories/cart_repository.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

@lazySingleton
class GetCartProductUseCase
    extends UseCase<Product?, GetCartProductUseCaseParams> {
  final CartRepository _cartRepository;
  GetCartProductUseCase(this._cartRepository);

  @override
  Future<Either<Failure, Product?>> call(GetCartProductUseCaseParams params) {
    return _cartRepository.getProduct(params.id);
  }
}

class GetCartProductUseCaseParams {
  final String id;
  const GetCartProductUseCaseParams({required this.id});
}
