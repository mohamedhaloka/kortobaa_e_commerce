import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';
import 'package:kortobaa_ecommerce/product_details/domain/usecases/get_product_by_id_use_case.dart';

@injectable
class GetProductByIdCubit extends Cubit<BaseState<Product>> {
  final GetProductByIdUseCase _getProductByIdUseCase;
  GetProductByIdCubit(this._getProductByIdUseCase) : super(const BaseState());

  void getProductById(String id) async {
    emit(state.setInProgressState());
    final params = GetProductByIdUseCaseParams(id: id);
    final result = await _getProductByIdUseCase.call(params);

    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (data) => emit(state.setSuccessState(data)),
    );
  }
}
