import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/auth/domain/usecases/login_use_case.dart';
import 'package:kortobaa_ecommerce/auth/domain/usecases/set_logged_user_token_use_case.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';

@injectable
class LoginCubit extends Cubit<BaseState> {
  final LoginUseCase _loginUseCase;
  final SetLoggedUserTokenUseCase _setLoggedUserTokenUseCase;
  LoginCubit(this._loginUseCase, this._setLoggedUserTokenUseCase)
      : super(const BaseState());

  void login({required String username, required String password}) async {
    emit(state.setInProgressState());
    final params = LoginUseCaseParams(username: username, password: password);
    final result = await _loginUseCase.call(params);

    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (token) {
        final param = SetLoggedUserTokenUseCaseParams(token: token);
        _setLoggedUserTokenUseCase.call(param);
        emit(state.setSuccessState(token));
      },
    );
  }
}
