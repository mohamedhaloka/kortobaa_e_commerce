import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/auth/domain/usecases/register_use_case.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';

@injectable
class RegisterCubit extends Cubit<BaseState> {
  final RegisterUseCase _registerUseCase;
  RegisterCubit(this._registerUseCase) : super(const BaseState());

  void register({
    required String username,
    required String password,
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    emit(state.setInProgressState());
    final params = RegisterUseCaseParams(
        username: username,
        password: password,
        email: email,
        firstName: firstName,
        lastName: lastName);
    final result = await _registerUseCase.call(params);

    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (successMsg) => emit(state.setSuccessState(successMsg)),
    );
  }
}
