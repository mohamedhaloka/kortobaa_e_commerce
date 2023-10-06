import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<bool> setUserLoggedToken(String token);
  Future<String> getUserLoggedToken();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPreferences _preferences;
  AuthLocalDataSourceImpl(this._preferences);

  @override
  Future<String> getUserLoggedToken() async {
    final String? token = _preferences.getString('token');

    if (token != null) {
      return token;
    } else {
      throw Exception();
    }
  }

  @override
  Future<bool> setUserLoggedToken(String token) async {
    final bool hasStoreToken = await _preferences.setString('token', token);

    return hasStoreToken;
  }
}
