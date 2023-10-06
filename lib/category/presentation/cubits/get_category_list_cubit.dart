import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/category/domain/entities/category.dart';
import 'package:kortobaa_ecommerce/category/domain/usecases/get_category_list_use_case.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';

@injectable
class GetCategoryListCubit extends Cubit<BaseState<List<Category>>> {
  final GetCategoryListUseCase _getCategoryListUseCase;
  GetCategoryListCubit(this._getCategoryListUseCase) : super(const BaseState());

  void getAllCategories() async {
    emit(state.setInProgressState());

    final result = await _getCategoryListUseCase.call(NoParams());

    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (categories) => emit(state.setSuccessState(categories)),
    );
  }
}
