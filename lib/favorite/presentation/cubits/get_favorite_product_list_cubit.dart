import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/favorite/domain/usecases/get_favorite_product_list_use_case.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

@lazySingleton
class GetFavoriteProductListCubit extends Cubit<BaseState<List<Product>>> {
  final GetFavoriteProductListUseCase _getFavoriteProductListUseCase;
  GetFavoriteProductListCubit(this._getFavoriteProductListUseCase)
      : super(const BaseState());

  void getFavoriteProductList() async {
    emit(state.setInProgressState());

    final result = await _getFavoriteProductListUseCase.call(const NoParams());

    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (data) => emit(state.setSuccessState(data)),
    );
  }
}
