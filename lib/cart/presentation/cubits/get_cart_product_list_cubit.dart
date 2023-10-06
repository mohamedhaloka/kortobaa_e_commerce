import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/cart/presentation/cubits/add_product_to_cart_cubit.dart';
import 'package:kortobaa_ecommerce/cart/presentation/cubits/delete_product_from_cart_cubit.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/get_cart_product_list_use_case.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

@lazySingleton
class GetCartProductListCubit extends Cubit<BaseState<List<Product>>> {
  final GetCartProductListUseCase _getCartProductListUseCase;
  final AddProductToCartCubit _addProductToCartCubit;
  final DeleteProductFromCartCubit _deleteProductFromCartCubit;
  GetCartProductListCubit(
    this._getCartProductListUseCase,
    this._addProductToCartCubit,
    this._deleteProductFromCartCubit,
  ) : super(const BaseState()) {
    _addProductToCartStreamSubscribtion =
        _addProductToCartCubit.stream.listen((event) {
      getCartProductList();
    });
    _deleteProductFromCartStreamSubscribtion =
        _deleteProductFromCartCubit.stream.listen(
      (event) => getCartProductList(),
    );
  }

  late StreamSubscription<BaseState> _addProductToCartStreamSubscribtion;
  late StreamSubscription<BaseState> _deleteProductFromCartStreamSubscribtion;

  void getCartProductList() async {
    emit(state.setInProgressState());

    final result = await _getCartProductListUseCase.call(const NoParams());

    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (data) => emit(state.setSuccessState(data)),
    );
  }

  @override
  Future<void> close() {
    _addProductToCartStreamSubscribtion.cancel();
    _deleteProductFromCartStreamSubscribtion.cancel();
    return super.close();
  }
}
