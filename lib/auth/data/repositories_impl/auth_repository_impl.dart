import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/auth/data/datasource/local/auth_local_data_source.dart';
import 'package:kortobaa_ecommerce/auth/data/datasource/remote/auth_remote_data_source.dart';
import 'package:kortobaa_ecommerce/auth/domain/repositories/auth_repository.dart';
import 'package:kortobaa_ecommerce/core/data/models/exceptions.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/enums/server_error_code.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/extentions/response_extension.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  AuthRepositoryImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<Either<Failure, String>> login({
    required String username,
    required String password,
  }) async {
    try {
      final result = await _authRemoteDataSource.login(
        username: username,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        errorCode: ServerErrorCode.notFound,
        message: e.message,
      ));
    } on DioException catch (e) {
      return Left(ServerFailure(
        errorCode: ServerErrorCode.notFound,
        message: e.response.getErrorMessage()!,
      ));
    }
  }

  @override
  Future<Either<Failure, String>> register({
    required String username,
    required String password,
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final result = await _authRemoteDataSource.register(
        username: username,
        password: password,
        email: email,
        firstName: firstName,
        lastName: lastName,
      );
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(
        errorCode: ServerErrorCode.notFound,
        message: e.message,
      ));
    } on DioException catch (e) {
      return Left(ServerFailure(
        errorCode: ServerErrorCode.notFound,
        message: e.response.getErrorMessage()!,
      ));
    }
  }

  @override
  Future<Either<Failure, String?>> getUserLoggedToken() async {
    try {
      final token = await _authLocalDataSource.getUserLoggedToken();
      return Right(token);
    } on Exception catch (_) {
      return Left(ServerFailure(errorCode: ServerErrorCode.notFound));
    }
  }

  @override
  Future<Either<Failure, bool>> setUserLoggedToken(String token) async {
    try {
      final hasStoreToken =
          await _authLocalDataSource.setUserLoggedToken(token);
      return Right(hasStoreToken);
    } on Exception catch (_) {
      return Left(ServerFailure(errorCode: ServerErrorCode.notFound));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeUserToken() async {
    try {
      await _authLocalDataSource.removeUserToken();
      return const Right(unit);
    } on Exception catch (_) {
      return Left(ServerFailure(errorCode: ServerErrorCode.notFound));
    }
  }
}
