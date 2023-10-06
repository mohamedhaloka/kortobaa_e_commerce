import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';
import 'package:kortobaa_ecommerce/home/domain/usecases/get_product_list_by_category_id_use_case.dart';

@injectable
class GetProductListByCategoryIdCubit extends Cubit<BaseState<List<Product>>> {
  final GetProductListByCategoryIdUseCase _getCategoryListByCategoryIdUseCase;
  GetProductListByCategoryIdCubit(this._getCategoryListByCategoryIdUseCase)
      : super(const BaseState());

  void getProductsByCategoryId(String categoryId) async {
    emit(state.setInProgressState());
    final params =
        GetProductListByCategoryIdUseCaseParams(categoryId: categoryId);
    final result = await _getCategoryListByCategoryIdUseCase.call(params);

    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (data) => emit(state.setSuccessState(data)),
    );
  }
}
