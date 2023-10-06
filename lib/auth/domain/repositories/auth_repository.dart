import 'package:dartz/dartz.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login({
    required String username,
    required String password,
  });

  Future<Either<Failure, String>> register({
    required String username,
    required String password,
    required String email,
    required String firstName,
    required String lastName,
  });

  Future<Either<Failure, String>> getUserLoggedToken();

  Future<Either<Failure, bool>> setUserLoggedToken(String token);
}
