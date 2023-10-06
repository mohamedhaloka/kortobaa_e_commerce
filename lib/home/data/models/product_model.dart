import 'package:kortobaa_ecommerce/home/domain/entities/product.dart';

class ProductModel {
  final int id;
  int quantity;
  final String name;
  final String imageLink;
  final String price;
  final String description;
  final String rate;

  ProductModel({
    required this.id,
    required this.name,
    required this.imageLink,
    required this.price,
    required this.quantity,
    required this.description,
    required this.rate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        imageLink: json['image_link'],
        price: json['price'],
        quantity: json['quantity'] ?? 1,
        description: json['description'],
        rate: json['rate'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image_link': imageLink,
        'price': price,
        'quantity': quantity,
        'description': description,
        'rate': rate,
      };
}

extension ProductModelToDomain on ProductModel {
  Product toDomain() => Product(
        id: id,
        name: name,
        imageLink: imageLink,
        price: price,
        quantity: quantity,
        description: description,
        rate: rate,
      );
}

extension ProductToData on Product {
  ProductModel toData() => ProductModel(
        id: id,
        name: name,
        imageLink: imageLink,
        quantity: quantity,
        price: price,
        description: description,
        rate: rate,
      );
}
