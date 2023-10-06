import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/auth/domain/repositories/auth_repository.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';

@lazySingleton
class GetLoggedUserTokenUseCase extends UseCase<String, NoParams> {
  final AuthRepository _authRepository;
  GetLoggedUserTokenUseCase(this._authRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return _authRepository.getUserLoggedToken();
  }
}
