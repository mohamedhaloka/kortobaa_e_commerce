import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/category/data/models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getAllCategories();
}

@LazySingleton(as: CategoryRemoteDataSource)
class CategoryRemoteDataSourceImpl extends CategoryRemoteDataSource {
  final Dio _dio;
  CategoryRemoteDataSourceImpl(this._dio);

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final response = await _dio.get('/api/v1/categories');

    if (response.statusCode == 200) {
      return List.of(response.data['results'])
          .map((e) => CategoryModel.fromJson(e))
          .toList();
    } else {
      throw Exception();
    }
  }
}
