import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';
import 'package:kortobaa_ecommerce/product_details/domain/repositories/product_details_repository.dart';

@lazySingleton
class GetProductByIdUseCase
    extends UseCase<Product, GetProductByIdUseCaseParams> {
  final ProductDetailsRepository _productDetailsRepository;
  GetProductByIdUseCase(this._productDetailsRepository);

  @override
  Future<Either<Failure, Product>> call(GetProductByIdUseCaseParams params) {
    return _productDetailsRepository.getProductById(params.id);
  }
}

class GetProductByIdUseCaseParams {
  final String id;

  GetProductByIdUseCaseParams({required this.id});
}
