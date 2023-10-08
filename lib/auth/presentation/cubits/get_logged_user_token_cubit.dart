import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/auth/domain/usecases/get_logged_user_token_use_case.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';

@injectable
class GetLoggedUserTokenCubit extends Cubit<BaseState<String?>> {
  final GetLoggedUserTokenUseCase _getLoggedUserTokenUseCase;
  GetLoggedUserTokenCubit(this._getLoggedUserTokenUseCase)
      : super(const BaseState());

  void login() async {
    emit(state.setInProgressState());
    final result = await _getLoggedUserTokenUseCase.call(const NoParams());

    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (token) => emit(state.setSuccessState(token)),
    );
  }
}
