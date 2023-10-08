import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/favorite/domain/usecases/get_favorite_product_list_use_case.dart';
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/add_product_to_favorite_cubit.dart';
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/delete_product_from_favorite_cubit.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

@injectable
class GetFavoriteProductListCubit extends Cubit<BaseState<List<Product>>> {
  final GetFavoriteProductListUseCase _getFavoriteProductListUseCase;
  final AddProductToFavoriteCubit _addProductToFavoriteCubit;
  final DeleteProductFromFavoriteCubit _deleteProductFromFavoriteCubit;

  GetFavoriteProductListCubit(this._getFavoriteProductListUseCase,
      this._deleteProductFromFavoriteCubit, this._addProductToFavoriteCubit)
      : super(const BaseState()) {
    _addProductToFavoriteStreamSubscription =
        _addProductToFavoriteCubit.stream.listen((event) {
      getFavoriteProductList();
    });
    _deleteProductFromFavoriteStreamSubscription =
        _deleteProductFromFavoriteCubit.stream.listen(
      (event) => getFavoriteProductList(),
    );
  }

  StreamSubscription<BaseState>? _addProductToFavoriteStreamSubscription;
  StreamSubscription<BaseState>? _deleteProductFromFavoriteStreamSubscription;

  void getFavoriteProductList() async {
    emit(state.setInProgressState());

    final result = await _getFavoriteProductListUseCase.call(const NoParams());

    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (data) => emit(state.setSuccessState(data)),
    );
  }

  @override
  Future<void> close() {
    _addProductToFavoriteStreamSubscription?.cancel();
    _deleteProductFromFavoriteStreamSubscription?.cancel();
    return super.close();
  }
}
