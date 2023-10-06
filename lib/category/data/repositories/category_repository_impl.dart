import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/category/data/datasource/remote/category_remote_data_source.dart';
import 'package:kortobaa_ecommerce/category/data/models/category_model.dart';
import 'package:kortobaa_ecommerce/category/domain/entities/category.dart';
import 'package:kortobaa_ecommerce/category/domain/repositories/category_repository.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/enums/server_error_code.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/extentions/response_extension.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryRemoteDataSource _categoryRemoteDataSource;
  CategoryRepositoryImpl(this._categoryRemoteDataSource);

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      final result = await _categoryRemoteDataSource.getAllCategories();
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
