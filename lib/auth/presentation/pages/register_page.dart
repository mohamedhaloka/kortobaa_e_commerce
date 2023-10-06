import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:kortobaa_ecommerce/auth/presentation/cubits/register_cubit.dart';
import 'package:kortobaa_ecommerce/auth/presentation/pages/login_page.dart';
import 'package:kortobaa_ecommerce/auth/presentation/widgets/text_field_with_title.dart';
import 'package:kortobaa_ecommerce/core/presentation/blocs/base_states/base_state.dart';
import 'package:kortobaa_ecommerce/core/presentation/themes/app_theme.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/generated/generated_assets/assets.gen.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/generated/translation/translations.dart';
import 'package:kortobaa_ecommerce/core/presentation/widgets/screen_loader.dart';
import 'package:kortobaa_ecommerce/core/presentation/widgets/screen_utils.dart';
import 'package:kortobaa_ecommerce/injection.dart';

class RegisterPage extends StatefulWidget {
  static String path = '/registerPage';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with ScreenLoader, ScreenUtils<RegisterPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  final RegisterCubit registerCubit = getIt<RegisterCubit>();

  bool passwordIsHidden = true;
  bool confirmPasswordIsHidden = true;

  @override
  Widget screen(BuildContext context) {
    final Translations tr = Translations.of(context)!;
    final ThemeData themeData = Theme.of(context);
    return BlocListener<RegisterCubit, BaseState>(
      bloc: registerCubit,
      listener: (_, state) {
        switch (state.status) {
          case BaseStatus.inProgress:
            startLoading();
            break;
          case BaseStatus.success:
            showSuccess(customMessage: state.item);
            stopLoading();
            context.pushNamed(LoginPage.path);
            break;
          case BaseStatus.failure:
            showError(failure: state.failure);
            stopLoading();
            break;
          default:
            break;
        }
      },
      child: FormBuilder(
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
                  tr.newAccount,
                  textAlign: TextAlign.center,
                  style: themeData.textTheme.titleLarge!.copyWith(
                    color: themeData.appColors.secondaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 48),
                child: Text(
                  tr.welcomePleaseFillYourData,
                  textAlign: TextAlign.center,
                ),
              ),
              TitleWithTextField(
                title: tr.username,
                name: RegisterPageInputsKey.username.name,
                validator: FormBuilderValidators.required(
                    errorText: tr.thisFieldRequired),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              TitleWithTextField(
                title: tr.email,
                name: RegisterPageInputsKey.email.name,
                validator: FormBuilderValidators.required(
                    errorText: tr.thisFieldRequired),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              TitleWithTextField(
                title: tr.firstName,
                name: RegisterPageInputsKey.firstName.name,
                validator: FormBuilderValidators.required(
                    errorText: tr.thisFieldRequired),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              TitleWithTextField(
                title: tr.lastName,
                name: RegisterPageInputsKey.lastName.name,
                validator: FormBuilderValidators.required(
                    errorText: tr.thisFieldRequired),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              TitleWithTextField(
                  title: tr.password,
                  name: RegisterPageInputsKey.password.name,
                  validator: FormBuilderValidators.required(
                      errorText: tr.thisFieldRequired),
                  textInputAction: TextInputAction.next,
                  obscureText: passwordIsHidden,
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => passwordIsHidden = !passwordIsHidden),
                    icon: Icon(passwordIsHidden
                        ? Icons.visibility_off_rounded
                        : Icons.visibility),
                  )),
              const SizedBox(height: 12),
              TitleWithTextField(
                title: tr.confirmPassword,
                name: RegisterPageInputsKey.confirmPassword.name,
                validator: FormBuilderValidators.required(
                    errorText: tr.thisFieldRequired),
                textInputAction: TextInputAction.done,
                obscureText: confirmPasswordIsHidden,
                suffixIcon: IconButton(
                  onPressed: () => setState(
                      () => confirmPasswordIsHidden = !confirmPasswordIsHidden),
                  icon: Icon(confirmPasswordIsHidden
                      ? Icons.visibility_off_rounded
                      : Icons.visibility),
                ),
              ),
              const SizedBox(height: 22),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState?.save();

                  if (!(_formKey.currentState?.validate() ?? false)) return;

                  registerCubit.register(
                    username: _formKey.currentState!
                        .fields[RegisterPageInputsKey.username.name]!.value,
                    password: _formKey.currentState!
                        .fields[RegisterPageInputsKey.password.name]!.value,
                    lastName: _formKey.currentState!
                        .fields[RegisterPageInputsKey.lastName.name]!.value,
                    firstName: _formKey.currentState!
                        .fields[RegisterPageInputsKey.firstName.name]!.value,
                    email: _formKey.currentState!
                        .fields[RegisterPageInputsKey.email.name]!.value,
                  );
                },
                child: Text(tr.register),
              ),
              const SizedBox(height: 38),
              Text.rich(
                TextSpan(
                    text: '${tr.haveAnAccount}   ',
                    children: [
                      TextSpan(
                        text: tr.login,
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

enum RegisterPageInputsKey {
  username,
  password,
  confirmPassword,
  email,
  firstName,
  lastName;
}
