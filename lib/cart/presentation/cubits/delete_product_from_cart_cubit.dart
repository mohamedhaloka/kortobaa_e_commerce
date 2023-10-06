import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/delete_product_from_cart_use_case.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';

@lazySingleton
class DeleteProductFromCartCubit extends Cubit<BaseState<Unit>> {
  final DeleteProductFromCartUseCase _deleteProductFromCartUseCase;
  DeleteProductFromCartCubit(this._deleteProductFromCartUseCase)
      : super(const BaseState());

  void deleteProductFromCart(String id) async {
    emit(state.setInProgressState());

    final params = DeleteProductFromCartUseCaseParams(id);
    final result = await _deleteProductFromCartUseCase.call(params);

    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (data) => emit(state.setSuccessState(data)),
    );
  }
}
