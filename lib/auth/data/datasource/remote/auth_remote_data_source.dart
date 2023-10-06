import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/models/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<String> login({required String username, required String password});
  Future<String> register({
    required String username,
    required String password,
    required String email,
    required String firstName,
    required String lastName,
  });
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Dio _dio;
  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<String> login({
    required String username,
    required String password,
  }) async {
    final rawData = {
      'username': username,
      'password': password,
    };
    final response = await _dio.post(
      '/users/login/',
      data: json.encode(rawData),
    );

    if (response.statusCode == 200) {
      return response.data['access'];
    } else {
      throw ServerException(
        message: json.encode(response.data),
      );
    }
  }

  @override
  Future<String> register({
    required String username,
    required String password,
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    final rawData = {
      'username': username,
      'password': password,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
    };
    final response = await _dio.post(
      '/users/register/',
      data: json.encode(rawData),
    );

    if (response.statusCode == 200) {
      return response.data['message'];
    } else {
      throw ServerException(
        message: json.encode(response.data),
      );
    }
  }
}
