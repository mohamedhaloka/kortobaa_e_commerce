import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/auth/domain/usecases/get_logged_user_token_use_case.dart';
import 'package:kortobaa_ecommerce/core/domain/usecases/use_case.dart';
import 'package:kortobaa_ecommerce/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class InjectableModule {
  @preResolve
  @lazySingleton
  Future<SharedPreferences> get sharedPref => SharedPreferences.getInstance();
  @lazySingleton
  Dio get dioInstance {
    final dio = Dio(
      BaseOptions(
          baseUrl: 'https://flutterapi.kortobaa.net',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          validateStatus: (statusCode) {
            if (statusCode != null) {
              if (200 <= statusCode && statusCode < 300) {
                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          }),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          Map<String, String> headers;

          final failureOrUser =
              await getIt<GetLoggedUserTokenUseCase>().call(const NoParams());

          failureOrUser.fold(
            (_) => _,
            (token) {
              headers = {'Authorization': 'Bearer $token'};
              request.headers.addAll(headers);
            },
          );

          request.sendTimeout = const Duration(milliseconds: 60000);
          request.connectTimeout = const Duration(milliseconds: 60000);
          request.receiveTimeout = const Duration(milliseconds: 60000);

          return handler.next(request);
        },
      ),
    );
    dio.interceptors.add(
      LogInterceptor(
          responseBody: true,
          requestBody: true,
          logPrint: (obj) {
            debugPrint(obj.toString());
          }),
    );
    return dio;
  }
}
