import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kortobaa_ecommerce/home/data/models/product_model.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductModel> getProductById(String id);
}

@LazySingleton(as: ProductDetailsRemoteDataSource)
class ProductDetailsRemoteDataSourceImpl
    extends ProductDetailsRemoteDataSource {
  final Dio _dio;
  ProductDetailsRemoteDataSourceImpl(this._dio);
  @override
  Future<ProductModel> getProductById(String id) async {
    final response = await _dio.get('/api/v1/products/$id');

    if (response.statusCode == 200) {
      return ProductModel.fromJson(response.data[0]);
    } else {
      throw Exception();
    }
  }
}
