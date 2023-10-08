import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:kortobaa_ecommerce/auth/presentation/cubits/get_logged_user_token_cubit.dart';
import 'package:kortobaa_ecommerce/auth/presentation/cubits/login_cubit.dart';
import 'package:kortobaa_ecommerce/auth/presentation/pages/register_page.dart';
import 'package:kortobaa_ecommerce/auth/presentation/widgets/text_field_with_title.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/core/presentation/themes/app_theme.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/generated/generated_assets/assets.gen.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/generated/translation/translations.dart';
import 'package:kortobaa_ecommerce/core/presentation/widgets/loader.dart';
import 'package:kortobaa_ecommerce/core/presentation/widgets/screen_loader.dart';
import 'package:kortobaa_ecommerce/core/presentation/widgets/screen_utils.dart';
import 'package:kortobaa_ecommerce/home/presentation/pages/home_page.dart';
import 'package:kortobaa_ecommerce/injection.dart';

class LoginPage extends StatefulWidget {
  static String path = '/loginPage';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with ScreenLoader, ScreenUtils<LoginPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  final LoginCubit loginCubit = getIt<LoginCubit>();

  final GetLoggedUserTokenCubit _getLoggedUserTokenCubit =
      getIt<GetLoggedUserTokenCubit>();
  bool checkingLocalToken = true;

  @override
  void initState() {
    _getLoggedUserTokenCubit.login();

    super.initState();
  }

  bool passwordIsHidden = true;
  @override
  Widget screen(BuildContext context) {
    final Translations tr = Translations.of(context)!;
    final ThemeData themeData = Theme.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<GetLoggedUserTokenCubit, BaseState<String?>>(
          bloc: _getLoggedUserTokenCubit,
          listener: (_, state) {
            if (state.isSuccess) {
              if (state.item == null) return;
              context.goNamed(HomePage.path);
            }
            checkingLocalToken = false;
            setState(() {});
          },
        ),
        BlocListener<LoginCubit, BaseState>(
          bloc: loginCubit,
          listener: (_, state) {
            switch (state.status) {
              case BaseStatus.inProgress:
                startLoading();
                break;
              case BaseStatus.success:
                showSuccess();
                stopLoading();
                context.pushNamed(HomePage.path);
                break;
              case BaseStatus.failure:
                showError(failure: state.failure);
                stopLoading();
                break;
              default:
                break;
            }
          },
        ),
      ],
      child: checkingLocalToken
          ? const Loader()
          : FormBuilder(
              key: _formKey,
              child: Scaffold(
                body: ListView(
                  padding: const EdgeInsets.all(26),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 20),
                      child: Assets.images.authHeaderImage.image(scale: 3),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        tr.signIn,
                        textAlign: TextAlign.center,
                        style: themeData.textTheme.titleLarge!.copyWith(
                          color: themeData.appColors.secondaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 48),
                      child: Text(
                        tr.pleaseLoginToConfirmOrder,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TitleWithTextField(
                      name: LoginPageInputsKey.username.name,
                      title: tr.username,
                      validator: FormBuilderValidators.required(
                          errorText: tr.thisFieldRequired),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 12),
                    TitleWithTextField(
                        name: LoginPageInputsKey.password.name,
                        title: tr.password,
                        validator: FormBuilderValidators.required(
                            errorText: tr.thisFieldRequired),
                        textInputAction: TextInputAction.done,
                        obscureText: passwordIsHidden,
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                              () => passwordIsHidden = !passwordIsHidden),
                          icon: Icon(passwordIsHidden
                              ? Icons.visibility_off_rounded
                              : Icons.visibility),
                        )),
                    const SizedBox(height: 22),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState?.save();

                        if (!(_formKey.currentState?.validate() ?? false))
                          return;

                        loginCubit.login(
                          username: _formKey.currentState!
                              .fields[LoginPageInputsKey.username.name]!.value,
                          password: _formKey.currentState!
                              .fields[LoginPageInputsKey.password.name]!.value,
                        );
                      },
                      child: Text(tr.login),
                    ),
                    const SizedBox(height: 38),
                    Text.rich(
                      TextSpan(
                          text: '${tr.youDoNotHaveAccount}   ',
                          children: [
                            TextSpan(
                              text: tr.register,
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => context.pushNamed(RegisterPage.path),
                              style: themeData.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: themeData.appColors.secondaryColor,
                              ),
                            )
                          ],
                          style: themeData.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          )),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

enum LoginPageInputsKey {
  username,
  password;
}
