import 'package:kortobaa_ecommerce/category/domain/entities/category.dart';

class CategoryModel {
  final int id;
  final String name;
  final String imageLink;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageLink,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        name: json['name'],
        imageLink: json['image_link'],
      );
}

extension CategoryModelToDomain on CategoryModel {
  Category toDomain() => Category(id: id, name: name, imageLink: imageLink);
}

extension CategoryToData on Category {
  CategoryModel toData() =>
      CategoryModel(id: id, name: name, imageLink: imageLink);
}
