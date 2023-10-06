import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/auth/domain/repositories/auth_repository.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';

@lazySingleton
class SetLoggedUserTokenUseCase
    extends UseCase<bool, SetLoggedUserTokenUseCaseParams> {
  final AuthRepository _authRepository;
  SetLoggedUserTokenUseCase(this._authRepository);

  @override
  Future<Either<Failure, bool>> call(SetLoggedUserTokenUseCaseParams params) {
    return _authRepository.setUserLoggedToken(params.token);
  }
}

class SetLoggedUserTokenUseCaseParams {
  final String token;
  SetLoggedUserTokenUseCaseParams({required this.token});
}
