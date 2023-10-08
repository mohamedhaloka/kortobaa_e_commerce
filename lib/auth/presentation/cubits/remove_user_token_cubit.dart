import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/auth/domain/usecases/remove_user_token_use_case.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';

@injectable
class RemoveUserTokenCubit extends Cubit<BaseState<Unit>> {
  final RemoveUserTokenUseCase _removeUserTokenUseCase;
  RemoveUserTokenCubit(this._removeUserTokenUseCase) : super(const BaseState());

  void removeUserToken() async {
    await _removeUserTokenUseCase.call(const NoParams());
  }
}
