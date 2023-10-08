import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kortobaa_ecommerce/cart/presentation/cubits/get_cart_product_list_cubit.dart';
import 'package:kortobaa_ecommerce/cart/presentation/pages/cart_page.dart';
import 'package:kortobaa_ecommerce/category/presentation/pages/category_list_page.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/core/presentation/themes/app_theme.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/generated/translation/translations.dart';
import 'package:kortobaa_ecommerce/favorite/presentation/pages/favorite_list_page.dart';
import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';
import 'package:kortobaa_ecommerce/home/presentation/pages/home_page.dart';
import 'package:kortobaa_ecommerce/injection.dart';
import 'package:kortobaa_ecommerce/main/presentation/utils/bottom_item_model.dart';
import 'package:kortobaa_ecommerce/profile/presentation/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage(this.child, {super.key});
  final Widget child;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<BottomItemModel> _items = <BottomItemModel>[];

  String? _currentRoute;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _items = [
        BottomItemModel(
          title: Translations.of(context)!.home,
          route: HomePage.path,
          icon: Icons.home,
        ),
        BottomItemModel(
          title: Translations.of(context)!.category,
          route: CategoryListPage.path,
          icon: Icons.category,
        ),
        BottomItemModel(
          title: Translations.of(context)!.favorite,
          route: FavoriteListPage.path,
          icon: Icons.favorite,
        ),
        BottomItemModel(
          title: Translations.of(context)!.profile,
          route: ProfilePage.path,
          icon: Icons.person,
        ),
      ];
      _currentRoute = _items.first.route;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
        body: widget.child,
        floatingActionButton: _currentRoute == HomePage.path
            ? null
            : _CartFloatingBtn(
                onPressed: () {
                  if (_currentRoute == CartPage.path) return;
                  context.pushNamed(CartPage.path);
                  _currentRoute = CartPage.path;
                  setState(() {});
                },
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          height: kToolbarHeight,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _items
                .map((e) => Expanded(
                      child: InkWell(
                        onTap: () {
                          if (_currentRoute == e.route) return;
                          setState(() => _currentRoute = e.route);
                          context.pushNamed(_currentRoute!);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              e.icon,
                              color: _currentRoute == e.route
                                  ? themeData.appColors.secondaryColor
                                  : themeData.disabledColor,
                            ),
                            Text(
                              e.title,
                              style: themeData.textTheme.bodySmall!.copyWith(
                                color: _currentRoute == e.route
                                    ? themeData.appColors.secondaryColor
                                    : themeData.disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ));
  }
}

class _CartFloatingBtn extends StatefulWidget {
  const _CartFloatingBtn({required this.onPressed});
  final void Function() onPressed;

  @override
  State<_CartFloatingBtn> createState() => _CartFloatingBtnState();
}

class _CartFloatingBtnState extends State<_CartFloatingBtn> {
  final GetCartProductListCubit _getCartProductListCubit =
      getIt<GetCartProductListCubit>();

  @override
  void initState() {
    _getCartProductListCubit.getCartProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return BlocBuilder<GetCartProductListCubit, BaseState<List<Product>>>(
        bloc: _getCartProductListCubit,
        builder: (_, state) => FloatingActionButton(
              backgroundColor: Theme.of(context).appColors.secondaryColor,
              onPressed: widget.onPressed,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if ((state.item ?? []).isNotEmpty)
                    Text((state.item ?? []).length.toString()),
                  Icon(
                    Icons.shopping_cart,
                    color: themeData.appColors.whiteColor,
                  ),
                ],
              ),
            ));
  }
}
