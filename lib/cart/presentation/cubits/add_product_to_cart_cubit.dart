import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/add_product_to_cart_use_case.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

@lazySingleton
class AddProductToCartCubit extends Cubit<BaseState<int>> {
  final AddProductToCartUseCase _addProductToCartUseCase;
  AddProductToCartCubit(this._addProductToCartUseCase)
      : super(const BaseState());

  void addProductToCart(Product product) async {
    emit(state.setInProgressState());

    final params = AddProductToCartUseCaseParams(product);
    final result = await _addProductToCartUseCase.call(params);

    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (data) => emit(state.setSuccessState(data)),
    );
  }
}
