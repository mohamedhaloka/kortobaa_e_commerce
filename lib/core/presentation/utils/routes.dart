import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:kortobaa_ecommerce/auth/presentation/pages/login_page.dart';
import 'package:kortobaa_ecommerce/auth/presentation/pages/register_page.dart';
import 'package:kortobaa_ecommerce/home/presentation/pages/home_page.dart';
import 'package:kortobaa_ecommerce/main/presentation/pages/main_page.dart';
import 'package:kortobaa_ecommerce/product_details/presentation/pages/product_details_page.dart';

import '../../../cart/presentation/pages/cart_page.dart';
import '../../../category/presentation/pages/category_list_page.dart';
import '../../../favorite/presentation/pages/favorite_list_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class Routes {
  Routes._();

  static Routes I = Routes._();

  final List<RouteBase> routes = [
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: LoginPage.path,
      name: LoginPage.path,
      builder: (_, state) => const LoginPage(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RegisterPage.path,
      name: RegisterPage.path,
      builder: (_, state) => const RegisterPage(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainPage(child),
      routes: [
        GoRoute(
          path: HomePage.path,
          name: HomePage.path,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomePage()),
          routes: [
            GoRoute(
              parentNavigatorKey: rootNavigatorKey,
              path: ProductDetailsPage.path,
              name: ProductDetailsPage.path,
              builder: (_, state) => ProductDetailsPage(state.extra as String),
            ),
          ],
        ),
        GoRoute(
          path: CartPage.path,
          name: CartPage.path,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: CartPage()),
        ),
        GoRoute(
          path: CategoryListPage.path,
          name: CategoryListPage.path,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: CategoryListPage()),
          builder: (context, state) => const CategoryListPage(),
        ),
        GoRoute(
          path: FavoriteListPage.path,
          name: FavoriteListPage.path,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: FavoriteListPage()),
        ),
        GoRoute(
          path: ProfilePage.path,
          name: ProfilePage.path,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProfilePage()),
        ),
      ],
    ),
  ];
}
