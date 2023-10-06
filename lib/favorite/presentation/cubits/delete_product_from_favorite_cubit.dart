import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/favorite/domain/usecases/delete_product_from_favorite_use_case.dart';

@lazySingleton
class DeleteProductFromFavoriteCubit extends Cubit<BaseState<Unit>> {
  final DeleteProductFromFavoriteUseCase _deleteProductFromCartUseCase;
  DeleteProductFromFavoriteCubit(this._deleteProductFromCartUseCase)
      : super(const BaseState());

  void deleteProductFromFavorite(String id) async {
    emit(state.setInProgressState());

    final params = DeleteProductFromFavoriteUseCaseParams(id);
    final result = await _deleteProductFromCartUseCase.call(params);

    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (data) => emit(state.setSuccessState(data)),
    );
  }
}
