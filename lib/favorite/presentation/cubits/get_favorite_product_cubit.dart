import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/favorite/domain/usecases/get_favorite_product_use_case.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

@lazySingleton
class GetFavoriteProductCubit extends Cubit<BaseState<Product?>> {
  final GetFavoriteProductUseCase _getFavoriteProductUseCase;
  GetFavoriteProductCubit(this._getFavoriteProductUseCase)
      : super(const BaseState());

  void getFavoriteProduct(String id) async {
    emit(state.setInProgressState());

    final params = GetFavoriteProductUseCaseParams(id: id);
    final result = await _getFavoriteProductUseCase.call(params);

    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (data) => emit(state.setSuccessState(data)),
    );
  }
}
