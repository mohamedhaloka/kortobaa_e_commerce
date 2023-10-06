import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/auth/domain/repositories/auth_repository.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';

@lazySingleton
class RegisterUseCase extends UseCase<String, RegisterUseCaseParams> {
  final AuthRepository _authRepository;
  RegisterUseCase(this._authRepository);

  @override
  Future<Either<Failure, String>> call(RegisterUseCaseParams params) {
    return _authRepository.register(
      username: params.username,
      password: params.password,
      email: params.email,
      firstName: params.firstName,
      lastName: params.lastName,
    );
  }
}

class RegisterUseCaseParams {
  final String username;
  final String password;
  final String email;
  final String firstName;
  final String lastName;
  const RegisterUseCaseParams({
    required this.username,
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
  });
}
