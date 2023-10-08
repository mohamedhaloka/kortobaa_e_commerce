import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kortobaa_ecommerce/category/domain/entities/category.dart';
import 'package:kortobaa_ecommerce/category/presentation/cubits/get_category_list_cubit.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/core/presentation/themes/app_theme.dart';
import 'package:kortobaa_ecommerce/core/presentation/widgets/error_view.dart';
import 'package:kortobaa_ecommerce/core/presentation/widgets/loader.dart';
import 'package:kortobaa_ecommerce/home/presentation/pages/home_page.dart';
import 'package:kortobaa_ecommerce/injection.dart';

import '../../../core/presentation/utils/generated/translation/translations.dart';
import '../../../core/presentation/utils/sliver_grid_delegate_with_fixed_height.dart';

class CategoryListPage extends StatefulWidget {
  static String path = '/categoryListPage';
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final GetCategoryListCubit _getCategoryListCubit =
      getIt<GetCategoryListCubit>();

  @override
  void initState() {
    _getCategoryListCubit.getAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Translations tr = Translations.of(context)!;
    final Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: Text(tr.category),
        centerTitle: true,
        elevation: 3,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: BlocBuilder<GetCategoryListCubit, BaseState<List<Category>>>(
        bloc: _getCategoryListCubit,
        builder: (_, state) {
          if (state.isInProgress) {
            return const Loader();
          } else if (state.isSuccess) {
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                crossAxisCount: screenSize.width > 500 ? 3 : 1,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                height: 150,
              ),
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, index) => InkWell(
                onTap: () => context.goNamed(HomePage.path),
                child: SizedBox(
                  height: 150,
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox.expand(
                          child: Image.network(
                            state.item![index].imageLink,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox.expand(
                          child: Container(
                            color: Colors.black12,
                          ),
                        ),
                        Text(
                          state.item![index].name,
                          style: themeData.textTheme.headlineSmall!.copyWith(
                            color: themeData.appColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              itemCount: state.item!.length,
            );
          } else {
            return ErrorView(failure: state.failure);
          }
        },
      ),
    );
  }
}
