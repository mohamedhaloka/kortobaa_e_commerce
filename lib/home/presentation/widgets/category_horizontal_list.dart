import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kortobaa_ecommerce/category/domain/entities/category.dart';
import 'package:kortobaa_ecommerce/category/presentation/cubits/get_category_list_cubit.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/core/presentation/widgets/error_view.dart';
import 'package:kortobaa_ecommerce/core/presentation/widgets/loader.dart';
import 'package:kortobaa_ecommerce/injection.dart';

class CategoriesHorizontalList extends StatefulWidget {
  const CategoriesHorizontalList({super.key});

  @override
  State<CategoriesHorizontalList> createState() =>
      _CategoriesHorizontalListState();
}

class _CategoriesHorizontalListState extends State<CategoriesHorizontalList> {
  final GetCategoryListCubit _getCategoryListCubit =
      getIt<GetCategoryListCubit>();

  @override
  void initState() {
    _getCategoryListCubit.getAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: BlocBuilder<GetCategoryListCubit, BaseState<List<Category>>>(
        bloc: _getCategoryListCubit,
        builder: (_, state) {
          if (state.isSuccess) {
            return SizedBox(
              height: 88,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, int index) => Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                          image: DecorationImage(
                              image: NetworkImage(state.item![index].imageLink),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(height: 8),
                    Text(state.item![index].name),
                  ],
                ),
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: state.item!.length,
              ),
            );
          } else if (state.isFailure) {
            return ErrorView(failure: state.failure);
          } else {
            return const Loader();
          }
        },
      ),
    );
  }
}
