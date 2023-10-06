import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kortobaa_ecommerce/auth/data/datasource/remote/auth_remote_data_source.dart';
import 'package:kortobaa_ecommerce/core/data/models/exceptions.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late AuthRemoteDataSource authRemoteDataSource;

  setUp(() {
    mockDio = MockDio();
    when(() => mockDio.options).thenReturn(BaseOptions());

    authRemoteDataSource = AuthRemoteDataSourceImpl(mockDio);
  });

  void setUpMockDio(int statusCode, [Object? data]) {
    final response = Response(
      requestOptions: RequestOptions(path: 'path'),
      statusCode: statusCode,
      data: data ?? {'access': 'xxxxxxxx'},
    );
    when(() => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        )).thenAnswer((invocation) async => response);
  }

  group('updateProfile', () {
    test('Should mockDio called once', () async {
      //append
      setUpMockDio(200);
      //act
      await authRemoteDataSource.login(username: '', password: '');
      //assert
      verify(() => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).called(1);
    });

    test('Should return UserData when dio success', () async {
      //append
      setUpMockDio(200);
      //act
      final result =
          await authRemoteDataSource.login(username: '', password: '');
      //assert
      expect(result, const TypeMatcher<String>());
    });

    test('Should throw [ServerException] when dio error', () async {
      //append
      setUpMockDio(500, 'error');
      //act
      final result = authRemoteDataSource.login(username: '', password: '');
      //assert
      expect(result, throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('deleteAccount', () {
    test('Should mockDio called once', () async {
      //append
      setUpMockDio(200);
      //act
      await authRemoteDataSource.login(username: '', password: '');
      //assert
      verify(() => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).called(1);
    });

    test('Should throw [ServerException] when dio error', () async {
      //append
      setUpMockDio(500, 'error');
      //act
      final result = authRemoteDataSource.login(username: '', password: '');
      //assert
      expect(result, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
