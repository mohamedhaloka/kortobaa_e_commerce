import 'package:flutter/material.dart';
import 'package:kortobaa_ecommerce/auth/presentation/cubits/remove_user_token_cubit.dart';
import 'package:kortobaa_ecommerce/core/presentation/utils/generated/translation/translations.dart';
import 'package:kortobaa_ecommerce/injection.dart';

class ProfilePage extends StatefulWidget {
  static String path = '/profilePage';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final RemoveUserTokenCubit _removeUserTokenCubit =
      getIt<RemoveUserTokenCubit>();

  @override
  Widget build(BuildContext context) {
    final Translations tr = Translations.of(context)!;
    final Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.profile),
      ),
      body: SizedBox(
        width: screenSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _removeUserTokenCubit.removeUserToken,
              child: Text(tr.logOut),
            ),
          ],
        ),
      ),
    );
  }
}
