import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kortobaa_ecommerce/auth/data/datasource/local/auth_local_data_source.dart';
import 'package:kortobaa_ecommerce/auth/data/datasource/remote/auth_remote_data_source.dart';
import 'package:kortobaa_ecommerce/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:kortobaa_ecommerce/auth/domain/repositories/auth_repository.dart';
import 'package:kortobaa_ecommerce/core/data/models/exceptions.dart';
import 'package:kortobaa_ecommerce/core/domain/entities/failures.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockAuthLocalDataSource mockAuthLocalDataSource;
  late AuthRepository authRepository;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    authRepository =
        AuthRepositoryImpl(mockAuthRemoteDataSource, mockAuthLocalDataSource);
  });

  void setUpMockRemoteDataSourceSuccess() {
    when(() => mockAuthRemoteDataSource.login(
          username: any(named: 'username'),
          password: any(named: 'password'),
        )).thenAnswer((_) async => '');
  }

  void setUpMockRemoteDataSourceFail([Object? exception]) {
    when(() => mockAuthRemoteDataSource.login(
          username: any(named: 'username'),
          password: any(named: 'password'),
        )).thenThrow(exception ?? const ServerException());
  }

  group('updateMyProfile', () {
    test('Should mockAccountRemoteDataSource has called once', () async {
      //append
      setUpMockRemoteDataSourceSuccess();
      //act
      await authRepository.login(username: '', password: '');
      //assert
      verify(() => mockAuthRemoteDataSource.login(
            username: any(named: 'username'),
            password: any(named: 'password'),
          )).called(1);
    });

    test('Should return [UserData] when remote data source success', () async {
      //append
      setUpMockRemoteDataSourceSuccess();
      //act
      final result = await authRepository.login(username: '', password: '');
      //assert
      expect(result, equals(right('')));
    });

    test(
        'Should return [ServerFailure] when remote data source throw [ServerError]',
        () async {
      //append
      setUpMockRemoteDataSourceFail();
      //act
      final result = await authRepository.login(username: '', password: '');
      //assert
      expect(result, equals(const TypeMatcher<Left<Failure, String>>()));
    });

    test(
        'Should return [ServerFailure] when remote data source throw [DioError]',
        () async {
      //append
      final request = RequestOptions(path: 'path', data: {'detail': 'Error'});
      setUpMockRemoteDataSourceFail(DioException(
        requestOptions: request,
        response: Response(requestOptions: request),
      ));
      //act
      final result = await authRepository.login(username: '', password: '');
      //assert
      expect(result, equals(const TypeMatcher<Left<Failure, String>>()));
    });
  });
}
