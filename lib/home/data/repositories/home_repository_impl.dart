import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/enums/server_error_code.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/extentions/response_extension.dart';
import 'package:kortobaa_ecommerce/home/data/datasource/remote/home_remote_data_source.dart';
import 'package:kortobaa_ecommerce/home/data/models/product_model.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';
import 'package:kortobaa_ecommerce/home/domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;
  HomeRepositoryImpl(this._homeRemoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProductListByCategoryId(
      String categoryId) async {
    try {
      final result =
          await _homeRemoteDataSource.getProductListByCategoryId(categoryId);
      return Right(result.map((e) => e.toDomain()).toList());
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
