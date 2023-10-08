import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/get_cart_product_use_case.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

@lazySingleton
class GetCartProductCubit extends Cubit<BaseState<Product?>> {
  final GetCartProductUseCase _getCartProductUseCase;
  GetCartProductCubit(
    this._getCartProductUseCase,
  ) : super(const BaseState());

  void getCartProduct(String id) async {
    emit(state.setInProgressState());

    final params = GetCartProductUseCaseParams(id: id);
    final result = await _getCartProductUseCase.call(params);

    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (data) => emit(state.setSuccessState(data)),
    );
  }
}
