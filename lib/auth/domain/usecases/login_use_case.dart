import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/auth/domain/repositories/auth_repository.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';

@lazySingleton
class LoginUseCase extends UseCase<String, LoginUseCaseParams> {
  final AuthRepository _authRepository;
  LoginUseCase(this._authRepository);

  @override
  Future<Either<Failure, String>> call(LoginUseCaseParams params) {
    return _authRepository.login(
      username: params.username,
      password: params.password,
    );
  }
}

class LoginUseCaseParams {
  final String username;
  final String password;
  const LoginUseCaseParams({required this.username, required this.password});
}
