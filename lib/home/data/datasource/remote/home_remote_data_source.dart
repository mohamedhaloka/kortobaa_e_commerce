import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/home/data/models/product_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ProductModel>> getProductListByCategoryId(String categoryId);
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final Dio _dio;
  HomeRemoteDataSourceImpl(this._dio);
  @override
  Future<List<ProductModel>> getProductListByCategoryId(
      String categoryId) async {
    final response = await _dio.get('/api/v1/products/category/$categoryId');

    if (response.statusCode == 200) {
      return List.from(response.data['results'])
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } else {
      throw Exception();
    }
  }
}
