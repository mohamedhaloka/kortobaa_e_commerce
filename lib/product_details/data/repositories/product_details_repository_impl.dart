import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/enums/server_error_code.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/extentions/response_extension.dart';
import 'package:kortobaa_ecommerce/home/data/models/product_model.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';
import 'package:kortobaa_ecommerce/product_details/data/datasource/remote/product_details_remote_data_source.dart';
import 'package:kortobaa_ecommerce/product_details/domain/repositories/product_details_repository.dart';

@LazySingleton(as: ProductDetailsRepository)
class ProductDetailsRepositoryImpl extends ProductDetailsRepository {
  final ProductDetailsRemoteDataSource _productDetailsRemoteDataSource;
  ProductDetailsRepositoryImpl(this._productDetailsRemoteDataSource);

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      final result = await _productDetailsRemoteDataSource.getProductById(id);
      return Right(result.toDomain());
    } on ServerFailure catch (e) {
      return Left(e);
    } on DioException catch (e) {
      return Left(ServerFailure(
        errorCode: ServerErrorCode.serverError,
        message: e.response.getErrorMessage()!,
      ));
    }
  }
}
