import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kortobaa_ecommerce/auth/presentation/pages/login_page.dart';
import 'package:kortobaa_ecommerce/core/presentation/themes/app_theme.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/generated/translation/translations.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/routes.dart';
import 'package:kortobaa_ecommerce/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> {
  Locale _locale = const Locale('ar');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kortobaa E-Commerce',
      localizationsDelegates: Translations.localizationsDelegates,
      supportedLocales: Translations.supportedLocales,
      locale: _locale,
      theme: Theme.of(context).appTheme(Brightness.light).getThemeData(context),
      darkTheme:
          Theme.of(context).appTheme(Brightness.dark).getThemeData(context),
      themeMode: ThemeMode.light,
      routerConfig: _goRouterConfig,
    );
  }
}

final _goRouterConfig = GoRouter(
  initialLocation: LoginPage.path,
  navigatorKey: rootNavigatorKey,
  routes: Routes.I.routes,
);
